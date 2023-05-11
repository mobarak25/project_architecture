class Post {
  final int? id;
  final String? title;
  final String? body;
  final int? userId;

  const Post({
    this.id,
    this.title,
    this.body,
    this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
      };
}
