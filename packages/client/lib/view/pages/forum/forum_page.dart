import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/utils/sizedbox_entension.dart';
import 'package:jiron_anime/view/theme/colors.dart';
import 'forum_detail_page.dart';
import 'package:jiron_anime/view/pages/forum/forum_users.dart';

import 'package:jiron_anime/view/pages/forum/create_forum_page.dart';

import 'package:jiron_anime/view/components/custom_appbar.dart';

class ForumPost {
  final String username;
  final String avatarUrl;
  final String question;
  final String userText;
  int likes;
  int shares;
  String imageUrl;

  List<ForumComment> comments;

  ForumPost({
    required this.username,
    required this.avatarUrl,
    required this.question,
    required this.likes,
    required this.shares,
    required this.imageUrl,
    required this.userText,
    required List<ForumComment> initialComments,
  }) : comments = initialComments;
}

final List<ForumPost> forumPosts = [
  ForumPost(
    username: users[0].name,
    avatarUrl: users[0].avatarUrl,
    question: 'Opiniones sobre el final de SNK ?????',
    likes: 20,
    shares: 5,
    imageUrl: 'https://i.blogs.es/dfe352/shingeki-no-kyojin/1366_2000.jpeg',
    userText:
        "Sinceramente, el final de SNK me dejó con sentimientos encontrados. Por un lado, entiendo el mensaje de ciclo, libertad y peso de las decisiones, pero por otro… siento que varios personajes merecían algo distinto. Aun así, no puedo negar que fue una obra impactante de principio a fin. Me dolió, me hizo pensar y sobre todo, me dejó reflexionando sobre la humanidad. No fue perfecto, pero fue valiente.",
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
    shares: 2,
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQb2R6GZxPQq0gwJj_FYVTL354y1l7Oh3usDg&s',
    userText:
        "Bakugo comenzó como el típico bully arrogante, pero su desarrollo fue una de las sorpresas más sólidas de My Hero Academia. Detrás de su agresividad hay culpa, inseguridad y un deseo profundo de ser digno del símbolo de la paz. Lo que más me impactó fue cómo, a pesar de sus defectos, empezó a entender a Deku y a reconocer sus propias fallas. Eso lo hace humano, complejo, y por eso lo considero un personaje tridimensional",
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomLayout(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar personalizada
            const CustomAppbar(title: "Foros"),
            12.pv,

            // Banner canal
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/736x/05/8e/21/058e21d79f21353511483df424dca868.jpg',
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.darken,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '#general\nHabla de cosas de la comunidad ULIMA',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            8.pv,

            Text(
              'Posts de #general',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),

            8.pv,
            // Lista de posts
            Flexible(
              flex: 1,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: forumPosts.length,
                separatorBuilder: (context, index) => 12.pv,
                itemBuilder: (context, index) {
                  final post = forumPosts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ForumDetailPage(post: post))!.then((_) {
                        // Forzar rebuild al volver para actualizar comentarios y likes
                        (context as Element).reassemble();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        // Usa color sólido en modo oscuro, gradiente en modo claro
                        color: isDarkMode ? Colors.grey[850] : null,
                        gradient:
                            isDarkMode
                                ? null
                                : LinearGradient(
                                  colors: [
                                    const Color(0xFFFFD6A5),
                                    const Color(0xFFFFC3A0),
                                  ],
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
                                      backgroundImage: NetworkImage(
                                        post.avatarUrl,
                                      ),
                                      radius: 14,
                                    ),
                                    8.ph,
                                    Text(
                                      post.username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                6.pv,
                                Text(
                                  post.question,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isDarkMode
                                            ? Colors.white
                                            : AppColors.primaryColor,
                                  ),
                                ),
                                12.pv,
                                Row(
                                  children: [
                                    _iconText(
                                      icon: Icons.thumb_up_alt_outlined,
                                      text: post.likes.toString(),
                                      onTap: () {
                                        post.likes++;
                                        (context as Element)
                                            .markNeedsBuild(); // actualiza solo este widget
                                      },
                                    ),
                                    8.ph,
                                    _iconText(
                                      icon: Icons.comment_outlined,
                                      text: post.comments.length.toString(),
                                    ),
                                    8.ph,
                                    _iconText(
                                      icon: Icons.share_outlined,
                                      text: post.shares.toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          10.ph,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: imageWidget(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateForumPage())!.then((_) {
            (context as Element).reassemble();
          });
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _iconText({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [Icon(icon, size: 16), const SizedBox(width: 4), Text(text)],
      ),
    );
  }

  Widget imageWidget(
    String path, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return path.startsWith('/')
        ? Image.file(
          File(path),
          width: width,
          height: height,
          fit: fit,
          errorBuilder:
              (context, error, stackTrace) => const Icon(Icons.broken_image),
        )
        : Image.network(
          path,
          width: width,
          height: height,
          fit: fit,
          errorBuilder:
              (context, error, stackTrace) => const Icon(Icons.broken_image),
        );
  }
}
