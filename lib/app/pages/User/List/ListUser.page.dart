// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:http/http.dart' as http;
import 'package:organiza_ae/models/User/User.dto.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);
  @override
  _ListUser createState() => _ListUser();
}

class _ListUser extends State<ListUser> {
  var _userList = <UserDto>[];
  var _quantity = 0;

  Future<List<UserDto>> _futureGetUser() async {
    try {
      List<UserDto> userListApi = [];
      var url = Uri.parse(ApiEnviroment().userGetAll);

      final response = await http.get(url);

      if (response.statusCode != 0) {
        var json = jsonDecode(response.body) as List;
        for (var item in json) {
          userListApi.add(UserDto.fromJson(item));
        }
      }
      return userListApi;
    } catch (e) {
      return throw Exception("Erro ao Buscar dados");
    }
  }

  void _removeUser(int id) async {
    try {
      var url = Uri.parse(ApiEnviroment().userDelete + "/" + id.toString());

      final response = await http.delete(url);

      if (response.statusCode != 0) {
        _getUserAndReoladPage();
      }
    } catch (e) {
      throw Exception("Erro ao excluir usuário");
    }
  }

  void _getUserAndReoladPage() {
    var tempList = <UserDto>[];
    _futureGetUser().then((value) => {
          tempList = value,
          newState(tempList),
        });
  }

  newState(List<UserDto> listUser) {
    setState(() {
      _userList = listUser;
      _quantity = _userList.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserAndReoladPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listagem de usuários: $_quantity"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (BuildContext context, int index) {
            final itemActualy = _userList[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Dismissible(
                key: Key(itemActualy.id.toString()),
                background: Container(
                  color: Colors.redAccent.withOpacity(0.9),
                ),
                onDismissed: (direction) => {
                  if (itemActualy.id != null)
                    {
                      _removeUser(itemActualy.id ?? 0),
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
