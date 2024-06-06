import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:serti0x_blog_editor/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serti0x_blog_editor/repository/preferences_repository/shared_preferences_repository.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

//!
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
    localStorageRepository: SharedPrefRepository(),
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
    required SharedPrefRepository localStorageRepository,
  })  : _googleSignIn = googleSignIn,
        _client = client,
        _localStorageRepository = localStorageRepository;
  final GoogleSignIn _googleSignIn;
  final Client _client;
  final SharedPrefRepository _localStorageRepository;

  //! SIGN IN
  Future<void> signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();

      if (user != null) {
        "${user.email} ${user.displayName} ${user.photoUrl}".log();

        /* final userAcc = UserModel(
          email: user.email,
          name: user.displayName ?? '',
          profilePic: user.photoUrl ?? '',
          uid: '',
          token: '',
        ); */
      }
    } catch (e) {}
  }
}
