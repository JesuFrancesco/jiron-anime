import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'forum_detail_page.dart';
import 'package:jiron_anime/view/pages/forum/forum_users.dart';



class ForumPost {
  final String username;
  final String avatarUrl;
  final String question;
  final int likes;
  final int comments;
  final int shares;
  final String imageUrl;
  final List<ForumComment> initialComments;

  ForumPost({
    required this.username,
    required this.avatarUrl,
    required this.question,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.imageUrl,
    required this.initialComments,
  });
}

final List<ForumPost> forumPosts = [
  ForumPost(
    username: users[0].name,
    avatarUrl: users[0].avatarUrl,
    question: 'Opiniones sobre el final de SNK ?????',
    likes: 20,
    comments: 20,
    shares: 5,
    imageUrl: 'https://i.imgur.com/83e4F9v.jpeg',
    initialComments: [
      ForumComment(
        username: users[0].name,
        avatarUrl: users[0].avatarUrl,
        content: 'Me hizo llorar la escena final...',
      ),
      ForumComment(
        username: users[1].name,
        avatarUrl: users[1].avatarUrl,
        content: 'No entendí del todo el mensaje...',
      ),
    ],
  ),
  ForumPost(
    username: users[1].name,
    avatarUrl: users[1].avatarUrl,
    question: 'Para ustedes Bakugo es un personaje tridimensional?',
    likes: 15,
    comments: 10,
    shares: 2,
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUTl1o7k2r8-PpM43M-r_dd4F0vkCStwER2Ho2mgeK6R1zETXysErDtUuOB8w63tBMlSPbos897ICjtH3nwSVV-9Grg7vJjmtZ9G3A1KY',
    initialComments: [
      ForumComment(
        username: users[0].name,
        avatarUrl: users[0].avatarUrl,
        content: 'Sí, tiene una evolución brutal.',
      ),
    ],
  ),
];

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomLayout(
        child: Column(
          children: [
            // AppBar personalizada
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                const Text(
                  'Foros',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                AuthController.getClipOvalAvatar(),
              ],
            ),
            12.pv,
            // Banner canal
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage('https://i.imgur.com/Cj7hHqT.jpeg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '#general\nHabla de cosas de la comunidad ULIMA',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Posts de #general',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            // Lista de posts
            Expanded(
              child: ListView.builder(
                itemCount: forumPosts.length,
                itemBuilder: (context, index) {
                  final post = forumPosts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ForumDetailPage(post: post));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFD6A5), Color(0xFFFFC3A0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(post.avatarUrl),
                                      radius: 14,
                                    ),
                                    8.ph,
                                    Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                6.pv,
                                Text(post.question, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.w600)),
                                12.pv,
                                Row(
                                  children: [
                                    _iconText(Icons.thumb_up_alt_outlined, post.likes.toString()),
                                    8.ph,
                                    _iconText(Icons.comment_outlined, post.comments.toString()),
                                    8.ph,
                                    _iconText(Icons.share_outlined, post.shares.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              post.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
