//! THIS FILE CONTAINS HOPEFULLY, ALL EXTENSIONS USED IN THE APP.
import "dart:developer" as dev_tools show log;
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";
import "package:serti0x_blog_editor/shared/app_colours.dart";
import "package:serti0x_blog_editor/shared/app_strings.dart";
import "package:serti0x_blog_editor/shared/type_defs.dart";

final appStrings = AppStrings.instance;

//!
//! LOG EXTENSION - THIS HELPS TO CALL A .log() ON ANY OBJECT
//! checks if the app in is debug mode first.
extension Log on Object {
  void log() {
    if (kDebugMode) {
      dev_tools.log(
        toString(),
      );
    }
  }
}

//!
//! EXTENSION ON WIDGET
//! HELPS TO CALL A .dismissKeyboard ON A WIDGET
extension DismissKeyboard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

//!
//! EXTENSIONS ON TRANSFORM
extension TransformExtension on Widget {
  Widget transformToScale({
    required double scale,
  }) =>
      Transform.scale(
        scale: scale,
        child: this,
      );
}

//!
//! IGNORE POINTER
extension IgnorePointerExtension on Widget {
  ignorePointer({
    required bool isLoading,
  }) =>
      IgnorePointer(
        ignoring: isLoading,
        child: this,
      );
}

//!
//! EXTENSIONS ON NUMBER
extension WidgetExtensions on double {
  Widget get sizedBoxHeight => SizedBox(
        height: h,
      );

  Widget get sizedBoxWidth => SizedBox(
        width: w,
      );

  EdgeInsetsGeometry get verticalPadding => EdgeInsets.symmetric(vertical: h);

  EdgeInsetsGeometry get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: w);

  EdgeInsetsGeometry get symmetricPadding => EdgeInsets.symmetric(
        vertical: h,
        horizontal: w,
      );
}

//!
//! PADDING EXTENSION ON WIDGET
extension PaddingExtension on Widget {
  Widget get generalHorizontalPadding => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 21.0.w,
        ),
        child: this,
      );

  Widget get generalVerticalPadding => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
        ),
        child: this,
      );

  Widget get generalPadding => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 32.0.h,
          horizontal: 120.0.w,
        ),
        child: this,
      );
}

//!
//! EXTENSIONS ON STRING
extension ImagePath on String {
  String get png => "assets/images/$this.png";
  String get jpg => "assets/images/$this.jpg";
  String get jpeg => "assets/images/$this.jpeg";
  String get gif => "assets/gif/$this.gif";
  String get svg => "icons/$this.svg";
}

extension StringCasingExtension on String {
  String? camelCase() => toBeginningOfSentenceCase(this);

  String toCapitalized() =>
      length > 0 ? "${this[0].toUpperCase()}${substring(1).toLowerCase()}" : "";

  String toTitleCase() => replaceAll(RegExp(" +"), " ")
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}

//!
//! ALIGNMENT EXTENSIONS
extension AlignExtension on Widget {
  Align align({
    required Alignment widgetAlignment,
  }) {
    return Align(
      alignment: widgetAlignment,
      child: this,
    );
  }

  Align alignCenter() {
    return Align(
      child: this,
    );
  }

  Align alignCenterLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Align alignCenterRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align alignBottomCenter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }
}

//!
//! ANIMATION EXTENSION
extension WidgetAnimation on Widget {
  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
    AnimationController? controller,
  }) =>
      animate(
        delay: delay ?? 600.ms,
        controller: controller,
      )
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(0, 10),
          )
          .fade(
            duration: animationDuration ?? 300.ms,
            curve: Curves.fastOutSlowIn,
          );

  Animate fadeIn({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
    AnimationController? controller,
  }) =>
      animate(
        delay: delay ?? 300.ms,
        controller: controller,
      ).fade(
        duration: animationDuration ?? 300.ms,
        curve: curve ?? Curves.decelerate,
      );
}

//!
//! STYLED TEXT EXTENSION ON STRING
extension StyledTextExtension on String {
  Text txt({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
    TextStyle? textStyle,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
      style: textStyle ??
          TextStyle(
            fontSize: fontSize ?? 10.0,
            height: height,
            wordSpacing: 4,
            letterSpacing: 1.0,
            color: color ??
                (Theme.of(context).brightness == Brightness.dark
                    ? AppColours.instance.grey300
                    : AppColours.instance.grey700),
            fontWeight: fontWeight ??
                (Theme.of(context).brightness == Brightness.dark
                    ? FontWeight.w500
                    : FontWeight.w600),
            fontFamily: appStrings.fontFamily,
            fontStyle: fontStyle,
            decoration: decoration,
          ),
    );
  }

