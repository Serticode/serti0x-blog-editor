import Article from "../../database/models/articles/articles_model";
import { ArticleNotFoundError } from "../../errors/article_not_found";
import {
  CreateArticleParams,
  DeleteArticleParam,
  DeleteArticleResponseParam,
  GetArticleByIDParams,
  GetArticleByIDResponseParams,
  GetMyArticlesParams,
  GetMyArticlesParamsResponse,
  SaveArticleContentCategoryParams,
  Article as TSOAArticleModel,
  UpdateArticleCategoryParams,
  UpdateArticleCategoryResponse,
  UpdateArticleMediumURLParams,
  UpdateArticleMediumURLResponse,
  UpdateArticleTitleParams,
  UpdateArticleTitleParamsResponse,
} from "../../services/models/article_model";

export default class ArticlesService {
  public async createArticle(
    params: CreateArticleParams
  ): Promise<TSOAArticleModel> {
    const { userID, title, category, mediumURL } = params;

    let article = await Article.create({
      userId: userID,
      title: title,
      category: category,
      mediumURL: mediumURL,
    });

    article = await article.save();

    return article.toJSON() as TSOAArticleModel;
  }

  public async getMyArticles(
    params: GetMyArticlesParams
  ): Promise<GetMyArticlesParamsResponse> {
    const { userID } = params;

    const articles = await Article.find(
      {
        userId: userID,
      },
      null,
      {
        sort: { createdAt: -1 },
      }
    );

    if (!articles || articles.length === 0) {
      throw new ArticleNotFoundError();
    } else {
      return {
        articles: articles.map((article) => article.toJSON()),
      };
    }
  }

  public async updateArticleTitle(
    params: UpdateArticleTitleParams
  ): Promise<UpdateArticleTitleParamsResponse> {
    const { articleID, title } = params;

    const article = await Article.findByIdAndUpdate(articleID, {
      title: title,
    });

    if (!article) {
      throw new ArticleNotFoundError();
    } else {
      return article.toJSON();
    }
  }

  public async updateArticleMediumURL(
    params: UpdateArticleMediumURLParams
  ): Promise<UpdateArticleMediumURLResponse> {
    const { articleID, mediumURL } = params;

    const article = await Article.findByIdAndUpdate(articleID, {
      mediumURL: mediumURL,
    });

    if (!article) {
      throw new ArticleNotFoundError();
    } else {
      return article.toJSON();
    }
  }

  public async updateArticleCategory(
    params: UpdateArticleCategoryParams
  ): Promise<UpdateArticleCategoryResponse> {
    const { articleID, categoryName } = params;

    const article = await Article.findByIdAndUpdate(articleID, {
      category: categoryName,
    });

    if (!article) {
      throw new ArticleNotFoundError();
    } else {
      return article.toJSON();
    }
  }

  public async saveArticleData(params: SaveArticleContentCategoryParams) {
    const { articleID, content } = params;

    const article = await Article.findByIdAndUpdate(articleID, {
      content: content,
    });

    if (!article) {
      throw new ArticleNotFoundError();
    } else {
      return article.toJSON();
    }
  }

  public async getArticleByID(
    params: GetArticleByIDParams
  ): Promise<GetArticleByIDResponseParams> {
    const { articleID } = params;

    const article = await Article.findById(articleID);

    if (!article) {
      throw new ArticleNotFoundError();
    } else {
      return article.toJSON();
    }
  }

  public async deleteArticle(
    params: DeleteArticleParam
  ): Promise<DeleteArticleResponseParam> {
    const { userID, articleID } = params;

    const article = await Article.findOneAndDelete({
      _id: articleID,
      userId: userID,
    });

    if (!article) {
      throw new ArticleNotFoundError();
    }

    const response = {
      message: "Article deleted successfully",
    } as DeleteArticleResponseParam;

    return response;
  }
}
