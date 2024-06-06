import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serti0x_blog_editor/screens/landing_page/landing_page.dart';
import 'package:serti0x_blog_editor/shared/app_strings.dart';
import 'package:serti0x_blog_editor/theme/theme_state_and_provider.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

Future<void> main() async {
  runApp(
    const ProviderScope(
      child: Serti0xBlogEditor(),
    ),
  );
}

class Serti0xBlogEditor extends ConsumerWidget {
  const Serti0xBlogEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeNotifierProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      ensureScreenSize: true,

      //! 1440 BY 1024 - THAT'S THE LAYOUT GIVEN ON THE DESIGN BOARD
      designSize: const Size(1512, 1632),
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            constraints.maxWidth.log();

            if (constraints.maxWidth <= 1150) {
              return Container(
                color: Colors.purple,
              );
            } else {
              return MaterialApp(
                title: AppStrings.instance.appName,
                debugShowCheckedModeBanner: false,
                theme: appTheme,
                home: const LandingPage(),
              );
            }
          },
        );
      },
    );
  }
}
