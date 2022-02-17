// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:organiza_ae/app/pages/Mounth/List/ListMounth.page.dart';
import 'package:organiza_ae/app/pages/Payment/List/ListPayment.page.dart';
import 'package:organiza_ae/app/pages/Social/List/ListSocial.page.dart';
import 'package:organiza_ae/app/pages/Social/Social.service.dart';
import 'package:organiza_ae/app/pages/User/List/ListUser.page.dart';

class MenuDefaultAdmin extends StatelessWidget {
  const MenuDefaultAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: Colors.purple,
        textStyle: const TextStyle(
          fontSize: 20,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Principal"),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 12, top: 70, right: 12, bottom: 10),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  flex: 33, // 20%
                  child: Container(
                    color: Colors.red,
                    height: 240,
                    child: Center(
                      child: ElevatedButton(
                        style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListUser()),
                          );
                        },
                        child: Text(
                          "Usuários",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 33, // 60%
                  child: Container(
                    color: Colors.green,
                    height: 240,
                    child: Center(
                      child: ElevatedButton(
                        style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListPayment()),
                          );
                        },
                        child: Text(
                          "Pagamentos",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 33, // 20%
                  child: Container(
                    color: Colors.yellow,
                    height: 240,
                    child: Center(
                      child: ElevatedButton(
                        style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListMounth()),
                          );
                        },
                        child: Text(
                          "Meses",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 33, // 60%
                  child: Container(
                    color: Colors.orange,
                    height: 240,
                    child: Center(
                      child: ElevatedButton(
                        style: style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListSocial()),
                          );
                        },
                        child: Text(
                          "Sociais",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
