import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/entity/local_message.dart';
import 'package:jiron_anime/view/components/custom_appbar.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:intl/intl.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(Uri.parse(Config.webSocketURL));

  final List<LocalMessage> _messages = [];

  bool conectado = false;

  @override
  void initState() {
    super.initState();

    _channel.stream.listen((message) {
      setState(() {
        conectado = true;
        final jsonMessage = jsonDecode(message);
        final newMessage = LocalMessage.fromJson(jsonMessage);
        _messages.add(newMessage);
      });
    }, onError: (payload) => setState(() => conectado = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppbar(title: "Foro"),
            32.pv,
            Text(
              'Estado del servidor: ${conectado ? "Conectado" : "Desconectado"}',
              style: Theme.of(context).textTheme.titleMedium!,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return ListTile(
                    title: Text(message.message),
                    subtitle: Text(
                      '${message.sender} - ${DateFormat('dd/MM/yyyy HH:mm').format(message.createdAt)}',
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Enviar mensaje',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
      setState(() {
        _messages.add(
          LocalMessage(
            sender: "Yo",
            message: _controller.text,
            createdAt: DateTime.now(),
          ),
        );
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