  Text txt12({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 12.0,
        height: height,
        wordSpacing: 4,
        letterSpacing: 1.0,
        color: color ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColours.instance.grey300
                : AppColours.instance.grey700),
        fontWeight: fontWeight ??
            (Theme.of(context).brightness == Brightness.dark
                ? FontWeight.w500
                : FontWeight.w600),
        fontFamily: appStrings.fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  Text txt14({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        fontSize: 14.0,
        wordSpacing: 4,
        letterSpacing: 1.0,
        color: color ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColours.instance.grey300
                : AppColours.instance.grey700),
        fontWeight: fontWeight ??
            (Theme.of(context).brightness == Brightness.dark
                ? FontWeight.w500
                : FontWeight.w600),
        fontFamily: appStrings.fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }

  Text txt16({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
    double? height,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 16.0,
        wordSpacing: 4,
        letterSpacing: 1.0,
        color: color ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColours.instance.grey300
                : AppColours.instance.grey700),
        fontWeight: fontWeight ??
            (Theme.of(context).brightness == Brightness.dark
                ? FontWeight.w500
                : FontWeight.w600),
        fontFamily: appStrings.fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
        height: height,
      ),
    );
  }

  Text txt24({
    required BuildContext context,
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextOverflow? overflow,
    TextDecoration? decoration,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return Text(
      this,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 24.0,
        wordSpacing: 4,
        letterSpacing: 1.0,
        color: color ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColours.instance.grey300
                : AppColours.instance.grey700),
        fontWeight: fontWeight ??
            (Theme.of(context).brightness == Brightness.dark
                ? FontWeight.w500
                : FontWeight.w600),
        fontFamily: appStrings.fontFamily,
        fontStyle: fontStyle,
        decoration: decoration,
      ),
    );
  }
}

//!
//! INKWELL EXTENSION ON WIDGET
extension InkWellExtension on Widget {
  InkWell onTap({
    required GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? splashColor = Colors.transparent,
    Color? highlightColor = Colors.transparent,
    String? tooltipMessage,
    BuildContext? context,
    void Function({
      required bool value,
    })? onHover,
  }) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        if (onHover != null) {
          onHover(value: value);
        }
      },
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      splashColor: splashColor,
      highlightColor: highlightColor,
      hoverColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: this,
    );
  }
}

//!
//! HAPTIC FEEDBACK
extension AppHapticFeedback on Widget {
  Widget withHapticFeedback({
    required VoidCallback? onTap,
    required AppHapticFeedbackType? feedbackType,
  }) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async => {
          onTap?.call(),
          switch (feedbackType) {
            AppHapticFeedbackType.lightImpact =>
              await HapticFeedback.lightImpact(),
            AppHapticFeedbackType.mediumImpact =>
              await HapticFeedback.mediumImpact(),
            AppHapticFeedbackType.heavyImpact =>
              await HapticFeedback.heavyImpact(),
            AppHapticFeedbackType.selectionClick =>
              await HapticFeedback.selectionClick(),
            AppHapticFeedbackType.vibrate => await HapticFeedback.vibrate(),
            _ => null
          },
        },
        child: this,
      );
}

//!
//! VALUE NOTIFIERS AND VALUE LISTENABLE BUILDERS EXTENSIONS
extension ValueNotifierExtension<AnyType> on AnyType {
  ValueNotifier<AnyType> get toValueNotifier {
    return ValueNotifier<AnyType>(this);
  }
}

extension ValueNotifierBuilderExtension<AnyType> on ValueNotifier<AnyType> {
  Widget toValueListenable({
    required Widget Function(BuildContext context, AnyType value, Widget? child)
        builder,
  }) {
    return ValueListenableBuilder<AnyType>(
      valueListenable: this,
      builder: builder,
    );
  }
}

extension ListenableBuilderExtension on List<Listenable> {
  Widget toMultiValueListenable({
    required Widget Function(BuildContext context, Widget? child) builder,
  }) {
    return ListenableBuilder(
      listenable: Listenable.merge(this),
      builder: builder,
    );
  }
}

extension AsyncSnapshotX<AnyType> on AsyncSnapshot<AnyType> {
  Widget when({
    required Widget Function() loading,
    required Widget Function(Object? error, StackTrace? stackTrace) onError,
    required Widget Function(AnyType data) onDataGotten,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return loading();
      case ConnectionState.active:
      case ConnectionState.done:
        if (hasError) {
          return onError(error, stackTrace);
        } else if (hasData) {
          return onDataGotten(data as AnyType);
        }

        return loading();
    }
  }
}
