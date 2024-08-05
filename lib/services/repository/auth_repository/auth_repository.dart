import "dart:convert";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart";
import "package:serti0x_blog_editor/services/models/data_or_error_model.dart";
import "package:serti0x_blog_editor/services/models/user_model.dart";
import "package:serti0x_blog_editor/services/repository/preferences_repository/shared_preferences_repository.dart";
import "package:serti0x_blog_editor/services/repository/sockets_repository/sockets_client.dart";
import "package:serti0x_blog_editor/shared/env_constants.dart";
import "package:serti0x_blog_editor/shared/network_constants.dart";
import "package:serti0x_blog_editor/shared/utils/app_extensions.dart";

//!
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    client: Client(),
    sharedPrefRepository: SharedPrefRepository(),
    networkConstants: NetworkConstants.instance,
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  AuthRepository({
    required Client client,
    required SharedPrefRepository sharedPrefRepository,
    required NetworkConstants networkConstants,
  })  : _client = client,
        _sharedPrefRepo = sharedPrefRepository,
        _networkConstants = networkConstants;
  final Client _client;
  final SharedPrefRepository _sharedPrefRepo;
  final NetworkConstants _networkConstants;

  //! SIGN IN
  Future<DataOrErrorModel> signInWithGoogle() async {
    DataOrErrorModel dataOrError = DataOrErrorModel(
      error: "Default Error - Sign In With Google Endpoint: We have some error",
      data: null,
    );

    try {
      //!TODO: IMPLEMENT SIGN IN WITH GOOGLE
      final response = await _client.post(
        Uri.parse(_networkConstants.login),
        body: jsonEncode({
          "email": dotenv.get(ENVConstants.userEmail),
          "name": dotenv.get(ENVConstants.userDisplayName),
          "profilePic": dotenv.get(ENVConstants.profilePic),
        }),
        headers: {
          "Content-Type": "application/json",
        },
      );

      switch (response.statusCode) {
        case 200:
          final jsonResponse = jsonDecode(response.body);
          final user = UserModel.fromJSON(json: jsonResponse);

          dataOrError = DataOrErrorModel(error: null, data: user);

          _sharedPrefRepo.setToken(token: user.token);
          break;
        default:
          final jsonResponse = jsonDecode(response.body);
          "DEFAULT GOTTEN JSON RESPONSE - LOGIN WITH GOOGLE: $jsonResponse"
              .log();
      }
    } catch (error) {
      "LOGIN ERROR: $error";
      dataOrError = DataOrErrorModel(error: error.toString(), data: null);
    }
    return dataOrError;
  }

  //!
  //!
  Future<DataOrErrorModel> getUserData() async {
    DataOrErrorModel dataOrError = DataOrErrorModel(
      error: "Default Error - Sign In With Google Endpoint: We have some error",
      data: null,
    );

    try {
      String? token = await _sharedPrefRepo.getToken();

      if (token != null) {
        var response = await _client.get(
          Uri.parse(_networkConstants.getUser),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );

        switch (response.statusCode) {
          case 200:
            final jsonResponse = jsonDecode(response.body);
            final user = UserModel.fromJSON(json: jsonResponse).copyWith(
              token: token,
            );

            dataOrError = DataOrErrorModel(
              error: null,
              data: user,
            );

            _sharedPrefRepo.setToken(token: token);
            break;
        }
      }
    } catch (error) {
      "GET USER DATA ERROR: $error";

      dataOrError = DataOrErrorModel(
        error: error.toString(),
        data: null,
      );
    }
    return dataOrError;
  }

  //!
  Future<void> signOut() async {
    try {
      String? token = await _sharedPrefRepo.getToken();

      if (token != null) {
        final socketClient = SocketClient.instance.socket!;
        socketClient.disconnect();

        var response = await _client.delete(
          Uri.parse(_networkConstants.logout),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        );

        switch (response.statusCode) {
          case 204:
            _sharedPrefRepo.setToken(token: "");

            _sharedPrefRepo.setToken(token: token);
            break;
        }
      }
    } catch (error) {
      "SIGN OUT ERROR: $error";
    }
  }
}
