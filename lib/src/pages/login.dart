import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rappi_2/models/usuario.dart';
import 'package:rappi_2/models/db.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(children: [_formLogin()]),
        ),
      ),
    );
  }

  bool _ocultarPassword = true;
  Icon _iconEye = const Icon(Icons.visibility_off);
  TextEditingController _txtController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget _formLogin() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'images/login/logo1.png',
                width: 300,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('Email'),
                  icon: Icon(Icons.email),
                  helperText: 'Ingrese su email',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo requerido';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: const Text('Passwrod'),
                  icon: _icon(),
                  helperText: 'Ingrese su contraseña',
                ),
                obscureText: _ocultarPassword,
              ),
              const SizedBox(
                height: 30.0,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(color: Colors.yellow[800]),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        String r = await Usuario.valida(
                            _txtController.value.text,
                            _passController.value.text);
                        var json = jsonDecode(r);

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(json['respuesta'])));

                        if (json['respuesta'] == 'Bienvenido') {
                          Datos.registraToken(json['token']);
                          //Navigator.pushNamed(context, '/Home');
                        }
                      },
                      child: const Text('Iniciar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _icon() {
    return IconButton(
      icon: _iconEye,
      onPressed: () {
        setState(() {
          _ocultarPassword = !_ocultarPassword;
          _iconEye = _ocultarPassword
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility);
        });
      },
    );
  }
}
