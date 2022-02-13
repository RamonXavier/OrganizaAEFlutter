// ignore_for_file: prefer_collection_literals, unnecessary_new

class PaymentListDto {
  int? id;
  int? year;
  int? status;
  int? idUser;
  String? nameUser;
  String? email;
  int? idSocial;
  String? nameSocial;
  String? nameMounth;
  int? numberMounth;
  int? mounthId;

  PaymentListDto(
      {this.id,
      this.year,
      this.status,
      this.idUser,
      this.nameUser,
      this.email,
      this.idSocial,
      this.nameSocial,
      this.nameMounth,
      this.numberMounth,
      this.mounthId});

  PaymentListDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    status = json['status'];
    idUser = json['idUser'];
    nameUser = json['nameUser'];
    email = json['email'];
    idSocial = json['idSocial'];
    nameSocial = json['nameSocial'];
    nameMounth = json['nameMounth'];
    numberMounth = json['numberMounth'];
    mounthId = json['mounthId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['year'] = year;
    data['status'] = status;
    data['idUser'] = idUser;
    data['nameUser'] = nameUser;
    data['email'] = email;
    data['idSocial'] = idSocial;
    data['nameSocial'] = nameSocial;
    data['nameMounth'] = nameMounth;
    data['numberMounth'] = numberMounth;
    data['mounthId'] = mounthId;
    return data;
  }
}
