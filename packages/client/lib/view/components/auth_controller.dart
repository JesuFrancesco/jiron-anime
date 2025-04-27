import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/component_default.dart';

class AuthController extends GetxController {
  static String? profileImageUrl;
  static String? fullName;
  static String? provider;

  static Future reloadData() async {
    final user = AuthService.getUser;

    profileImageUrl = user?.userMetadata?['avatar_url'];
    fullName = user?.userMetadata?['full_name'];
    provider = user?.appMetadata['provider'];

    // user = supabase.auth.currentUser;
    // profileImageUrl = user?.userMetadata?['avatar_url'];
    // fullName = user?.userMetadata?['full_name'];
    // provider = user?.appMetadata['provider'];
  }

  static CircleAvatar getAvatarIcon({
    DefaultUserIconSize size = DefaultUserIconSize.small,
  }) => CircleAvatar(
    child:
        AuthController.profileImageUrl != null
            ? Image.network(
              AuthController.profileImageUrl!,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame == null) {
                  return child;
                }
                return child;
              },
            )
            : DefaultUserIcon(size: size),
  );

  static ClipOval getClipOvalAvatar([
    DefaultUserIconSize size = DefaultUserIconSize.medium,
  ]) => ClipOval(
    child:
        AuthController.profileImageUrl != null
            ? Image.network(
              AuthController.profileImageUrl!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            )
            : DefaultUserIcon(size: size),
  );

  @override
  void onInit() {
    super.onInit();
    reloadData();
  }
}
