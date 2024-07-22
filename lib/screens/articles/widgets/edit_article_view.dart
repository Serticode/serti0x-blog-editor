import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static final ValueNotifier<bool> showCategoryDropdown = false.toValueNotifier;

  static const coloursInstance = AppColours.instance;

  static final articleCategoryDropdownController = DropdownController();

  void updateArticleTitle({
    required WidgetRef ref,
  }) {
    ref.read(articlesRepositoryProvider).updateTitle(
          articleID: ref.read(articleInStateProvider).articleID!,
          title:
              ref.read(articleControllerProvider).theTitleController.value.text,
        );
  }

  static List<CoolDropdownItem<String>> dropdownItemList =
      ArticleCategory.values
          .map(
            (articleCategory) => CoolDropdownItem<String>(
              label: articleCategory.categoryName,
              value: articleCategory.categoryName,
            ),
          )
          .toList();

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
                              articleCategoryName:
                                  currentArticle.category ?? "",
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
                            onFieldSubmitted: (value) async {
                              await ref
                                  .read(articleControllerProvider)
                                  .updateTitle(
                                    title: value.trim(),
                                    articleID: currentArticle.articleID!,
                                  );
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
                  SizedBox(
                    height: 40.0,
                    width: 120.0,
                    child: CoolDropdown(
                      controller: articleCategoryDropdownController,
                      dropdownList: dropdownItemList,
                      onChange: (value) async {
                        if (currentArticle.articleID != null &&
                            currentArticle.articleID!.isNotEmpty) {
                          await ref
                              .read(articleControllerProvider)
                              .updateArticleCategory(
                                categoryName: value,
                                articleID: currentArticle.articleID ?? "",
                              );
                        }

                        articleCategoryDropdownController.close();
                      },

                      //defaultItem: ,

                      //!
                      resultOptions: ResultOptions(
                        placeholder: currentArticle.category,
                        openBoxDecoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: coloursInstance.grey200,
                          ),
                        ),
                        boxDecoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18.r),
                          border: Border.all(
                            color: coloursInstance.grey200,
                            width: 0.5,
                          ),
                        ),
                      ),

                      //!
                      dropdownOptions: const DropdownOptions(
                        top: 20,
                        height: 400,
                        gap: DropdownGap.all(5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        align: DropdownAlign.left,
                        animationType: DropdownAnimationType.size,
                      ),

                      //!
                      dropdownTriangleOptions: const DropdownTriangleOptions(
                        width: 0,
                        height: 0,
                      ),

                      //! THE ITEMS DECORATION
                      dropdownItemOptions: DropdownItemOptions(
                        padding: const EdgeInsets.symmetric(
                          //horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        boxDecoration: BoxDecoration(
                          color: coloursInstance.grey200,
                          /* border: Border.all(
                            width: 0.5,
                            color: coloursInstance.grey500,
                          ), */
                        ),
                        selectedPadding: EdgeInsets.zero,
                        selectedBoxDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        selectedTextStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: coloursInstance.grey900,
                          wordSpacing: 4,
                          letterSpacing: 1.0,
                        ),
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: coloursInstance.grey700,
                          wordSpacing: 4,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),

                  12.0.sizedBoxHeight,

                  //!
                  /* Container(
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
                  ).onTap(
                    onTap: () {
                      showCategoryDropdown.value = !showCategoryDropdown.value;
                    },
                  ), */

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
                      articleCategoryName: currentArticle.category ?? "",
                    ),
                  ),
                ],
              ),
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
