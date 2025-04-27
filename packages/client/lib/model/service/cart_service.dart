import 'dart:convert';
import 'package:get/get.dart';
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/utils/query_string.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';
import 'package:jiron_anime/model/entity/models_library.dart';

import 'package:http/http.dart' as http;

class CartService {
  Future<ShoppingCart> fetchCartWithProducts() async {
    final queryParams = {
      "where[clientId]": AuthService.getClientId(),
      "include[cartItems][include][product][include][productAttachments]": true,
    };

    final response = await http.get(
      Uri.parse(
        "${Config.apiUrl}/shoppingcart/unique?${parseToQueryParams(queryParams)}",
      ),
      headers: {...getSupabaseAuthHeaders()},
    );

    final dynamic data = jsonDecode(response.body);

    return ShoppingCart.fromJson(data);
  }

  Future<List<Market>> fetchMyMarkets() async {
    final currentUser = await getSupabaseClient().auth.getUser();

    final queryParams = {
      "where[profileId]": currentUser.user!.id,
      // ponle los joins
    };

    final response = await http.get(
      Uri.parse(
        "${Config.apiUrl}/market/unique?${parseToQueryParams(queryParams)}",
      ),
      headers: {...getSupabaseAuthHeaders()},
    );

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((map) => Market.fromJson(map as Map<String, dynamic>))
        .toList();
  }

  Future<void> addProductToCart(int amount, int productId) async {
    final res = await http.post(
      Uri.parse("${Config.apiUrl}/cartitem"),
      body: json.encode({
        "data": {
          "cartId": AuthService.getShoppingCartId(),
          "amount": amount,
          "productId": productId,
        },
      }),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }
  }

  Future<void> deleteProductFromCart(int productId) async {
    final res = await http.delete(
      Uri.parse("${Config.apiUrl}/cartitem"),
      body: json.encode({
        "where": {
          "cartId_productId": {
            "cartId": AuthService.getShoppingCartId(),
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
      Get.dialog(ErrorDialog(message: "Algo salió mal\n${res.body}"));
      throw Error();
    }
  }

  Future<void> emptyShoppingCart() async {
    final res = await http.delete(
      Uri.parse("${Config.apiUrl}/cartitem/many"),
      body: json.encode({
        "where": {"cartId": AuthService.getShoppingCartId()},
      }),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal\n${res.body}"));
    }
  }
}
