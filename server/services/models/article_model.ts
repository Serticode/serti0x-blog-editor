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
