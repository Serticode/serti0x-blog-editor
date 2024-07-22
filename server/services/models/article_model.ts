//!
//! SYSTEM ARTICLE MODEL
export interface Article {
  id: string;
  userID: string;
  title: string;
  content: any[];
  category: string;
  mediumURL: string;
  createdAt: Date;
}

//!
//! CREATE ARTICLE PARAMS
export interface CreateArticleParams {
  userID: string;
  title: string;
  category: string;
  mediumURL: string;
}

//!
//! GET MY ARTICLES PARAMS
export interface GetMyArticlesParams {
  userID: string;
}

//!
//! GET MY ARTICLES PARAMS RESPONSE
export interface GetMyArticlesParamsResponse {
  articles: Article[];
}

//!
//! UPDATE ARTICLE TITLE PARAMS
export interface UpdateArticleTitleParams {
  title: string;
  articleID: string;
}

//!
//! UPDATE ARTICLE TITLE PARAMS RESPONSE
export interface UpdateArticleTitleParamsResponse {
  article: Article;
}

//!
//! UPDATE ARTICLE MEDIUM URL PARAMS
export interface UpdateArticleMediumURLParams {
  mediumURL: string;
  articleID: string;
}

//!
//! UPDATE ARTICLE MEDIUM URL RESPONSE
export interface UpdateArticleMediumURLResponse {
  article: Article;
}

//!
//! UPDATE ARTICLE CATEGORY PARAMS
export interface UpdateArticleCategoryParams {
  categoryName: string;
  articleID: string;
}

//!
//! UPDATE ARTICLE CATEGORY RESPONSE
export interface UpdateArticleCategoryResponse {
  article: Article;
}
