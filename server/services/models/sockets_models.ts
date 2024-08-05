import { Server } from "socket.io";
import { ArticleDocument } from "../../database/models/articles/articles_model";

export interface ListenToSocketParams {
  socketName: string;
  socketIO: Server;
}

export interface MessageListenersParams {
  theSocket: ListenToSocketParams;
  article: ArticleDocument;
}
