import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiron_anime/main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    if (supabase.auth.currentSession == null) {
      return const RouteSettings(name: "/sign-in");
    }

    return super.redirect(route);
  }
}
