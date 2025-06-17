import 'package:flutter/material.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/view/pages/forum/forum_page.dart'; // para ForumPost
import 'package:jiron_anime/view/pages/forum/forum_users.dart';


class ForumComment {
  final String username;
  final String avatarUrl;
  final String content;

  ForumComment({
    required this.username,
    required this.avatarUrl,
    required this.content,
  });
}

class ForumDetailPage extends StatefulWidget {
  final ForumPost post;
  const ForumDetailPage({super.key, required this.post});

  @override
  State<ForumDetailPage> createState() => _ForumDetailPageState();
}

class _ForumDetailPageState extends State<ForumDetailPage> {
  late List<ForumComment> staticComments ;

    @override
    void initState() {
      super.initState();
      staticComments = [...widget.post.comments];
    }

  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
  if (_commentController.text.trim().isEmpty) return;
  setState(() {
  final newComment = ForumComment(
    username: AuthController.fullName ?? 'Anónimo',
    avatarUrl: users.last.avatarUrl,
    content: _commentController.text.trim(),
  );
  staticComments.add(newComment);
  widget.post.comments.add(newComment); // <-- importante para reflejar fuera
});
}

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Scaffold(
      body: CustomLayout(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(color: Colors.black),
                const Text('Post', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                AuthController.getClipOvalAvatar(),
              ],
            ),
            12.pv,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC3A0),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(post.avatarUrl),
                                radius: 16
                              ),
                              8.ph,
                              Text(post.username,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          8.pv,
                          Text(
                            post.question,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                          ),
                          8.pv,
                          const Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s…'
                          ),
                          8.pv,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(post.imageUrl, height: 140),
                          ),
                          12.pv,
                          Row(
                            children: [
                              _iconText(Icons.thumb_up, post.likes.toString()),
                              8.ph,
                              _iconText(Icons.comment, post.comments.length.toString()),
                              8.ph,
                              _iconText(Icons.share, post.shares.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    16.pv,
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Comentarios',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple
                        ),
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: staticComments.length,
                      itemBuilder: (context, i) {
                        final c = staticComments[i];
                        return ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(c.avatarUrl)),
                          title: Text(c.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(c.content),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Escribe un comentario...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _addComment,
                  icon: const Icon(Icons.send, color: Colors.orange),
                ),
              ],
            ),
            8.pv,
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(children: [Icon(icon, size: 16), 4.ph, Text(text)]);
  }
}
