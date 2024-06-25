import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';

final articleInStateProvider =
    StateNotifierProvider<ArticleInState, ArticleModel>((ref) {
  return ArticleInState();
});

class ArticleInState extends StateNotifier<ArticleModel> {
  ArticleInState()
      : super(
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

//! UPDATE ARTICLE IN STATE
  void updateArticleInState({
    required ArticleModel theArticle,
  }) {
    state = theArticle;
  }
}
