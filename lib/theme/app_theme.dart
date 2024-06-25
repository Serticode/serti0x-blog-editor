import 'package:flutter/material.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'fade_transition.dart';

class AppTheme {
  AppTheme._privateConstructor();
  static AppTheme instance = AppTheme._privateConstructor();
  static final appStrings = AppStrings.instance;

  //!
  //!
  //! DARK THEME
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    //! TRANSITIONS
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      for (final platform in TargetPlatform.values)
        platform: CustomFadeTransitionBuilder(),
    }),

    //!
    scaffoldBackgroundColor: AppColours.instance.black,

    //! FONT FAMILY
    fontFamily: appStrings.fontFamily,

    //!
    useMaterial3: false,
  );

  //!
  //!
  //! LIGHT THEME
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    //! TRANSITIONS
    pageTransitionsTheme: PageTransitionsTheme(builders: {
      for (final platform in TargetPlatform.values)
        platform: CustomFadeTransitionBuilder(),
    }),

    //!
    scaffoldBackgroundColor: AppColours.instance.white,

    //! FONT FAMILY
    fontFamily: appStrings.fontFamily,

    //!
    useMaterial3: false,
  );
}
