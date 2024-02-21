class RegisterModel {
  String name;
  String email;
  String password;
  String bio;
  String birthDate;
  String? hobbies;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.birthDate,
    required this.bio,
  });

  // RegisterModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   email = json['email'];
  //   password = json['password'];
  //   bio = json['bio'];
  //   birthDate = json['birthDate'];
  //   hobbies = json['hobbies'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['bio'] = bio;
    data['birthDate'] = birthDate;
    data['hobbies'] = hobbies;

    return data;
  }
}
