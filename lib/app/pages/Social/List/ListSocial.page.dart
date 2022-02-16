// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:http/http.dart' as http;
import 'package:organiza_ae/models/Social/Social.dto.dart';

class ListSocial extends StatefulWidget {
  const ListSocial({Key? key}) : super(key: key);
  @override
  _ListSocial createState() => _ListSocial();
}

class _ListSocial extends State<ListSocial> {
  var _socialList = <SocialDto>[];
  var _quantity = 0;

  Future<List<SocialDto>> _futureGetSocial() async {
    try {
      List<SocialDto> socialListApi = [];
      var url = Uri.parse(ApiEnviroment().socialGetAll);

      final response = await http.get(url);

      if (response.statusCode != 0) {
        var json = jsonDecode(response.body) as List;
        for (var item in json) {
          socialListApi.add(SocialDto.fromJson(item));
        }
      }
      return socialListApi;
    } catch (e) {
      return throw Exception("Erro ao Buscar dados");
    }
  }

  newState(List<SocialDto> listSocial) {
    setState(() {
      _socialList = listSocial;
      _quantity = _socialList.length;
    });
  }

  void _removeSocial(int id) async {
    try {
      var url = Uri.parse(ApiEnviroment().socialDelete + "/" + id.toString());

      final response = await http.delete(url);

      if (response.statusCode != 0) {
        _getSocialAndReoladPage();
      }
    } catch (e) {
      throw Exception("Erro ao excluir social");
    }
  }

  void _getSocialAndReoladPage() {
    var tempList = <SocialDto>[];
    _futureGetSocial().then((value) => {
          tempList = value,
          newState(tempList),
        });
  }

  @override
  void initState() {
    super.initState();
    _getSocialAndReoladPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de sociais: $_quantity"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _socialList.length,
          itemBuilder: (BuildContext context, int index) {
            final itemActualy = _socialList[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Dismissible(
                key: Key(itemActualy.id.toString()),
                background: Container(
                  color: Colors.redAccent.withOpacity(0.9),
                ),
                onDismissed: (direction) {
                  if (itemActualy.id != null) {
                    _removeSocial(itemActualy.id ?? 0);
                  }
                },
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
              ),
            );
          },
        ),
      ),
    );
  }
}
