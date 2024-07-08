import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart';
import 'package:serti0x_blog_editor/services/repository/auth_repository/auth_repository.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

final articleControllerProvider = Provider<ArticleController>(
  (ref) {
    return ArticleController(
      controllerRef: ref,
      titleController: TextEditingController(),
    );
  },
);

class ArticleController {
  const ArticleController({
    required Ref controllerRef,
    required TextEditingController titleController,
  })  : _controllerRef = controllerRef,
        theTitleController = titleController;

  final Ref _controllerRef;
  final TextEditingController theTitleController;

  //! LISTEN TO TITLE CHANGES
  void listenToTitleChange() =>
      _controllerRef.listen<ArticleModel>(articleInStateProvider,
          (previousArticle, newArticle) {
        if (newArticle.title != theTitleController.text) {
          theTitleController.text = newArticle.title!;
        }
      });

  //!
  Future<void> createDocument({
    required BuildContext context,
  }) async {
    const coloursInstance = AppColours.instance;
    String accessToken = _controllerRef.read(userProvider)!.token;

    final snackbar = ScaffoldMessenger.of(context);

    final dataOrError = await _controllerRef
        .read(articlesRepositoryProvider)
        .createArticle(token: accessToken);

    if (dataOrError.data != null) {
      _controllerRef.invalidate(articlesRepositoryProvider);

      await Future.delayed(const Duration(seconds: 5));

      final newArticle = ArticleModel.fromJSON(
        json: dataOrError.data,
      );

      _controllerRef
          .read(articleInStateProvider.notifier)
          .updateArticleInState(theArticle: newArticle);
    } else {
      snackbar.showSnackBar(
        SnackBar(
          content: dataOrError.error!.txt14(
            // ignore: use_build_context_synchronously
            context: context,
            color: coloursInstance.white,
          ),
        ),
      );
    }
  }

  //! UPDATE TITLE
  Future<void> updateTitle({
    required String title,
    required String articleID,
  }) async {
    await _controllerRef.read(articlesRepositoryProvider).updateTitle(
          articleID: articleID,
          title: title,
        );
  }
}
