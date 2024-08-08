import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_quill/flutter_quill.dart" as quill;
import "package:routemaster/routemaster.dart";
import "package:serti0x_blog_editor/router/routes.dart";
import "package:serti0x_blog_editor/screens/articles/widgets/article_editor_header.dart";
import "package:serti0x_blog_editor/services/article_state/article_state.dart";
import "package:serti0x_blog_editor/services/controller/article_controller.dart";
import "package:serti0x_blog_editor/services/models/article_model.dart";
import "package:serti0x_blog_editor/services/repository/article_repository/article_repository.dart";
import "package:serti0x_blog_editor/services/repository/sockets_repository/sockets_repository.dart";
import "package:serti0x_blog_editor/shared/constants/app_colours.dart";

class ArticleEditor extends ConsumerStatefulWidget {
  const ArticleEditor({
    required this.articleID,
    super.key,
  });

  final String articleID;

  @override
  ConsumerState<ArticleEditor> createState() => _ArticleEditorState();
}

class _ArticleEditorState extends ConsumerState<ArticleEditor> {
  quill.QuillController _controller = quill.QuillController.basic();
  ArticleModel? currentArticle;
  Timer? _timer;

  final SocketRepository _socketRepository = SocketRepository();

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final articleID = ref.watch(articleInStateProvider).articleID;

      if (articleID != null && articleID.isNotEmpty) {
        _socketRepository.autoSave(data: <String, dynamic>{
          "delta": _controller.document.toDelta(),
          "articleID": articleID,
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> fetchDocumentData() async {
    final dataOrError =
        await ref.read(articlesRepositoryProvider).getArticleByID(
              articleID: widget.articleID,
            );

    if (dataOrError.data != null) {
      currentArticle = dataOrError.data as ArticleModel;

      ref
          .read(articleControllerProvider)
          .setControllerTitle(title: currentArticle?.title ?? "");

      _controller = quill.QuillController(
        document: currentArticle!.content!.isEmpty
            ? quill.Document()
            : quill.Document.fromDelta(
                quill.Document.fromJson(currentArticle!.content!).toDelta(),
              ),
        selection: const TextSelection.collapsed(offset: 0),
      );

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timer) async {
        await fetchDocumentData();
        _startTimer();
      },
    );
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const coloursInstance = AppColours.instance;

    return Scaffold(
      body: Column(
        children: [
          //!
          ArticleEditorHeader(
            theArticle: currentArticle,
            onBackArrowTapped: () {
              final navigator = Routemaster.of(context);
              final routeNames = RouteNames.instance;

              navigator.replace(routeNames.articles);
            },
          ),

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6.0),
            child: quill.QuillToolbar.simple(
              configurations: quill.QuillSimpleToolbarConfigurations(
                controller: _controller,
                color: Colors.transparent,
                multiRowsDisplay: false,
                showAlignmentButtons: true,
                sharedConfigurations: quill.QuillSharedConfigurations(
                  locale: const Locale("en"),
                  dialogBarrierColor: coloursInstance.grey700.withOpacity(0.5),
                ),
              ),
            ),
          ),

          //!
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6.0),
              child: Card(
                color: coloursInstance.white,
                elevation: 80.0,
                shadowColor: coloursInstance.grey200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: quill.QuillEditor.basic(
                    configurations: quill.QuillEditorConfigurations(
                      controller: _controller,
                      sharedConfigurations:
                          const quill.QuillSharedConfigurations(
                        locale: Locale("en"),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
