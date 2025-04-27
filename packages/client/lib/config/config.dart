class Config {
  static final supabaseURL = String.fromEnvironment("SUPABASE_URL");
  static final supabaseAnonKey = String.fromEnvironment("SUPABASE_ANON_KEY");
  static final googleServerClientID = String.fromEnvironment(
    "GOOGLE_SERVER_CLIENT_ID",
  );
  static final apiUrl = String.fromEnvironment("API_URL");

  static final hfToken = String.fromEnvironment("HUGGINGFACE_TOKEN");

  static final webSocketURL = String.fromEnvironment(
    "WEBSOCKETS_SERVER_URL",
    defaultValue: "ws://10.0.2.2:8080/",
  );
}
