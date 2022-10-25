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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: Center(child: _formLogin()),
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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 60.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            Image.asset(
              'images/login/logo1.png',
              height: 200.0,
            ),
            TextFormField(
              controller: _txtController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text(
                  'Email',
                  style: TextStyle(fontSize: 20.0),
                ),
                icon: IconButton(onPressed: null, icon: Icon(Icons.email)),
                helperText: 'Ingrese su email',
              ),
            ),
            TextFormField(
              controller: _passController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: const Text('Passwrod', style: TextStyle(fontSize: 20.0)),
                icon: _icon(),
                helperText: 'Ingrese su contraseña',
              ),
              obscureText: _ocultarPassword,
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 150.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () async {
                  String r = await Usuario.valida(
                      _txtController.value.text, _passController.value.text);
                  var json = jsonDecode(r);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(json['respuesta'])));

                  if (json['respuesta'] == 'Bienvenido') {
                    Datos.registraToken(json['token']);
                    Navigator.pushNamed(context, '/Home');
                  }
                },
                child: const Text(
                  'Iniciar',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
