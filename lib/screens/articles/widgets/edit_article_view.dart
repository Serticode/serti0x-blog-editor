import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_editor_header.dart';
import 'package:serti0x_blog_editor/screens/articles/widgets/article_editor.dart';

class EditArticleView extends ConsumerWidget {
  const EditArticleView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        //! HEADER
        ArticleEditorHeader(),

        //! BODY
        Expanded(
          child: ArticleEditor(),
        )
      ],
    );
  }
}
