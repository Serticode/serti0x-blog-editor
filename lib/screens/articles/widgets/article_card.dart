// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';
import 'package:serti0x_blog_editor/shared/utils/utils.dart';

class ArticleCard extends ConsumerWidget {
  const ArticleCard({
    required this.article,
    super.key,
  });
  final ArticleModel article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;
    final bool isCurrentArticle = ref.watch(articleInStateProvider) == article;

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

          10.0.sizedBoxHeight,

          //!
          Divider(
            height: 1.0,
            thickness: 1.0,
            color: coloursInstance.grey200,
          ),

          10.0.sizedBoxHeight,

          //!
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Eu scelerisque felis imperdiet proin fermentum leo vel orci. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat."
              .txt12(
            context: context,
            maxLines: 5,
            color: coloursInstance.grey500,
            textAlign: TextAlign.justify,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),

          10.0.sizedBoxHeight,

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
                  "bubble".svg,
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

          10.0.sizedBoxHeight,

          //!
          //!
          AppUtils.formatDateTime(theDate: article.createdAt!)
              .txt(
                context: context,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              )
              .alignCenterLeft(),
        ],
      ),
    );
  }
}
