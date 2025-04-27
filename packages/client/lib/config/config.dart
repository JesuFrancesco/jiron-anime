class Config {
  static const supabaseURL = String.fromEnvironment(
    "SUPABASE_URL",
    defaultValue: "UNSET",
  );

  static const supabaseAnonKey = String.fromEnvironment(
    "SUPABASE_ANON_KEY",
    defaultValue: "UNSET",
  );

  static const googleWebClientId = String.fromEnvironment(
    "GOOGLE_WEB_CLIENT_ID",
    defaultValue: "UNSET",
  );

  static const googleAndroidClientId = String.fromEnvironment(
    "GOOGLE_ANDROID_CLIENT_ID",
    defaultValue: "UNSET",
  );

  static const hfToken = String.fromEnvironment(
    "HUGGINGFACE_TOKEN",
    defaultValue: "UNSET",
  );

  static const apiUrl = String.fromEnvironment(
    "API_URL",
    defaultValue: "UNSET",
  );

  static const webSocketURL = String.fromEnvironment(
    "WEBSOCKETS_SERVER_URL",
    defaultValue: "ws://10.0.2.2:6060/",
  );
}
