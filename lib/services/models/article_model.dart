import "dart:collection";

class ArticleModel extends MapView<String, dynamic> {
  ArticleModel({
    required this.articleID,
    required this.ownerID,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.category,
    required this.mediumURL,
  }) : super({
          "articleID": articleID,
          "ownerID": ownerID,
          "title": title,
          "content": content,
          "createdAt": createdAt?.toIso8601String(),
          "category": category,
          "mediumURL": mediumURL,
        });

  factory ArticleModel.fromJSON({
    required Map<String, dynamic> json,
  }) {
    return ArticleModel(
      articleID: json["id"] ?? "",
      ownerID: json["userId"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] != null ? List.from(json["content"]) : [],
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      category: json["category"] ?? "",
      mediumURL: json["mediumURL"] ?? "",
    );
  }

  String? ownerID;
  String? title;
  String? articleID;
  List? content;
  DateTime? createdAt;
  String? category;
  String? mediumURL;
}

//!
enum ArticleCategory {
  frontEnd(categoryName: "Front End"),
  backEnd(categoryName: "Back End"),
  gist(categoryName: "Gist"),
  none(categoryName: "None");

  final String categoryName;

  // ignore: sort_constructors_first
  const ArticleCategory({
    required this.categoryName,
  });
}

//!
ArticleCategory getArticleCategory({required String categoryName}) {
  switch (categoryName) {
    case "Front End":
      return ArticleCategory.frontEnd;
    case "Back End":
      return ArticleCategory.backEnd;
    case "Gist":
      return ArticleCategory.gist;
    default:
      return ArticleCategory.none;
  }
}
