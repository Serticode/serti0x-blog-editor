const host = "http://localhost:5555";

class NetworkConstants {
  NetworkConstants._internal();
  static NetworkConstants? _instance;

  static NetworkConstants get instance {
    _instance ??= NetworkConstants._internal();
    return _instance!;
  }

  //! AUTH
  final String login = "$host/api/v1/auth/login";
  final String getUser = "$host/api/v1/auth/getUser/";
  final String logout = "$host/api/v1/auth/logout/";

  //! ARTICLES
  final String createArticle = "$host/api/v1/articles/";
  final String updateArticleTitle = "$host/api/v1/articles/updateArticleTitle/";
  final String updateArticleMediumURL =
      "$host/api/v1/articles/updateArticleMediumURL/";
  final String updateArticleCategory =
      "$host/api/v1/articles/updateArticleCategory/";
  String getArticles({
    required String userID,
  }) =>
      "$host/api/v1/articles/$userID/getArticles/";
}
