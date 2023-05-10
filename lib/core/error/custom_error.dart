class CustomError {
  CustomError({this.message});

  final String? message;

  factory CustomError.fromJson(Map<String, dynamic> json) {
    return CustomError(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
