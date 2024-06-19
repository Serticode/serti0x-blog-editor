import { StatusCodes } from "http-status-codes";
import {
  Body,
  Controller,
  Get,
  OperationId,
  Path,
  Post,
  Response,
  Route,
  Security,
  Tags,
} from "tsoa";
import ArticlesService from "../../services/articles/articles_service";
import {
  Article,
  CreateArticleParams,
  GetMyArticlesParamsResponse,
} from "../../services/models/article_model";

//!
//! HANDLES POSTS ENDPOINT
@Route("/api/v1/articles")
@Tags("Articles")
export class ArticlesController extends Controller {
  @Post("")
  @OperationId("createArticle")
  @Security("jwt")
  @Response(StatusCodes.CREATED)
  @Response(StatusCodes.BAD_REQUEST, "Original articleID is missing")
  public async createArticle(
    @Body() body: CreateArticleParams
  ): Promise<Article> {
    return new ArticlesService().createArticle(body);
  }

  @Get("/{userID}/getArticles")
  @OperationId("getMyArticles")
  @Security("jwt")
  @Response(StatusCodes.OK)
  @Response(
    StatusCodes.BAD_REQUEST,
    "You have a bad request, kindly check your path or API request section"
  )
  public async getMyArticles(
    @Path() userID: string
  ): Promise<GetMyArticlesParamsResponse> {
    return new ArticlesService().getMyArticles({
      userID: userID,
    });
  }
}
