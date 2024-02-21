class UserModel {
  String? name;
  String? email;
  String? bio;
  String? birthDate;
  List<String>? hobbies;

  UserModel({this.name, this.email, this.bio, this.birthDate, this.hobbies});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    bio = json['bio'];
    birthDate = json['birthDate'];
    hobbies =
        json['hobbies'] != null ? List<String>.from(json['hobbies']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['bio'] = bio;
    data['birthDate'] = birthDate;
    data['hobbies'] = hobbies;
    return data;
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, bio: $bio, dateOfBirth: $birthDate, hobbies: $hobbies)';
  }
}
