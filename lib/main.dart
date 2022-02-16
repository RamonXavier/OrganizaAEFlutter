// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'app/pages/Social/List/ListSocial.page.dart';
import 'app/pages/User/List/ListUser.page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OrganizaAE",
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        secondaryHeaderColor: Colors.purpleAccent,
      ),
      //home: ListMounth(),
      home: ListUser(),
      //home: ListSocial(),
      //home: ListPayment(),
    );
  }
}
