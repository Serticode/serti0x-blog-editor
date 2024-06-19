import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:serti0x_blog_editor/models/data_or_error_model.dart';
import 'package:serti0x_blog_editor/repository/sockets_repository/sockets_repository.dart';
import 'package:serti0x_blog_editor/shared/app_colours.dart';

class ArticleEditor extends ConsumerStatefulWidget {
  const ArticleEditor({super.key});

  @override
  ConsumerState<ArticleEditor> createState() => _ArticleEditorState();
}

class _ArticleEditorState extends ConsumerState<ArticleEditor> {
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  final quill.QuillController _controller = quill.QuillController.basic();
  DataOrErrorModel? dataOrErrorModel;
  SocketRepository socketRepository = SocketRepository();

  void fetchDocumentData() async {
    /* errorModel = await ref.read(documentRepositoryProvider).getDocumentById(
          ref.read(userProvider)!.token,
          widget.id,
        );

    if (errorModel!.data != null) {
      titleController.text = (errorModel!.data as DocumentModel).title;
      _controller = quill.QuillController(
        document: errorModel!.data.content.isEmpty
            ? quill.Document()
            : quill.Document.fromDelta(
                quill.Delta.fromJson(errorModel!.data.content),
              ),
        selection: const TextSelection.collapsed(offset: 0),
      );
      setState(() {});
    }

    _controller!.document.changes.listen((event) {
      if (event.item3 == quill.ChangeSource.LOCAL) {
        Map<String, dynamic> map = {
          'delta': event.item2,
          'room': widget.id,
        };
        socketRepository.typing(map);
      }
    }); */
  }

  @override
  void initState() {
    super.initState();
    socketRepository.joinDocumentRoom(documentId: "");
    fetchDocumentData();

    socketRepository.changeListener(
      callBack: (data) {
        /* _controller?.compose(
        quill Delta.fromJson(data['delta']),
        _controller?.selection ?? const TextSelection.collapsed(offset: 0),
        quill.ChangeSource.REMOTE,
      ); */
      },
    );

    Timer.periodic(const Duration(seconds: 2), (timer) {
      /* socketRepository.autoSave(data: <String, dynamic>{
        'delta': _controller!.document.toDelta(),
        'room': "",
      }); */
    });
  }

  @override
  Widget build(BuildContext context) {
    const coloursInstance = AppColours.instance;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 6.0),
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
                    sharedConfigurations: const quill.QuillSharedConfigurations(
                      locale: Locale("en"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
