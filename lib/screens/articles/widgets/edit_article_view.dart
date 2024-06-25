// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/services/controller/article_controller.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_editor.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_button.dart';
import 'package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';
import 'package:serti0x_blog_editor/shared/utils/utils.dart';

class EditArticleView extends ConsumerWidget {
  const EditArticleView({
    super.key,
  });

  static const coloursInstance = AppColours.instance;

  void updateArticleTitle({required WidgetRef ref}) {
    ref.read(articlesRepositoryProvider).updateTitle(
          articleID: ref.read(articleInStateProvider).articleID!,
          title:
              ref.read(articleControllerProvider).theTitleController.value.text,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentArticle = ref.watch(articleInStateProvider);
    final titleController =
        ref.watch(articleControllerProvider).theTitleController;
    ref.watch(articleControllerProvider).listenToTitleChange();

    return Column(
      children: [
        //! HEADER
        Container(
          height: 120.0,
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
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: Row(
                      children: [
                        "# ".txt16(
                          context: context,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          color: coloursInstance.grey600,
                        ),

                        //!
                        12.0.sizedBoxWidth,

                        //!
                        Expanded(
                          child: TextFormField(
                            controller: titleController,
                            cursorColor: AppUtils.getArticleCategoryColour(
                              currentArticle: currentArticle,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: coloursInstance.grey600,
                              wordSpacing: 4,
                              letterSpacing: 1.0,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: coloursInstance.grey900,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 10),
                            ),
                            onFieldSubmitted: (value) {
                              try {
                                updateArticleTitle(ref: ref);
                              } catch (e) {
                                "ERROR: $e".log();
                              }
                              /* await ref
                                  .read(articleControllerProvider)
                                  .updateTitle(
                                    title: value,
                                    articleID: currentArticle.articleID!,
                                  ); */
                            },
                          ),
                        ),
                      ],
                    ),
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
