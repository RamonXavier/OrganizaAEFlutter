// ignore_for_file: unnecessary_new, prefer_collection_literals

class SocialDto {
  int? id;
  String? name;

  SocialDto({this.id, this.name});

  SocialDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
