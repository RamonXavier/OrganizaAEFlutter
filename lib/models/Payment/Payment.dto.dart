// ignore_for_file: prefer_collection_literals, unnecessary_new

class PaymentDto {
  int? id;
  int? idUser;
  int? idMounth;
  int? idSocial;
  int? year;
  int? status;

  PaymentDto(
      {this.id,
      this.idUser,
      this.idMounth,
      this.idSocial,
      this.year,
      this.status});

  PaymentDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    idMounth = json['idMounth'];
    idSocial = json['idSocial'];
    year = json['year'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['idUser'] = idUser;
    data['idMounth'] = idMounth;
    data['idSocial'] = idSocial;
    data['year'] = year;
    data['status'] = status;
    return data;
  }
}
