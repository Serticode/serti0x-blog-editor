// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/services/models/data_or_error_model.dart';
import 'package:serti0x_blog_editor/services/repository/auth_repository/auth_repository.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/screens/landing_page/widgets/broken_circle.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_button.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/theme/theme_state_and_provider.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class Header extends ConsumerWidget {
  const Header({super.key});
  static final appStrings = AppStrings.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeBrightness = ref.watch(themeNotifierProvider).brightness;

    return Row(
      children: [
        appStrings.appName.txt(
          context: context,
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),

        //!
        const Spacer(),

        //!
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.transparent,
          child: CustomPaint(
            painter: BrokenCirclePainter(
              paintColour: themeBrightness == Brightness.light
                  ? AppColours.instance.blue
                  : AppColours.instance.peach,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                appStrings.codeLogo.svg,
                color: themeBrightness == Brightness.light
                    ? null
                    : AppColours.instance.white,
              ).fadeInFromBottom(),
            ),
          ),
        ),

        //!
        const Spacer(),

        //! BUTTON 2
        RegularButton(
          isButtonColoured: true,
          buttonText: appStrings.login,
          isLoading: false,
          onTap: () async {
            final navigator = Routemaster.of(context);
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final routeNames = RouteNames.instance;

            await ref
                .read(authRepositoryProvider)
                .signInWithGoogle()
                .then((DataOrErrorModel dataOrErrorModel) {
              if (dataOrErrorModel.data != null) {
                ref
                    .read(userProvider.notifier)
                    .update((state) => dataOrErrorModel.data);

                navigator.replace(routeNames.article);
              } else {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(dataOrErrorModel.error!),
                  ),
                );
              }
            });
          },
        )
      ],
    ).generalPadding;
  }
}
