class SignUpResponse {
  int? statusCode;
  int? code;
  String? message;

  SignUpResponse({
    this.statusCode,
    this.code,
    this.message,
  });

  factory SignUpResponse.fromJson(int statusCode, Map<String, dynamic> json) => SignUpResponse(
        statusCode: statusCode,
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
