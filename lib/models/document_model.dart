import 'dart:convert';

class DocumentModel {
  DocumentModel({
    required this.title,
    required this.uid,
    required this.content,
    required this.createdAt,
    required this.id,
  });

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      title: map['title'] ?? '',
      uid: map['uid'] ?? '',
      content: List.from(map['content']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      id: map['_id'] ?? '',
    );
  }

  factory DocumentModel.fromJson(String source) =>
      DocumentModel.fromMap(json.decode(source));
  final String title;
  final String uid;
  final List content;
  final DateTime createdAt;
  final String id;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'uid': uid,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());
}
