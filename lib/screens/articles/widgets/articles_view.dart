import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/models/article_model.dart';
import 'package:serti0x_blog_editor/repository/article_repository/article_repository.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_card.dart';
import 'package:serti0x_blog_editor/screens/widgets/app_loader.dart';
import 'package:serti0x_blog_editor/services/article_state/article_state.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';
import 'package:serti0x_blog_editor/utilities/app_extensions.dart';

class ArticlesView extends ConsumerWidget {
  const ArticlesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const coloursInstance = AppColours.instance;

    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.only(
        top: 32.0,
        left: 12.0,
        right: 12.0,
      ),
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
                21.0.sizedBoxHeight,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "My Articles".txt14(
                      context: context,
                      color: coloursInstance.grey600,
                      fontWeight: FontWeight.w600,
                    ),
                    const Icon(
                      Icons.add,
                    ).onTap(
                      onTap: () {},
                    )
                  ],
                ),

                21.0.sizedBoxHeight,

                //!

                Expanded(
                  child: gottenData.when(
                    onDataGotten: (dataOrErrorModel) {
                      final List<ArticleModel> articles = dataOrErrorModel.data;

                      return ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (_, index) {
                          return ArticleCard(
                            article: articles.elementAt(index),
                          ).onTap(
                            onTap: () {
                              ref
                                  .read(articleInStateProvider.notifier)
                                  .updateArticleInState(
                                    theArticle: articles.elementAt(index),
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
