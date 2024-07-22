import Article from "../../database/models/articles/articles_model";
import { ArticleNotFoundError } from "../../errors/article_not_found";
import {
  CreateArticleParams,
  GetMyArticlesParams,
  GetMyArticlesParamsResponse,
  Article as TSOAArticleModel,
  UpdateArticleCategoryParams,
  UpdateArticleCategoryResponse,
  UpdateArticleMediumURLParams,
  UpdateArticleMediumURLResponse,
  UpdateArticleTitleParams,
  UpdateArticleTitleParamsResponse,
} from "../../services/models/article_model";

export default class ArticlesService {
  //!
  //! CREATE ARTICLE
  public async createArticle(
    params: CreateArticleParams
  ): Promise<TSOAArticleModel> {
    //! GET USER DETAILS FROM PARAMS AND FIND USER IN DB.
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

  //!
  //! GET MY ARTICLES
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

  //! UPDATE ARTICLE TITLE
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

  //! UPDATE ARTICLE MEDIUM URL
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
}
