import 'dart:convert';
import 'package:http_status/http_status.dart';
import 'package:jiron_anime/config/config.dart';
import 'package:jiron_anime/model/service/auth_service.dart';
import 'package:jiron_anime/utils/supabase_utils.dart';

import '../entity/account.dart';
import 'package:http/http.dart' as http;

class AccountService {
  Future<Account> fetchMyAccount() async {
    final response = await http.get(
      Uri.parse(
        "${Config.apiUrl}/client/unique?where[id]=${AuthService.getClientId()}",
      ),
      headers: getSupabaseAuthHeaders(),
    );

    if (!response.statusCode.isSuccessfulHttpStatusCode) {
      throw Error();
    }

    final dynamic data = jsonDecode(response.body);

    return Account.fromJson(data);
  }
}
