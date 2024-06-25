import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(AppTheme.instance.lightTheme) {
    _loadTheme();
  }

  static final String _appThemeKey = AppStrings.instance.appThemeKey;

  Future<void> toggleTheme() async {
    if (state.brightness == Brightness.dark) {
      state = AppTheme.instance.lightTheme;

      await _saveThemeToPreferences(
        isDarkMode: false,
      );
    } else {
      state = AppTheme.instance.darkTheme;

      await _saveThemeToPreferences(
        isDarkMode: true,
      );
    }
  }

  Future<void> _saveThemeToPreferences({
    required bool isDarkMode,
  }) async {
    final themePreferences = await SharedPreferences.getInstance();
    await themePreferences.setBool(_appThemeKey, isDarkMode);
  }

  Future<void> _loadTheme() async {
    final themePreferences = await SharedPreferences.getInstance();
    final isDarkMode = themePreferences.getBool(_appThemeKey) ?? false;
    state =
        isDarkMode ? AppTheme.instance.darkTheme : AppTheme.instance.lightTheme;
  }
}
