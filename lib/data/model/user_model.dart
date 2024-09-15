class UserModel {
  String iduser;
  String name;
  String email;
  String password;

  UserModel({
    required this.iduser,
    required this.name,
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      iduser: json['iduser'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iduser': iduser,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
