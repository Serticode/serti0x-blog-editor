import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/articles_grid_view.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/drawer.dart';

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
          Expanded(
            child: ArticlesGridView(),
          ),
        ],
      ),
    );
  }
}
