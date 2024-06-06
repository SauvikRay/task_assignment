class LoginResponse {
  int? statusCode;
    String? token;
    String? userEmail;
    String? userNicename;
    String? userDisplayName;
 
    String? message;

    LoginResponse({
      this.statusCode,
        this.token,
        this.userEmail,
        this.userNicename,
        this.userDisplayName,
        this.message,

    });

    factory LoginResponse.fromJson(int statusCode,Map<String, dynamic> json) => LoginResponse(
      statusCode: statusCode,
        token: json["token"],
        userEmail: json["user_email"],
        userNicename: json["user_nicename"],
        userDisplayName: json["user_display_name"],
        message: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user_email": userEmail,
        "user_nicename": userNicename,
        "user_display_name": userDisplayName,
    };
}