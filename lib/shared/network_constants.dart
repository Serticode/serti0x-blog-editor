const host = "localhost:5555";

class NetworkConstants {
  NetworkConstants._internal();
  static NetworkConstants? _instance;

  static NetworkConstants get instance {
    _instance ??= NetworkConstants._internal();
    return _instance!;
  }

  //! AUTH
  final String login = "http://localhost:5555/api/v1/auth/login";
  final String getUser = "http://localhost:5555/api/v1/auth/getUser/";
  final String logout = "http://localhost:5555/api/v1/auth/logout/";

  //! ARTICLES
  final String createArticle = "http://localhost:5555/api/v1/articles/";
  final String updateArticleTitle =
      "http://localhost:5555/api/v1/articles/updateArticleTitle/";
  final String updateArticleMediumURL =
      "http://localhost:5555/api/v1/articles/updateArticleMediumURL/";
  String getArticles({
    required String userID,
  }) =>
      "http://localhost:5555/api/v1/articles/$userID/getArticles/";
}
