import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/entity/models_library.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/utils/query_string.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';

class MarketService {
  Future<List<Market>> fetchMyMarkets() async {
    List<Market> markets = [];

    final queryParams = {
      "where[profileId]": AuthService.getProfileId(),
      "include[products][where][status]": 1,
    };

    final res = await http.get(
      Uri.parse("${Config.apiUrl}/market?${parseToQueryParams(queryParams)}"),
      headers: getSupabaseAuthHeaders(),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final List<dynamic> data = jsonDecode(res.body);
    markets =
        data
            .map((map) => Market.fromJson(map as Map<String, dynamic>))
            .toList();

    return markets;
  }

  Future<Market> createNewMarket(Market mercado) async {
    final res = await http.post(
      Uri.parse("${Config.apiUrl}/market"),
      body: json.encode({"data": mercado.toJson()}),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salió mal.\n${res.body}"));
    }

    final dynamic data = jsonDecode(res.body);

    return Market.fromJson(data);
  }

  Future<void> deleteMarket(int mercadoId) async {
    final res = await http.delete(
      Uri.parse("${Config.apiUrl}/market"),
      body: json.encode({
        "where": {"id": mercadoId},
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

  Future<void> updateExistingProduct(Product producto, int marketId) async {
    final res = await http.put(
      Uri.parse("${Config.apiUrl}/market"),
      body: json.encode({
        "where": {"id": marketId},
        "data": {
          "products": {
            "update": {
              "where": {"id": producto.id!},
              "data": {"price": producto.price, "stock": producto.stock},
            },
          },
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

  Future<void> deleteProductFromMarket(int productId, int marketId) async {
    final res = await http.put(
      Uri.parse("${Config.apiUrl}/market"),
      body: json.encode({
        "where": {"id": marketId},
        "data": {
          "products": {
            "update": {
              "where": {"id": productId},
              "data": {"status": 0},
            },
          },
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

  Future<Market> createNewProduct(Product producto, int marketId) async {
    final res = await http.put(
      Uri.parse("${Config.apiUrl}/market"),
      body: json.encode({
        "where": {"id": marketId},
        "data": {
          "products": {
            "create": {
              ...producto.toJson(),
              if (producto.brandSeller != null)
                "brandSeller": {"create": producto.brandSeller},
              if (producto.productTags != null)
                "productTags": {
                  "create":
                      producto.productTags!
                          .map((e) => e.tag!)
                          .map(
                            (e) => ({
                              "tag": {
                                "connectOrCreate": {
                                  "where": {"name": e.name},
                                  "create": {"name": e.name},
                                },
                              },
                            }),
                          )
                          .toList(),
                },
              if (producto.productAttachments != null)
                "productAttachments": {
                  "create": List.from(producto.productAttachments!),
                },
            },
          },
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

    final dynamic data = jsonDecode(res.body);

    return Market.fromJson(data);
  }
}
