class LoginUser {
  LoginUser({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
