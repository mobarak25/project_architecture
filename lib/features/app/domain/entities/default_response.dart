class DefaultResponse {
  const DefaultResponse({
    this.message,
  });

  final String? message;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
