import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:serti0x_blog_editor/router/routes.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/no_article_written.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/services/controller/article_controller.dart';
import 'package:serti0x_blog_editor/services/models/article_model.dart';
import 'package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_card.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_loader.dart';
import 'package:serti0x_blog_editor/shared/constants/app_colours.dart';
import 'package:serti0x_blog_editor/shared/constants/app_strings.dart';
import 'package:serti0x_blog_editor/shared/utils/app_extensions.dart';

class ArticlesGridView extends ConsumerWidget {
  const ArticlesGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;

    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.only(
        top: 32.0,
        left: 56.0,
        right: 56.0,
      ),

      //!
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),

        //!
        child: FutureBuilder(
          future: ref.watch(articlesRepositoryProvider).getArticles(),
          builder: (context, gottenData) {
            return Column(
              children: [
                "My Articles"
                    .txt14(
                      context: context,
                      color: coloursInstance.grey600,
                      fontWeight: FontWeight.w600,
                    )
                    .alignCenterLeft(),

                16.0.sizedBoxHeight,

                //!
                Expanded(
                  child: gottenData.when(
                    onDataGotten: (dataOrErrorModel) {
                      final List<ArticleModel> articles = dataOrErrorModel.data;

                      return articles.isEmpty
                          ? NoArticlesWritten(
                              onWriteNewArticle: () async {
                                final navigator = Routemaster.of(context);
                                final routeNames = RouteNames.instance;

                                final ArticleModel? newArticle = await ref
                                    .read(articleControllerProvider)
                                    .createNewArticle(context: context);

                                if (newArticle != null) {
                                  ref
                                      .read(articleInStateProvider.notifier)
                                      .updateArticleInState(
                                        theArticle: newArticle,
                                      );

                                  navigator.push(
                                    routeNames.editArticle,
                                    queryParameters: {
                                      AppStrings.instance.articleID:
                                          newArticle.articleID!,
                                    },
                                  );
                                }
                              },
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                              ),
                              itemCount: articles.length,
                              itemBuilder: (_, index) {
                                return ArticleCard(
                                  article: articles.elementAt(index),
                                  onTap: () async {
                                    final navigator = Routemaster.of(context);

                                    final routeNames = RouteNames.instance;

                                    ref
                                        .read(articleInStateProvider.notifier)
                                        .updateArticleInState(
                                          theArticle: articles.elementAt(index),
                                        );

                                    navigator.push(
                                      routeNames.editArticle,
                                      queryParameters: {
                                        AppStrings.instance.articleID: articles
                                                .elementAt(index)
                                                .articleID ??
                                            "",
                                      },
                                    );
                                  },
                                );
                              },
                            );
                    },

                    //!
                    loading: () => const AppLoader().alignCenter(),
                    onError: (error, stackTrace) {
                      return "Could not get your articles"
                          .txt14(context: context)
                          .alignCenter();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
