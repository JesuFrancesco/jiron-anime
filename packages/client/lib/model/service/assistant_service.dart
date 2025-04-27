import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jiron_anime/config/config.dart';
import 'package:logger/logger.dart';

class AssistantService {
  final String apiKey = Config.hfToken;

  Stream<String> enviarMensaje(String consulta) async* {
    final url = Uri.parse(
      'https://router.huggingface.co/nebius/v1/chat/completions',
    );

    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "model": "deepseek-ai/DeepSeek-V3-0324-fast",
      "messages": [
        {
          "role": "user",
          "content":
              "Eres un asistente de una e-commerce llamada 'Jirón Anime', responde la siguiente consulta:\n$consulta",
        },
      ],
      "max_tokens": 512,
      "stream": true,
    });

    final logger = Logger();

    final client = http.Client();
    final request =
        http.Request('POST', url)
          ..headers.addAll(headers)
          ..body = body;

    final response = await client.send(request);

    if (response.statusCode == 200) {
      final stream = response.stream.transform(utf8.decoder);

      await for (var chunk in stream) {
        if (chunk.startsWith('data: ') && !chunk.contains("[DONE]")) {
          final cleanChunk = chunk.substring(6).trim();
          try {
            final data = jsonDecode(cleanChunk);
            if (data['choices'] != null && data['choices'].isNotEmpty) {
              final content = data['choices'][0]['delta']['content'];
              yield content;
            }
          } catch (e) {
            print('Error decoding JSON: $e');
          }
        }
      }
    } else {
      logger.e('Error: ${response.statusCode}');
      logger.e('Error: ${await response.stream.bytesToString()}');
    }
  }
}
