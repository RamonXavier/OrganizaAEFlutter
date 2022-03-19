// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:organiza_ae/models/User/User.dto.dart';
import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  bool _saving = false;
  final UserDto _userSubmit = UserDto();
  late AnimationController _controller;
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    _controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void notificationSubmissionForm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Validando informações...'),
        duration: Duration(seconds: 1),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Salvando dados...'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void changeIconPassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  void setSaving() {
    setState(() {
      _saving = !_saving;
    });
  }

  Future<void> submit() async {
    _formKey.currentState!.save();
    _userSubmit.id = 0;
    try {
      var url = Uri.parse(ApiEnviroment().userCreate);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(_userSubmit),
      );

      if (response.statusCode != 0) {
        setSaving();
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Novo usuário salvo com sucesso.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      throw Exception("Erro ao salvar dados");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo usuário: "),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                flex: 30,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        onSaved: (String? value) {
                          _userSubmit.name = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.person),
                          ),
                          hintText: 'Nome de usuário',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o nome do usuário';
                          }

                          if (value.length <= 5) {
                            return 'O nome de usuário deve ser maior \nque 5 caracteres \n';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        onSaved: (String? value) {
                          _userSubmit.email = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.mail),
                          ),
                          hintText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o email';
                          }

                          if (value.length <= 5 || !value.contains('@')) {
                            return 'Preencha um email válido';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        obscureText: _hidePassword,
                        onSaved: (String? value) {
                          _userSubmit.password = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.password),
                          ),
                          suffixIcon: IconButton(
                            icon: _hidePassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: () {
                              changeIconPassword();
                            },
                          ),
                          hintText: 'Senha',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha sua senha';
                          }

                          if (value.length <= 4) {
                            return 'A senha deve conter no mínimo \n 4 caracteres';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 26.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: !_saving
                                ? MaterialStateProperty.all<Color>(Colors.green)
                                : MaterialStateProperty.all<Color>(
                                    Colors.white),
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate() && !_saving) {
                              notificationSubmissionForm();
                              setSaving();
                              Timer(Duration(seconds: 4), () {
                                submit();
                              });
                            }
                          },
                          child: !_saving
                              ? Text(
                                  "Salvar",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              : CircularProgressIndicator(
                                  value: _controller.value,
                                  semanticsLabel: 'Linear progress indicator',
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
