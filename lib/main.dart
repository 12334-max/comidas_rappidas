import 'package:flutter/material.dart';
import 'package:rappi_2/ui/login.dart';
import 'package:rappi_2/ui/welcome.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/Login',
    routes: {
      '/Home': (context) => const Contenido(),
      '/Login': (context) => const Login(),
    },
  ));
}
