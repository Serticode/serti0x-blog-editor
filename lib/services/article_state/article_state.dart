import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

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
            category: ArticleCategory.none.name,
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
      category: currentArticle.ownerID,
      mediumURL: currentArticle.ownerID,
    );

    _stateRef.invalidate(articlesRepositoryProvider);

    await Future.delayed(const Duration(seconds: 5)).then((value) {
      "FUTURE.DELAYED DONE".log();
    });

    updateArticleInState(theArticle: updatedArticle);
  }
}
