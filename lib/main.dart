import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/services/models/data_or_error_model.dart';
import 'package:serti0x_blog_editor/services/repository/auth_repository/auth_repository.dart';
import 'package:serti0x_blog_editor/router/router.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/theme/theme_state_and_provider.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(
    const ProviderScope(
      child: Serti0xBlogEditor(),
    ),
  );
}

class Serti0xBlogEditor extends ConsumerStatefulWidget {
  const Serti0xBlogEditor({super.key});

  @override
  ConsumerState<Serti0xBlogEditor> createState() => _Serti0xBlogEditorState();
}

class _Serti0xBlogEditorState extends ConsumerState<Serti0xBlogEditor> {
  DataOrErrorModel? dataOrErrorModel;

  void getUserData() async {
    dataOrErrorModel = await ref.read(authRepositoryProvider).getUserData();

    if (dataOrErrorModel != null && dataOrErrorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => dataOrErrorModel!.data);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
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
              return MaterialApp.router(
                title: AppStrings.instance.appName,
                debugShowCheckedModeBanner: false,
                theme: appTheme,
                routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                  final user = ref.watch(userProvider);

                  if (user != null && user.token.isNotEmpty) {
                    return loggedInRoute;
                  }
                  return loggedOutRoute;
                }),
                routeInformationParser: const RoutemasterParser(),
              );
            }
          },
        );
      },
    );
  }
}
