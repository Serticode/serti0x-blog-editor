// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/repository/auth_repository/auth_repository.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_button.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

class DocumentsDrawer extends ConsumerWidget {
  const DocumentsDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;

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
            ),
            child: "A.S"
                .txt16(
                  context: context,
                  fontWeight: FontWeight.w700,
                  color: coloursInstance.blue,
                )
                .alignCenter(),
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
              10.0.sizedBoxWidth,
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: coloursInstance.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: SvgPicture.asset(
                  "edit".svg,
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
            buttonText: "Logout",
            isLoading: false,
            isButtonColoured: true,
          ),
        ],
      ),
    );
  }
}
