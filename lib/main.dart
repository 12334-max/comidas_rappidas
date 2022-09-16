import 'package:flutter/material.dart';
import 'package:rappi_2/src/pages/login.dart';
import 'src/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/Home',
    routes: {
      '/Home': (context) => HomePage(),
      '/Login': (context) => Login(),
    },
  ));
}
