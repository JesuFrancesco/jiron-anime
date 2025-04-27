import 'dart:convert';
import 'package:jiron_anime/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:jiron_anime/model/entity/product_rating.dart';
import 'package:jiron_anime/utils/query_string.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';

class RatingService {
  final Map<String, Object> commonJoins = {
    "include[ratingAttachments]": true,
    "include[client][include][profile]": true,
  };

  Future<List<ProductRating>> fetchProductRatings(int productId) async {
    List<ProductRating> preguntas = [];

    final queryParams = {"where[productId]": productId, ...commonJoins};

    final response = await http.get(
      Uri.parse(
        "${Config.apiUrl}/productrating?${parseToQueryParams(queryParams)}",
      ),
    );

    final List<dynamic> data = jsonDecode(response.body);

    preguntas =
        data
            .map((map) => ProductRating.fromJson(map as Map<String, dynamic>))
            .toList();

    return preguntas;
  }

  Future<void> postProductReview(ProductRating rating) async {
    await http.post(
      Uri.parse("${Config.apiUrl}/productrating"),
      body: json.encode({
        "data": {
          ...rating.toJson(),
          if (rating.ratingAttachments != null)
            "ratingAttachments": {"create": rating.ratingAttachments!.toList()},
        },
      }),
      headers: {
        "Content-type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );
  }
}
