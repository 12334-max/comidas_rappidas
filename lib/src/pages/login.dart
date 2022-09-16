import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static String id = 'login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: const Color.fromARGB(255, 255, 174, 0),
          title: const Text('COMIDAS'),
        ),*/
        body: Center(
          child: Column(children: [_formLogin()]),
        ),
      ),
    );
  }

  bool _ocultarPassword = true;
  Icon _iconEye = const Icon(Icons.visibility_off);

  Widget _formLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 100.0)),
          Image.asset(
            'images/login/logo1.png',
            height: 200,
            width: 300,
          ),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 50.0),
            title: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  label: Text(
                    'Email',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  helperText: 'Ingrese su Email'),
            ),
            trailing: Icon(Icons.mail),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 50.0),
            title: TextField(
              keyboardType: TextInputType.text,
              obscureText: _ocultarPassword,
              decoration: const InputDecoration(
                  label: Text(
                    'Password',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  helperText: 'Ingrese su contraseña'),
            ),
            trailing: IconButton(
              icon: _iconEye,
              onPressed: () {
                setState(() {
                  _ocultarPassword = !_ocultarPassword;
                  _iconEye = _ocultarPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility);
                });
              },
            ),
          ),
          ElevatedButton(
            child: const Text('Iniciar'),
            onPressed: () {},
          )
        ],
      );
    });
  }
}
