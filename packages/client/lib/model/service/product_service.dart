import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/config/const.dart';
import 'package:jiron_anime/model/entity/product.dart';
import 'package:http_status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:jiron_anime/model/entity/tag.dart';
import 'package:jiron_anime/view/components/dialogs.dart';
import 'package:jiron_anime/utils/query_string.dart';

class ProductoService {
  Future<List<Product>> fetchRecent(int page) async {
    List<Product> productos = [];

    final queryParams = {
      ..._pagination(page),
      ..._commonJoins,
      "orderBy[createdAt]": "desc",
    };

    final res = await http.get(
      Uri.parse("${Config.apiUrl}/product?${parseToQueryParams(queryParams)}"),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salio mal.\n${res.body}"));
    }

    final List<dynamic> data = jsonDecode(res.body);
    productos =
        data
            .map((map) => Product.fromJson(map as Map<String, dynamic>))
            .toList();

    return productos;
  }

  Future<List<Product>> searchProducts(String productName, int page) async {
    List<Product> productos = [];
    final queryParams = {
      ..._pagination(page),
      ..._commonJoins,
      "where[name][contains]": productName,
      "where[name][mode]": "insensitive",
      "orderBy[createdAt]": "desc",
    };

    final res = await http.get(
      Uri.parse("${Config.apiUrl}/product?${parseToQueryParams(queryParams)}"),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salio mal.\n${res.body}"));
    }

    final List<dynamic> data = jsonDecode(res.body);
    productos =
        data
            .map((map) => Product.fromJson(map as Map<String, dynamic>))
            .toList();

    return productos;
  }

  Future<List<Product>> fetchProductsByGenre(List<Tag> tags, int page) async {
    List<Product> productos = [];
    final queryParams = {
      ..._pagination(page),
      ..._commonJoins,
      "where[productTags][some][tag][id]": tags[0].id!,
      "orderBy[createdAt]": "desc",
    };

    final res = await http.get(
      Uri.parse("${Config.apiUrl}/product?${parseToQueryParams(queryParams)}"),
    );

    if (!res.statusCode.isSuccessfulHttpStatusCode) {
      Get.dialog(ErrorDialog(message: "Algo salio mal.\n${res.body}"));
    }

    final List<dynamic> data = jsonDecode(res.body);

    productos = List.from(
      data.map((map) => Product.fromJson(map as Map<String, dynamic>)),
    );

    return productos;
  }
}

Map<String, Object> _pagination(int page) {
  return {
    "take": ConstValues.RESULTS_PER_PAGE + 1,
    "skip": (page - 1) * ConstValues.RESULTS_PER_PAGE,
  };
}

Map<String, Object> _commonJoins = {
  "where[status]": 1,
  "include[productAttachments]": true,
  "include[productTags][include][tag]": true,
  "include[market][include][profile][include][client]": true,
};
