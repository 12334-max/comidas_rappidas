import 'package:flutter/material.dart';
import 'package:rappi_2/src/pages/login.dart';
import 'package:rappi_2/src/view/contenido.dart';
import 'src/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/Home',
    routes: {
      '/Home': (context) => const HomePage(),
      '/Login': (context) => const Login(),
      '/Contenido': (context) => const ContenidoPage()
    },
  ));
}
