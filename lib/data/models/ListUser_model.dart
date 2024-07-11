import 'dart:convert';

ListUser userFromJson(String str) => ListUser.fromJson(json.decode(str));
String userToJson(ListUser data) => json.encode(data.toJson());

class ListUser {
  final int currentPage;
  final List<ListUserData> data;
  final int lastPage;

  ListUser({
    required this.currentPage,
    required this.data,
    required this.lastPage,
  });

  factory ListUser.fromJson(Map<String, dynamic> json) => ListUser(
        currentPage: json["page"],
        data: List<ListUserData>.from(
            json["data"].map((x) => ListUserData.fromJson(x))),
        lastPage: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "last_page": lastPage,
      };
}

class ListUserData {
  final int userID;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;

  ListUserData({
    required this.userID,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.avatar,
  });

  factory ListUserData.fromJson(Map<String, dynamic> json) => ListUserData(
        userID: json["id"],
        email: json["email"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": userID,
        "email": email,
        "first_name": first_name,
        "last_name": last_name,
        "avatar": avatar,
      };
}
