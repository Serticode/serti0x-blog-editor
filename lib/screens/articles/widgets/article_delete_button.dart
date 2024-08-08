// ignore_for_file: deprecated_member_use
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_loader.dart';
import 'package:serti0x_blog_editor/services/article_state/is_deleting_article_state.dart';
import 'package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class ArticleDeleteButton extends ConsumerWidget {
  const ArticleDeleteButton({
    required this.articleID,
    super.key,
  });

  final String articleID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeletingItem = ref.watch(isDeletingArticle);
    const coloursInstance = AppColours.instance;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.bounceIn,
      switchOutCurve: Curves.bounceOut,
      child: isDeletingItem
          ? const AppLoader()
          : SvgPicture.asset(
              AppStrings.instance.trash.svg,
              color: coloursInstance.red,
            ).onTap(
              onTap: () async => await _deleteArticle(
                widgetRef: ref,
                articleID: articleID,
              ),
            ),
    );
  }

  Future _deleteArticle({
    required WidgetRef widgetRef,
    required String articleID,
  }) async {
    widgetRef.read(isDeletingArticle.notifier).setTrue();

    final dataOrError =
        await widgetRef.read(articlesRepositoryProvider).deleteArticle(
              articleID: articleID,
            );

    if (dataOrError.error == null) {
      widgetRef.invalidate(articlesRepositoryProvider);
    }

    widgetRef.read(isDeletingArticle.notifier).setFalse();
  }
}
