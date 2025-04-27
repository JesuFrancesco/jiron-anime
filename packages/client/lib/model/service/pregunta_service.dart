import 'dart:convert';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/entity/product_question.dart';
import 'package:http/http.dart' as http;
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/utils/query_string.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';

class PreguntaService {
  Future<List<ProductQuestion>> fetchProductQuestions(int productId) async {
    final queryParams = {"where[productId]": productId, ...commonJoins};

    List<ProductQuestion> preguntas = [];

    final response = await http.get(
      Uri.parse(
        "${Config.apiUrl}/productquestion?${parseToQueryParams(queryParams)}",
      ),
    );

    final List<dynamic> data = jsonDecode(response.body);

    preguntas =
        data
            .map((map) => ProductQuestion.fromJson(map as Map<String, dynamic>))
            .toList();

    return preguntas;
  }

  Future submitProductQuestion(ProductQuestion productQuestion) async {
    final response = await http.post(
      Uri.parse("${Config.apiUrl}/productquestion"),
      body: json.encode({
        "data": {
          ...productQuestion.toJson(),
          "clientId": AuthService.getClientId(),
        },
      }),
      headers: {
        "Content-Type": "application/json",
        ...getSupabaseAuthHeaders(),
      },
    );

    final data = jsonDecode(response.body);

    return ProductQuestion.fromJson(data);
  }
}

final Map<String, Object> commonJoins = {
  "include[client][include][profile]": true,
};
