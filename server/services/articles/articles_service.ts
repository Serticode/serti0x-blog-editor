import Article from "../../database/models/articles/articles_model";
import { ArticleNotFoundError } from "../../errors/article_not_found";
import {
  CreateArticleParams,
  GetMyArticlesParams,
  GetMyArticlesParamsResponse,
  Article as TSOAArticleModel,
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
}
