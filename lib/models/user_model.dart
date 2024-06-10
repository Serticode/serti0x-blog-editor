import "dart:collection";

class UserModel extends MapView<String, dynamic> {
  UserModel({
    required this.email,
    required this.name,
    required this.profilePic,
    required this.userID,
    required this.token,
  }) : super({
          "userID": userID,
          "email": email,
          "name": name,
          "profilePic": profilePic,
          "token": token,
        });

  factory UserModel.fromJSON({
    required Map<String, dynamic> json,
  }) {
    final Map<String, dynamic> userDOC = json["user"];

    return UserModel(
      email: userDOC["email"] ?? "",
      name: userDOC["name"] ?? "",
      profilePic: userDOC["profilePic"] ?? "",
      userID: userDOC["id"] ?? "",
      token: json["token"] ?? "",
    );
  }

  final String email;
  final String name;
  final String profilePic;
  final String userID;
  final String token;

  UserModel copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? userID,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      userID: userID ?? this.userID,
      token: token ?? this.token,
    );
  }
}
