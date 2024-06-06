import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_loader.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/shared/type_defs.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

class RegularButton extends ConsumerWidget {
  const RegularButton({
    required this.onTap,
    required this.buttonText,
    required this.isLoading,
    required this.isButtonColoured,
    super.key,
    this.radius,
    this.feedbackType,
  });

  final void Function() onTap;
  final AppHapticFeedbackType? feedbackType;
  final String? buttonText;
  final double? radius;
  final bool isLoading;
  final bool isButtonColoured;
  final appColoursInstance = AppColours.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 12.0,
      shadowColor:
          appColoursInstance.whiteButtonShadowGradientOne.withOpacity(0.08),
      child: Container(
        width: 120.0,
        height: 40,
        padding: EdgeInsets.symmetric(
          vertical: isLoading ? 6.0.h : 4.0.h,
          horizontal: isLoading ? 8.5.w : 6.0.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius?.r ?? 9.0),
          border: Border.all(
            width: 0.1,
            color: appColoursInstance.white,
          ),
          color: isButtonColoured
              ? appColoursInstance.blue
              : appColoursInstance.white,
          boxShadow: isButtonColoured
              ? [
                  BoxShadow(
                    color: appColoursInstance.blueButtonShadowGradientOne
                        .withOpacity(0.76),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: appColoursInstance.blueButtonShadowGradientTwo
                        .withOpacity(0.4),
                    blurRadius: 2,
                  ),
                ]
              : [
                  BoxShadow(
                    color: appColoursInstance.whiteButtonShadowGradientOne
                        .withOpacity(0.08),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: appColoursInstance.whiteButtonShadowGradientOne
                        .withOpacity(0.08),
                    blurRadius: 2,
                  ),
                ],
        ),
        child: isLoading
            ? const AppLoader()
            : buttonText!
                .txt14(
                  context: context,
                  color: isButtonColoured == false
                      ? appColoursInstance.grey500
                      : appColoursInstance.white,
                  fontWeight: FontWeight.w500,
                )
                .alignCenter(),
      ).withHapticFeedback(
        feedbackType: feedbackType,
        onTap: onTap,
      ),
    );
  }
}
