import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/main.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/view/pages/home/home_page.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/view/components/auth_controller.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final currentProfile = Profile().obs;

  static bool get isLoggedIn => getSupabaseClient().auth.currentSession != null;

  Future fetchCurrentProfile() async {
    final profileId = getUser!.id;

    final response = await http.get(
      Uri.parse("${Config.supabaseURL}/profile/unique?where[id]=$profileId"),
      headers: {...getSupabaseAuthHeaders()},
    );

    final dynamic data = jsonDecode(response.body);

    currentProfile.value = Profile.fromJson(data);
  }

  // static Future<void> browserGoogleSignIn() async {
  //   try {
  //     await supabase.auth.signInWithOAuth(
  //       OAuthProvider.google,
  //       redirectTo: "janime-app://main",
  //     );
  //     await AuthController.reloadData();
  //     Get.offAll(() => const HomePage(), predicate: (r) => false);
  //   } catch (e) {
  //     Get.dialog(ErrorDialog(message: "Error al iniciar sesión: $e"));
  //   }
  // }

  static Future nativeGoogleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: Config.googleWebClientId,
        clientId: Config.googleAndroidClientId,
      );

      final googleUser = await googleSignIn.signIn();
      assert(googleUser != null, "No se ha encontrado el usuario de Google");

      final googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
        throw Exception('Google sign-in failed: Missing access or ID token');
      }
      final gAccessToken = googleAuth?.accessToken;
      assert(gAccessToken != null, "No se ha encontrado el token de acceso");

      final gIdToken = googleAuth?.idToken;
      assert(gIdToken != null, "No se ha encontrado el token de acceso");

      print("Google access token: $gAccessToken");
      print("Google id token: $gIdToken");
      print("Google user: ${googleUser?.email}");

      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: gIdToken!,
        accessToken: gAccessToken,
      );

      Get.offAll(() => const HomePage(), predicate: (r) => false);
    } catch (e) {
      Get.dialog(ErrorDialog(message: "Error al iniciar sesión: $e"));
      rethrow;
    }
  }

  static Future<void> discordSignIn() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.discord,
        redirectTo: "janime-app://main",
      );
      Get.offAll(() => const HomePage(), predicate: (r) => false);
    } catch (e) {
      Get.dialog(ErrorDialog(message: "Error al iniciar sesión: $e"));
    }
  }

  static Future<void> logout() async {
    await supabase.auth.signOut();
    await AuthController.reloadData();
    Get.offAll(() => const HomePage(), predicate: (r) => false);
  }

  static void setupAuthListener() {
    final _ = supabase.auth.onAuthStateChange.listen((data) async {
      await AuthController.reloadData();
    });
  }

  // Profile
  static User? get getUser => supabase.auth.currentUser;

  // Client id's
  static String getProfileId() => getSupabaseClient().auth.currentUser!.id;

  static int getClientId() =>
      getSupabaseClient().auth.currentUser!.userMetadata!["client_id"];

  static int getShoppingCartId() =>
      getSupabaseClient().auth.currentUser!.userMetadata!["cart_id"];

  static int getWishlistId() =>
      getSupabaseClient().auth.currentUser!.userMetadata!["wishlist_id"];
}
