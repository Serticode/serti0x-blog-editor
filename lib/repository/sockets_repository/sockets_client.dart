import "package:serti0x_blog_editor/shared/network_constants.dart";
import "package:socket_io_client/socket_io_client.dart" as io;

class SocketClient {
  //!
  SocketClient._internal() {
    socket = io.io(host, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    //!
    socket!.connect();
  }

  //!
  io.Socket? socket;
  static SocketClient? _instance;

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
