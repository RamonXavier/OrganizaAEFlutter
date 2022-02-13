class MounthDto {
  int? id;
  String? name;
  int? number;

  MounthDto({this.id, this.name, this.number});

  MounthDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    return data;
  }
}
