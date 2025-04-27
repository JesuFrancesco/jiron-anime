import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/custom_layout.dart';
import 'package:jiron_anime/view/theme/colors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomLayout(
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(baseColor: AppColors.primaryColor),
          ),
          vsync: this,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Jiron Anime",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontSize: 48),
                ),
                const Image(image: AssetImage("assets/image/logo.png")),
                TextButton.icon(
                  onPressed: AuthService.nativeGoogleSignIn,
                  icon: const ImageIcon(
                    AssetImage("assets/image/google_icon.png"),
                    color: Colors.black,
                  ),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  label: const Text(
                    "Iniciar sesión con Google",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton.icon(
                  onPressed: AuthService.discordSignIn,
                  icon: const ImageIcon(
                    AssetImage("assets/image/discord_icon.png"),
                    color: Colors.white,
                  ),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF5865F2)),
                  ),
                  label: const Text(
                    "Iniciar sesión con Discord",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
