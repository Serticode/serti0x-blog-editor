// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/drawer_item_widget.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/services/controller/article_controller.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/repository/auth_repository/auth_repository.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/services/repository/sockets_repository/sockets_client.dart';
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

          DrawerItemWidget(
            iconName: appStrings.edit,
            itemColour: coloursInstance.blue,
            onTap: () async {
              final navigator = Routemaster.of(context);
              final routeNames = RouteNames.instance;

              final ArticleModel? newArticle = await ref
                  .read(articleControllerProvider)
                  .createNewArticle(context: context);

              if (newArticle != null) {
                ref.read(articleInStateProvider.notifier).updateArticleInState(
                      theArticle: newArticle,
                    );

                navigator.push(
                  routeNames.editArticle,
                  queryParameters: {
                    AppStrings.instance.articleID: newArticle.articleID!,
                  },
                );
              }
            },
          ),

          24.0.sizedBoxHeight,

          DrawerItemWidget(
            iconName: appStrings.clearArticleInState,
            itemColour: coloursInstance.purple,
            onTap: () {
              final socketClient = SocketClient.instance.socket;
              socketClient!.disconnect();
              ref.read(articleInStateProvider.notifier).updateArticleInState(
                    theArticle: ArticleModel(
                      articleID: "",
                      ownerID: "",
                      title: "",
                      content: [],
                      createdAt: DateTime.now(),
                      category: ArticleCategory.none.categoryName,
                      mediumURL: "",
                    ),
                  );
            },
          ),

          const Spacer(),

          DrawerItemWidget(
            iconName: appStrings.logoutIcon,
            itemColour: coloursInstance.red,
            onTap: () async {
              final navigator = Routemaster.of(context);
              final routeNames = RouteNames.instance;

              await ref.read(authRepositoryProvider).signOut();
              navigator.replace(routeNames.landingPage);
              ref.read(userProvider.notifier).update((state) => null);
            },
          ),
        ],
      ),
    );
  }
}
