// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/shared/app_strings.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});
  static final appStrings = AppStrings.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 220,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appStrings.soMuchMore.txt14(
                context: context,
              ),

              //!
              10.0.sizedBoxHeight,

              //!
              appStrings.welcome.txt(
                context: context,
                fontSize: 28,
              ),

              12.0.sizedBoxHeight,

              //!
              appStrings.welcomeRider.txt12(
                context: context,
                color: AppColours.instance.grey500,
              ),

              const Spacer(),

              //!
              appStrings.developerName.txt(
                context: context,
                fontSize: 18.0,
              ),
            ],
          ),

          const Spacer(),

          //!
          Image.asset(
            appStrings.footerImage.png,
          )
              .transformToScale(
                scale: 1.5,
              )
              .fadeInFromBottom(),

          12.0.sizedBoxHeight,
        ],
      ).generalPadding,
    );
  }
}
