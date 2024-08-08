// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_delete_button.dart';
import 'package:serti0x_blog_editor/services/article_state/is_deleting_article_state.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';
import 'package:serti0x_blog_editor/shared/utils/utils.dart';
import "package:flutter_quill/flutter_quill.dart" as quill;

class ArticleCard extends ConsumerWidget {
  const ArticleCard({
    required this.article,
    required this.onTap,
    super.key,
  });
  final ArticleModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;
    final bool isCurrentArticle = ref.watch(articleInStateProvider) == article;
    final articleContent = (article.content != null && article.content!.isEmpty)
        ? "You have not written anything. Write something new?"
        : quill.Document.fromJson(article.content!).toPlainText();

    return Container(
      height: 250,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 21.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: coloursInstance.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isCurrentArticle
              ? AppUtils.getArticleCategoryColour(
                  articleCategoryName: article.category ?? "",
                )
              : coloursInstance.grey300,
        ),
      ),

      //!
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //! TITLE
          article.title!
              .txt14(
                context: context,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
                color: coloursInstance.grey900,
                textAlign: TextAlign.justify,
              )
              .alignCenterLeft(),

          32.0.sizedBoxHeight,

          //!
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: coloursInstance.grey200,
          ),

          32.0.sizedBoxHeight,

          //!
          Expanded(
            child: articleContent.txt12(
              context: context,
              maxLines: 5,
              color: coloursInstance.grey500,
              textAlign: TextAlign.justify,
              fontWeight: FontWeight.w400,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          //!
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: AppUtils.getArticleCategoryBGColour(
                currentArticle: article,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  appStrings.bubble.svg,
                  width: 16.0,
                  height: 16.0,
                  color: AppUtils.getArticleCategoryColour(
                    articleCategoryName: article.category ?? "",
                  ),
                ),

                //!
                8.0.sizedBoxWidth,

                //!
                article.category!.txt(
                  context: context,
                  fontSize: 10,
                  color: AppUtils.getArticleCategoryColour(
                    articleCategoryName: article.category ?? "",
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),

          32.0.sizedBoxHeight,

          //!
          Row(
            children: [
              AppUtils.formatDateTime(theDate: article.createdAt!)
                  .txt(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  )
                  .alignCenterLeft(),
              const Spacer(),

              //!
              ArticleDeleteButton(
                articleID: article.articleID ?? "",
              ).transformToScale(scale: 0.7)
            ],
          ),
        ],
      ),
    )
        .onTap(
          onTap: onTap,
        )
        .ignorePointer(isLoading: ref.watch(isDeletingArticle));
  }
}
