import "dart:convert";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart";
import "package:serti0x_blog_editor/services/article_state/article_state.dart";
import "package:serti0x_blog_editor/services/models/article_model.dart";
import "package:serti0x_blog_editor/services/models/data_or_error_model.dart";
import "package:serti0x_blog_editor/services/repository/auth_repository/auth_repository.dart";
import "package:serti0x_blog_editor/services/repository/preferences_repository/shared_preferences_repository.dart";
import "package:serti0x_blog_editor/shared/network_constants.dart";
import "package:serti0x_blog_editor/shared/utils/app_extensions.dart";

final articlesRepositoryProvider = Provider(
  (ref) => DocumentRepository(
    client: Client(),
    networkConstants: NetworkConstants.instance,
    sharedPrefRepository: SharedPrefRepository(),
    repositoryRef: ref,
  ),
);

class DocumentRepository {
  DocumentRepository({
    required Client client,
    required NetworkConstants networkConstants,
    required SharedPrefRepository sharedPrefRepository,
    required Ref repositoryRef,
  })  : _client = client,
        _networkConstants = networkConstants,
        _sharedPrefRepo = sharedPrefRepository,
        _repoRef = repositoryRef;

  final Client _client;
  final NetworkConstants _networkConstants;
  final Ref _repoRef;
  final SharedPrefRepository _sharedPrefRepo;

  Future<DataOrErrorModel> createArticle({required String token}) async {
    DataOrErrorModel error = DataOrErrorModel(
      error: "Some unexpected error occurred.",
      data: null,
    );

    try {
      final response = await _client.post(
        Uri.parse(_networkConstants.createArticle),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "userID": _repoRef.read(userProvider)!.userID,
          "title": "New Article",
          "category": ArticleCategory.none.categoryName,
          "mediumURL": "No URL",
        }),
      );

      switch (response.statusCode) {
        case 200:
          final jsonResponse = jsonDecode(response.body);
          "200: JSON RESPONSE - CREATE ARTICLES: $response".log();

          error = DataOrErrorModel(
            error: null,
            data: ArticleModel.fromJSON(json: jsonResponse),
          );
          break;
        default:
          error = DataOrErrorModel(
            error: response.body,
            data: null,
          );
          break;
      }
    } catch (e) {
      error = DataOrErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }

  //!
  //!
  Future<DataOrErrorModel> getArticles() async {
    DataOrErrorModel error = DataOrErrorModel(
      error: "Some unexpected error occurred.",
      data: null,
    );

    String? token = await _sharedPrefRepo.getToken();

    try {
      final response = await _client.get(
        Uri.parse(
          _networkConstants.getArticles(
            userID: _repoRef.read(userProvider)!.userID,
          ),
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

          List<ArticleModel> documents = [];

          for (final responseData in jsonResponse["articles"]) {
            documents.add(
              ArticleModel.fromJSON(json: responseData),
            );
          }
          error = DataOrErrorModel(
            error: null,
            data: documents,
          );

          break;
        default:
          error = DataOrErrorModel(
            error: response.body,
            data: null,
          );

          "GET ARTICLES ERROR FROM SWITCH STATEMENT : ${response.body}".log();
          break;
      }
    } catch (e) {
      error = DataOrErrorModel(
        error: e.toString(),
        data: null,
      );
      "GET ARTICLES ERROR: $e".log();
    }
    return error;
  }

  //!
  void updateTitle({
    required String articleID,
    required String title,
  }) async {
    try {
      String? token = await _sharedPrefRepo.getToken();

      final response = await _client.post(
        Uri.parse(
          _networkConstants.updateArticleTitle,
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "title": title,
          "articleID": articleID,
        }),
      );

      switch (response.statusCode) {
        case 200:
          _repoRef
              .read(articleInStateProvider.notifier)
              .updateArticleInStateTitle(
                title: title,
              );

          break;
        default:
          "UPDATE ARTICLE TITLE FROM SWITCH STATEMENT: ${response.body}".log();
          break;
      }
    } catch (error) {
      "UPDATE ARTICLE TITLE ERROR: $error".log();
    }
  }

  //!
  /* Future<DataOrErrorModel> getDocumentById(String token, String id) async {
    DataOrErrorModel error = DataOrErrorModel(
      error: "Some unexpected error occurred.",
      data: null,
    );
    try {
      final response = await _client.get(
        Uri.parse("$host/doc/$id"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": token,
        },
      );

      switch (response.statusCode) {
        case 200:
          final jsonResponse = jsonDecode(response.body);

          error = DataOrErrorModel(
            error: null,
            data: ArticleModel.fromJSON(json: jsonResponse),
          );
          break;
        default:
          throw "This Document does not exist, please create a new one.";
      }
    } catch (e) {
      error = DataOrErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  } */
}
