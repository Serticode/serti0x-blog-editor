import cors from "cors";
import dotenv from "dotenv";
import express, { json, urlencoded } from "express";
import { createServer } from "http";
import morgan from "morgan";
import { Server as SocketIOServer } from "socket.io";
import * as swaggerUI from "swagger-ui-express";
import { connectToDatabase } from "./database/db_connect";
import { errorHandlerMiddleware } from "./middleware/error_handler";
import { RegisterRoutes } from "./routes/routes";
import { ListenToSocketParams } from "./services/models/sockets_models";
import SocketsService from "./services/sockets/sockets_service";
import * as swaggerJson from "./tsoa/tsoa.json";

//! DOT ENV
dotenv.config();
const app = express();

//!
//! LIST OF EVERYTHING THE APP USES
//! MIDDLE WARE FOR PARSING JSON
app.use(morgan("dev"));
app.use(urlencoded({ extended: true }));
app.use(json());
app.use(cors());

//! SWAGGER UI
//! SERVING SWAGGER UI
app.use(
  ["/openapi", "/docs", "/swagger"],
  swaggerUI.serve,
  swaggerUI.setup(swaggerJson)
);

//! SERVE SWAGGER  JSON
app.get("/swagger.json", (_, res) => {
  res.setHeader("Content-Type", "application/json");
  res.sendFile(__dirname + "/tsoa/tsoa.json");
});

RegisterRoutes(app);

//! ERROR HANDLER
app.use(errorHandlerMiddleware);

const port = process.env.PORT || process.env.BACKUP_PORT;

const start = async () => {
  try {
    const mongoUri = process.env.MONGO_URI;
    if (!mongoUri) {
      throw new Error("MONGO_URI is missing in .env file");
    }

    console.log(`Connecting to database...`);

    await connectToDatabase(mongoUri);

    console.log(`Connected to database \nStarting server...`);

    const server = createServer(app);

    const socketIO = new SocketIOServer(server);

    const params = {
      socketIO: socketIO,
      socketName: "articleSocket",
    } as ListenToSocketParams;

    new SocketsService().listenToSocket(params);

    server.listen(port, () => {
      console.log("Server is running on port", port);
    });
  } catch (error) {
    console.log(error);
  }
};

start();
