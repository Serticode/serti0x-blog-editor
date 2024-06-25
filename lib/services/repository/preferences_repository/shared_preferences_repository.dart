import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepository {
  //!
  void setToken({
    required String token,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      "token",
      token,
    );
  }

  //!
  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString("token");
  }
}
