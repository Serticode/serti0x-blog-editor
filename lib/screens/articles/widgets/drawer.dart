// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/services/repository/auth_repository/auth_repository.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_button.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class ArticlesDrawer extends ConsumerWidget {
  const ArticlesDrawer({super.key});

  static const coloursInstance = AppColours.instance;
  static final appStrings = AppStrings.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 12.0),
      child: Column(
        children: [
          //! IMAGE
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: coloursInstance.blue.withOpacity(0.1),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  appStrings.myAvatar.png,
                ),
              ),
            ),
          ),

          45.0.sizedBoxHeight,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24.0,
                width: 3.0,
                decoration: BoxDecoration(
                  color: coloursInstance.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),

              //!
              10.0.sizedBoxWidth,

              //!
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: coloursInstance.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SvgPicture.asset(
                  appStrings.edit.svg,
                  color: coloursInstance.grey900,
                  width: 18.0,
                  height: 18.0,
                ),
              ),
            ],
          ),

          const Spacer(),

          //!
          RegularButton(
            onTap: () async {
              final navigator = Routemaster.of(context);
              final routeNames = RouteNames.instance;

              await ref.read(authRepositoryProvider).signOut();
              navigator.replace(routeNames.landingPage);
              ref.read(userProvider.notifier).update((state) => null);
            },
            buttonText: appStrings.logout,
            isLoading: false,
            isButtonColoured: true,
          ),
        ],
      ),
    );
  }
}
