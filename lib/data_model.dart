import 'dart:convert';

class Commentsmodelapi {
    List<Comment> comments;

    Commentsmodelapi({
        required this.comments,
    });

    factory Commentsmodelapi.fromRawJson(String str) => Commentsmodelapi.fromJson(json.decode(str));

    factory Commentsmodelapi.fromJson(Map<String, dynamic> json) => Commentsmodelapi(
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );
}

class Comment {
    int id;
    String body;
    int postId;
    int likes;
    User user;

    Comment({
        required this.id,
        required this.body,
        required this.postId,
        required this.likes,
        required this.user,
    });

    factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        postId: json["postId"],
        likes: json["likes"],
        user: User.fromJson(json["user"]),
    );
}

class User {
    int id;
    String username;
    String fullName;

    User({
        required this.id,
        required this.username,
        required this.fullName,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
    );
}