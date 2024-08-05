import { ListenToSocketParams } from "../../services/models/sockets_models";

export default class SocketsService {
  public async listenToSocket(params: ListenToSocketParams) {
    const { socketIO } = params;

    socketIO.on("connection", (socket) => {
      console.log("\n\nCONNECTION MADE ---->>", socket.id);
      socket.emit(
        "connectionSuccessful",
        "Message from server, you are connected."
      );

      socket.on("disconnect", () => {
        console.log("DISCONNECT DONE ---->> ", socket.id);
      });

      socket.on("save", (data) => {
        console.log("SOCKET IO SAVE DATA: ", data);
      });
    });

    socketIO.on("join", (documentId) => {
      console.log("SOCKET IO JOIN DATA: ", documentId);
    });

    socketIO.on("typing", (data) => {
      console.log("SOCKET IO TYPING DATA: ", data);
    });
  }
}
