import 'dart:convert';
import 'package:get/get.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/entity/wishlist.dart';
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/utils/query_string.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';

class WishlistService {
  Future<Wishlist> fetchMyWishlist() async {
    final queryParams = {
      "where[id]": AuthService.getWishlistId(),
      "include[wishlistItems][include][product][include][productAttachments]":
          true,
    };

    final res = await http.get(
      Uri.parse(
        "${Config.apiUrl}/wishlist/unique?${parseToQueryParams(queryParams)}",
      ),
      headers: getSupabaseAuthHeaders(),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salio mal.\n${res.body}"));
    }

    final dynamic data = jsonDecode(res.body);

    return Wishlist.fromJson(data);
  }

  Future<Wishlist?> addItemToMyWishlist(int productId) async {
    final res = await http.post(
      Uri.parse("${Config.apiUrl}/wishlistitem"),
      body: json.encode({
        "data": {
          "wishlistId": AuthService.getWishlistId(),
          "productId": productId,
        },
      }),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salio mal.\n${res.body}"));
      return null;
    }

    final dynamic data = jsonDecode(res.body);

    return Wishlist.fromJson(data);
  }

  Future<Wishlist> removeItemFromWishlist(int productId) async {
    final res = await http.delete(
      Uri.parse("${Config.apiUrl}/wishlistitem"),
      body: json.encode({
        "where": {
          "wishlistId_productId": {
            "wishlistId": AuthService.getWishlistId(),
            "productId": productId,
          },
        },
      }),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salio mal.\n${res.body}"));
    }

    final dynamic data = jsonDecode(res.body);

    return Wishlist.fromJson(data);
  }
}
