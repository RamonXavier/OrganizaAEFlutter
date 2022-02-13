// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:organiza_ae/models/Mounth/Mounth.dto.dart';
import 'package:http/http.dart' as http;

class ListMounth extends StatefulWidget {
  const ListMounth({Key? key}) : super(key: key);
  @override
  _ListMounth createState() => _ListMounth();
}

class _ListMounth extends State<ListMounth> {
  var _mounthList = <MounthDto>[];
  var _quantity = 0;

  Future<List<MounthDto>> _futureGetMounth() async {
    try {
      List<MounthDto> mounthListApi = [];
      var url = Uri.parse(ApiEnviroment().mounthGetAll);

      final response = await http.get(url);

      if (response.statusCode != 0) {
        var json = jsonDecode(response.body) as List;
        for (var item in json) {
          mounthListApi.add(MounthDto.fromJson(item));
        }
      }
      return mounthListApi;
    } catch (e) {
      return throw Exception("Erro ao Buscar dados");
    }
  }

  newState(List<MounthDto> listMounth) {
    setState(() {
      _mounthList = listMounth;
      _quantity = _mounthList.length;
    });
  }

  @override
  void initState() {
    super.initState();
    var listaTemporaria = <MounthDto>[];

    _futureGetMounth().then((value) => {
          listaTemporaria = value,
          newState(listaTemporaria),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de meses: $_quantity"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _mounthList.length,
          itemBuilder: (BuildContext context, int index) {
            final itemActualy = _mounthList[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 60,
                color: Colors.deepPurple[300],
                child: Center(
                  child: Text(
                    itemActualy.name ?? "",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
