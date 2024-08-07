import 'package:serti0x_blog_editor/services/repository/sockets_repository/sockets_client.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository {
  final _socketClient = SocketClient.instance.socket!;
  static final _appStringsInstance = AppStrings.instance;

  Socket get socketClient => _socketClient;

  void joinDocumentRoom({
    required String documentId,
  }) {
    _socketClient.emit(_appStringsInstance.join, documentId);
  }

  /* void onArticleEmit() {
    _socketClient.on("connectionSuccessful", (data) {
      "Connection Successful: --->> Message Gotten: DATA --->> $data".log();
    });
  } */

  void typing({
    required Map<String, dynamic> data,
  }) =>
      _socketClient.emit(
        _appStringsInstance.isTyping,
        data,
      );

  void autoSave({
    required Map<String, dynamic> data,
  }) =>
      _socketClient.emit(_appStringsInstance.autoSave, data);

  void changeListener({
    required Function(Map<String, dynamic>) callBack,
  }) {
    "CHANGE LISTENER: $callBack".log();

    _socketClient.on(
      _appStringsInstance.changes,
      (data) => callBack(
        data,
      ),
    );
  }
}
