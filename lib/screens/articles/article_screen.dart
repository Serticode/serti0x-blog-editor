import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/articles_view.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/drawer.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/edit_article_view.dart';

class ArticleScreen extends ConsumerWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 120,
            child: ArticlesDrawer(),
          ),

          //! ARTICLES
          SizedBox(
            width: 300,
            child: ArticlesView(),
          ),

          //! EDIT DOCUMENTS
          Expanded(
            flex: 7,
            child: EditArticleView(),
          ),
        ],
      ),
    );
  }
}
