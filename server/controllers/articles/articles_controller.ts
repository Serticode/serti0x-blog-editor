import { StatusCodes } from "http-status-codes";
import {
  Body,
  Controller,
  Delete,
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
  DeleteArticleParam,
  DeleteArticleResponseParam,
  GetArticleByIDResponseParams,
  GetMyArticlesParamsResponse,
  UpdateArticleCategoryParams,
  UpdateArticleCategoryResponse,
  UpdateArticleMediumURLParams,
  UpdateArticleMediumURLResponse,
  UpdateArticleTitleParams,
  UpdateArticleTitleParamsResponse,
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

  @Post("/updateArticleTitle")
  @OperationId("updateArticleTitle")
  @Security("jwt")
  @Response(StatusCodes.OK)
  @Response(StatusCodes.BAD_REQUEST, "ArticleID is missing")
  public async updateArticleTitle(
    @Body() body: UpdateArticleTitleParams
  ): Promise<UpdateArticleTitleParamsResponse> {
    return new ArticlesService().updateArticleTitle({
      title: body.title,
      articleID: body.articleID,
    });
  }

  @Post("/updateArticleMediumURL")
  @OperationId("updateArticleMediumURL")
  @Security("jwt")
  @Response(StatusCodes.OK)
  @Response(StatusCodes.BAD_REQUEST, "ArticleID is missing")
  public async updateArticleMediumURL(
    @Body() body: UpdateArticleMediumURLParams
  ): Promise<UpdateArticleMediumURLResponse> {
    return new ArticlesService().updateArticleMediumURL({
      mediumURL: body.mediumURL,
      articleID: body.articleID,
    });
  }

  @Post("/updateArticleCategory")
  @OperationId("updateArticleCategory")
  @Security("jwt")
  @Response(StatusCodes.OK)
  @Response(StatusCodes.BAD_REQUEST, "ArticleID is missing")
  public async updateArticleCategory(
    @Body() body: UpdateArticleCategoryParams
  ): Promise<UpdateArticleCategoryResponse> {
    return new ArticlesService().updateArticleCategory({
      categoryName: body.categoryName,
      articleID: body.articleID,
    });
  }

  @Get("/{articleID}/getArticle")
  @OperationId("getArticleByID")
  @Security("jwt")
  @Response(StatusCodes.OK)
  @Response(
    StatusCodes.BAD_REQUEST,
    "You have a bad request, kindly check your path or API request section"
  )
  public async getArticleByID(
    @Path() articleID: string
  ): Promise<GetArticleByIDResponseParams> {
    const params = {
      articleID: articleID,
    };

    return new ArticlesService().getArticleByID(params);
  }

  //! LOGOUT END POINT
  @Delete("/deleteArticle")
  @Security("jwt")
  @OperationId("deleteArticle")
  public async deleteArticle(
    @Body() body: DeleteArticleParam
  ): Promise<DeleteArticleResponseParam> {
    return await new ArticlesService().deleteArticle(body);
  }
}
