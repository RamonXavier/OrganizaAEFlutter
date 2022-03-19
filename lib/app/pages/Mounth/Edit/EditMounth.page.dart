// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:organiza_ae/models/Mounth/Mounth.dto.dart';
import 'package:http/http.dart' as http;

class EditMounth extends StatefulWidget {
  const EditMounth({Key? key}) : super(key: key);

  @override
  State<EditMounth> createState() => _EditMounthState();
}

class _EditMounthState extends State<EditMounth> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  final MounthDto _mounthSubmit = MounthDto();
  late AnimationController _controller;

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

  void setSaving() {
    setState(() {
      _saving = !_saving;
    });
  }

  Future<void> submit() async {
    try {
      _formKey.currentState!.save();
      _mounthSubmit.id = 0;
      var url = Uri.parse(ApiEnviroment().mounthCreate);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(_mounthSubmit),
      );

      if (response.statusCode != 0) {
        setSaving();
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Novo mês salvo com sucesso.'),
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
        title: Text("Novo mês: "),
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
                          _mounthSubmit.name = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.calendar_today),
                          ),
                          hintText: 'Nome do mês',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o nome do mês';
                          }

                          if (value.length <= 3) {
                            return 'O nome de mês deve ser maior \nque 3 caracteres \n';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (String? value) {
                          _mounthSubmit.number = int.parse(value!);
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.format_list_numbered),
                          ),
                          hintText: 'Ano do mês',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o ano do mês';
                          }

                          if (int.parse(value) < DateTime.now().year) {
                            return 'Preencha um ano maior ou igual a ' +
                                DateTime.now().year.toString();
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
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
