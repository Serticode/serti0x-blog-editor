// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class Footer extends ConsumerWidget {
  const Footer({super.key});
  static final appStrings = AppStrings.instance;
  static const appColours = AppColours.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //!
          Align(
            alignment: Alignment.bottomCenter,
            child: appStrings.preview
                .txt24(
                  context: context,
                  color: appColours.blue,
                  fontWeight: FontWeight.w600,
                )
                .fadeInFromBottom(),
          ),

          //!
          appStrings.soMuchMore.txt12(
            context: context,
            color: AppColours.instance.grey500,
          ),

          //!
          appStrings.welcome.txt24(
            context: context,
          ),

          //!
          appStrings.welcomeRider.txt12(
            context: context,
            color: AppColours.instance.grey500,
          ),

          //!
          appStrings.developerName
              .txt(
                context: context,
                fontSize: 18.0,
              )
              .alignCenterLeft(),
        ],
      ).generalPadding,
    );
  }
}
