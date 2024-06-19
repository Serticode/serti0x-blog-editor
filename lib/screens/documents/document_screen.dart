import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/screens/documents/widgets/articles_view.dart';
import 'package:serti0x_blog_editor/screens/documents/widgets/drawer.dart';
import 'package:serti0x_blog_editor/screens/documents/widgets/edit_article_view.dart';

class DocumentScreen extends ConsumerWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 120,
            child: DocumentsDrawer(),
          ),

          //! ARTICLES
          SizedBox(
            width: 300,
            child: ArticlesView(),
          ),

          //! EDIT DOCUMENTS
          Expanded(
            flex: 7,
            child: EditArticleView(
              articleIndex: 3,
            ),
          ),
        ],
      ),
    );
  }
}
