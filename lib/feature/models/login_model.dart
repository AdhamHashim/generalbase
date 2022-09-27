class LoginModel {
  final String email, password;
  LoginModel({
    required this.email,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(email: json['name'], password: json['password']);
}
