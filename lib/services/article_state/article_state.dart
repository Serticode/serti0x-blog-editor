import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart';

final articleInStateProvider =
    StateNotifierProvider<ArticleInState, ArticleModel>((ref) {
  return ArticleInState(
    stateRef: ref,
  );
});

class ArticleInState extends StateNotifier<ArticleModel> {
  ArticleInState({
    required Ref stateRef,
  })  : _stateRef = stateRef,
        super(
          ArticleModel(
            articleID: "",
            ownerID: "",
            title: "",
            content: [],
            createdAt: DateTime.now(),
            category: ArticleCategory.none.categoryName,
            mediumURL: "",
          ),
        );

  final Ref _stateRef;

  //! UPDATE ARTICLE IN STATE
  void updateArticleInState({
    required ArticleModel theArticle,
  }) {
    state = theArticle;
  }

  //!
  void updateArticleInStateTitle({
    required String title,
  }) async {
    ArticleModel currentArticle = state;

    final updatedArticle = ArticleModel(
      articleID: currentArticle.articleID,
      ownerID: currentArticle.ownerID,
      title: title,
      content: currentArticle.content,
      createdAt: currentArticle.createdAt,
      category: currentArticle.category,
      mediumURL: currentArticle.mediumURL,
    );

    _stateRef.invalidate(articlesRepositoryProvider);

    await Future.delayed(const Duration(seconds: 3));

    updateArticleInState(theArticle: updatedArticle);
  }

  //!
  void updateArticleInStateCategory({
    required String category,
  }) async {
    ArticleModel currentArticle = state;

    final updatedArticle = ArticleModel(
      articleID: currentArticle.articleID,
      ownerID: currentArticle.ownerID,
      title: currentArticle.title,
      content: currentArticle.content,
      createdAt: currentArticle.createdAt,
      category: category,
      mediumURL: currentArticle.mediumURL,
    );

    _stateRef.invalidate(articlesRepositoryProvider);

    await Future.delayed(const Duration(seconds: 3));

    updateArticleInState(theArticle: updatedArticle);
  }

  //!
  Future<void> refreshArticleRepoProvider() async {
    _stateRef.invalidate(articlesRepositoryProvider);
  }
}
