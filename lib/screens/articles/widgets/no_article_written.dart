// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class NoArticlesWritten extends ConsumerWidget {
  const NoArticlesWritten({required this.onWriteNewArticle, super.key});

  final VoidCallback onWriteNewArticle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),

        SvgPicture.asset("noArticle".svg),
        16.0.sizedBoxHeight,
        "No article written".txt(context: context),

        const Spacer(),

        //!
        Container(
          width: 220.0,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: AppColours.instance.grey200,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "bubble".svg,
                width: 16.0,
                height: 16.0,
                color: AppColours.instance.grey900,
              ),

              //!
              8.0.sizedBoxWidth,

              //!
              "Write new article".txt(
                context: context,
                fontSize: 10,
                color: AppColours.instance.grey900,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ).onTap(
          onTap: onWriteNewArticle,
        ),

        //!
        64.0.sizedBoxHeight,
      ],
    );
  }
}
