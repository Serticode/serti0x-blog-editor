const host = "localhost:5555";

class NetworkConstants {
  NetworkConstants._internal();
  static NetworkConstants? _instance;

  static NetworkConstants get instance {
    _instance ??= NetworkConstants._internal();
    return _instance!;
  }

  final String login = "http://localhost:5555/api/v1/auth/login";
  final String getUser = "http://localhost:5555/api/v1/auth/getUser/";
  final String logout = "$host/auth/logout";
  final String refresh = "$host/auth/logout";
}
