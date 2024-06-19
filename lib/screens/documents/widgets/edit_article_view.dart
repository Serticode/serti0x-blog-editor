// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/models/article_model.dart';
import 'package:serti0x_blog_editor/screens/documents/widgets/article_editor.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_button.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

class EditArticleView extends ConsumerWidget {
  const EditArticleView({
    required this.articleIndex,
    super.key,
  });
  final int articleIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;

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
                width: 2,
              ),
              bottom: BorderSide(
                color: coloursInstance.grey200,
                width: 2,
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
                  "# WORK ON BUDGET REPORT FOR BLAH BLAH BLAH".txt16(
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
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: articleIndex % 3 == 0
                          ? coloursInstance.purple.withOpacity(0.1)
                          : articleIndex.isEven
                              ? coloursInstance.peach.withOpacity(0.1)
                              : coloursInstance.blue.withOpacity(0.1),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "bubble".svg,
                          width: 16.0,
                          height: 16.0,
                          color: articleIndex % 3 == 0
                              ? coloursInstance.purple
                              : articleIndex.isEven
                                  ? coloursInstance.peach
                                  : coloursInstance.blue,
                        ),

                        //!
                        8.0.sizedBoxWidth,

                        //!
                        (articleIndex % 3 == 0
                                ? ArticleCategory.gist.categoryName
                                : articleIndex.isEven
                                    ? ArticleCategory.backEnd.categoryName
                                    : ArticleCategory.frontEnd.categoryName)
                            .txt(
                          context: context,
                          fontSize: 10,
                          color: articleIndex % 3 == 0
                              ? coloursInstance.purple
                              : articleIndex.isEven
                                  ? coloursInstance.peach
                                  : coloursInstance.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),

                  21.0.sizedBoxWidth,

                  //!
                  "Today, ${TimeOfDay.fromDateTime(DateTime.now()).hour}: ${TimeOfDay.fromDateTime(DateTime.now()).minute}"
                      .txt(
                    context: context,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),

                  21.0.sizedBoxWidth,

                  //!
                  "Serticode".txt14(
                    context: context,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: coloursInstance.grey600,
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
