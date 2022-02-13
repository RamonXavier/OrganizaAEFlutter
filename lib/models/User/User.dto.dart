// ignore_for_file: prefer_collection_literals, unnecessary_new

class UserDto {
  int? id;
  String? name;
  String? email;
  String? password;

  UserDto({this.id, this.name, this.email, this.password});

  UserDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
