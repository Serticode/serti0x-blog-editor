import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDeletingArticle = StateNotifierProvider<IsDeletingArticle, bool>((ref) {
  return IsDeletingArticle();
});

class IsDeletingArticle extends StateNotifier<bool> {
  IsDeletingArticle() : super(false);

  void setTrue() => state = true;

  void setFalse() => state = false;
}
