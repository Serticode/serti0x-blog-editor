// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/models/article_model.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_editor.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_button.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';
import 'package:serti0x_blog_editor/utilities/utils.dart';

class EditArticleView extends ConsumerWidget {
  const EditArticleView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;
    final currentArticle = ref.watch(articleInStateProvider);

    return Column(
      children: [
        //! HEADER
        Container(
          height: 100.0,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 32.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(
                color: coloursInstance.grey200,
              ),
              bottom: BorderSide(
                color: coloursInstance.grey200,
              ),
            ),
          ),

          //! CHILD
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //!
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "# ${currentArticle.title}".txt16(
                    context: context,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: coloursInstance.grey600,
                  ),

                  //!
                  RegularButton(
                    onTap: () {
                      Clipboard.setData(
                        const ClipboardData(
                          text: "http://localhost:3000/#/document/",
                        ),
                      ).then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Link copied!",
                              ),
                            ),
                          );
                        },
                      );
                    },
                    buttonText: "Share",
                    isLoading: false,
                    isButtonColoured: true,
                  )
                ],
              ),

              //!
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppUtils.getArticleCategoryBGColour(
                        currentArticle: currentArticle,
                      ),
                    ),

                    //!
                    child: SizedBox(
                      width: 120.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "bubble".svg,
                            width: 16.0,
                            height: 16.0,
                            color: AppUtils.getArticleCategoryColour(
                              currentArticle: currentArticle,
                            ),
                          ),

                          //!
                          8.0.sizedBoxWidth,

                          //!
                          getArticleCategory(
                            categoryName: currentArticle.category!,
                          ).categoryName.txt(
                                context: context,
                                fontSize: 10,
                                color: AppUtils.getArticleCategoryColour(
                                  currentArticle: currentArticle,
                                ),
                                fontWeight: FontWeight.w600,
                              ),
                        ],
                      ),
                    ),
                  ),

                  21.0.sizedBoxWidth,

                  //!
                  AppUtils.formatDateTime(theDate: currentArticle.createdAt!)
                      .txt(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),

                  21.0.sizedBoxWidth,

                  //!
                  "@Serticode".txt14(
                    context: context,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: AppUtils.getArticleCategoryColour(
                      currentArticle: currentArticle,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        //! BODY
        const Expanded(
          child: ArticleEditor(),
        )
      ],
    );
  }
}
