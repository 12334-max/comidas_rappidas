import 'package:flutter/material.dart';
import 'platillos.dart';

Drawer drawer(BuildContext context) {
  return Drawer(
    //Creamos el Drawer en forma de lista
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        //encabezado del Drawer
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.orange,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Home');
            },
            icon: const Icon(Icons.account_circle),
            iconSize: 100.0,
          ),
        ),
        //Opciones dentro del Drawer
        ListTile(
          title: const Text('Platillos'),
          onTap: () {
            Navigator.pushNamed(context, '/Platillos');
          },
          trailing: const Icon(Icons.home),
        ),
        ListTile(
          title: const Text('Cerra Sesion'),
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/Login', (route) => route == false);
          },
          trailing: const Icon(Icons.logout),
        ),
      ],
    ),
  );
}
