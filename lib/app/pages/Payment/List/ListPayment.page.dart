// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:http/http.dart' as http;
import 'package:organiza_ae/app/Helpers/statusPayment.helper.dart';
import 'package:organiza_ae/models/Payment/PaymentList.dto.dart';

class ListPayment extends StatefulWidget {
  const ListPayment({Key? key}) : super(key: key);
  @override
  _ListPayment createState() => _ListPayment();
}

class _ListPayment extends State<ListPayment> {
  var _paymentList = <PaymentListDto>[];
  var _quantity = 0;

  Future<List<PaymentListDto>> _futureGetPayment() async {
    try {
      List<PaymentListDto> paymentListApi = [];
      var url = Uri.parse(ApiEnviroment().paymentGetAll);

      final response = await http.get(url);

      if (response.statusCode != 0) {
        var json = jsonDecode(response.body) as List;
        for (var item in json) {
          paymentListApi.add(PaymentListDto.fromJson(item));
        }
      }
      return paymentListApi;
    } catch (e) {
      return throw Exception("Erro ao Buscar dados");
    }
  }

  newState(List<PaymentListDto> listPayment) {
    setState(() {
      _paymentList = listPayment;
      _quantity = _paymentList.length;
    });
  }

  @override
  void initState() {
    super.initState();
    var tempList = <PaymentListDto>[];

    _futureGetPayment().then((value) => {
          tempList = value,
          newState(tempList),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de pagamentos: $_quantity"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _paymentList.length,
          itemBuilder: (BuildContext context, int index) {
            final itemActualy = _paymentList[index];
            final statusActualy = itemActualy.status ?? 4;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 80,
                color: Colors.deepPurple[300],
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          itemActualy.nameUser ?? "",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          itemActualy.nameMounth ?? "",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        Text(
                          " " + itemActualy.year.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          itemActualy.nameSocial ?? "",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StatusPayment().status[statusActualy - 1],
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
