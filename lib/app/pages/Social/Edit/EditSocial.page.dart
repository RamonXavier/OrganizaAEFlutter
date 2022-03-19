// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:organiza_ae/app/Helpers/api.helper.dart';
import 'package:http/http.dart' as http;
import 'package:organiza_ae/models/Social/Social.dto.dart';

class EditSocial extends StatefulWidget {
  const EditSocial({Key? key}) : super(key: key);

  @override
  State<EditSocial> createState() => _EditSocialState();
}

class _EditSocialState extends State<EditSocial> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  final SocialDto _socialSubmit = SocialDto();
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
      _socialSubmit.id = 0;
      var url = Uri.parse(ApiEnviroment().socialCreate);

      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(_socialSubmit),
      );

      if (response.statusCode != 0) {
        setSaving();
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Nova social salvo com sucesso.'),
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
        title: Text("Nova social: "),
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
                          _socialSubmit.name = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.person_pin_circle_outlined),
                          ),
                          hintText: 'Nome social',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o nome da social';
                          }

                          if (value.length <= 3) {
                            return 'O nome da social deve ser maior \nque 3 caracteres \n';
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
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
