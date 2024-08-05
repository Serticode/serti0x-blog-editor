import "package:serti0x_blog_editor/shared/network_constants.dart";
import "package:serti0x_blog_editor/shared/utils/app_extensions.dart";
import "package:socket_io_client/socket_io_client.dart" as socket_io_client;

class SocketClient {
  //!
  SocketClient._internal() {
    socket = socket_io_client.io(
      host,
      socket_io_client.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build(),
    );

    //!
    socket!.connect();

    socket!.on("connection", (data) {
      "Connected to WebSocket: DATA --->> ${data.id}".log();
    });

    socket!.on("connectionSuccessful", (data) {
      "Connection Successful: --->> Message Gotten: DATA --->> $data".log();
    });
  }

  //!
  socket_io_client.Socket? socket;
  static SocketClient? _instance;

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
