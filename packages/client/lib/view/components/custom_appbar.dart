import 'package:flutter/material.dart';
import 'package:jiron_anime/view/components/boton_retroceso.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool showAvatar;

  const CustomAppbar({super.key, this.title = "", this.showAvatar = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (Navigator.of(context).canPop()) const BotonRetroceso(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
        if (showAvatar) AuthController.getAvatarIcon(),
      ],
    );
  }
}
