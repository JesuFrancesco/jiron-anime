import 'package:jiron_anime/config/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initializeSupabase() async {
  await Supabase.initialize(
    url: Config.supabaseURL,
    anonKey: Config.supabaseAnonKey,
  );
}

SupabaseClient getSupabaseClient() {
  return Supabase.instance.client;
}

Map<String, String> getSupabaseAuthHeaders() {
  final session = getSupabaseClient().auth.currentSession;

  final token = session?.accessToken;
  final refreshToken = session?.refreshToken;

  return {'Authorization': 'Bearer $token', 'RefreshToken': '$refreshToken'};
}
