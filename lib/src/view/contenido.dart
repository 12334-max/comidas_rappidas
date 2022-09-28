import 'package:flutter/material.dart';

class ContenidoPage extends StatefulWidget {
  const ContenidoPage({Key? key}) : super(key: key);

  @override
  State<ContenidoPage> createState() => _ContenidoPageState();
}

class _ContenidoPageState extends State<ContenidoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('hola'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.adb_sharp), label: 'Pendientes')
        ],
      ),
    );
  }
}
