import 'package:comidas_app/ui/platillos.dart';
import 'package:flutter/material.dart';

Drawer menuOpciones(BuildContext context) {
  return Drawer(
    child: DrawerHeader(
        decoration: BoxDecoration(color: Colors.orange),
        child: ListView(
          children: _opciones(context),
        )),
  );
}

List<Widget> _opciones(BuildContext context) {
  List<Widget> opc = [];

  opc.add(ListTile(
    leading: Icon(Icons.bookmark_border, color: Colors.white),
    title: Text('COMIDAS', style: TextStyle(fontSize: 30, color: Colors.white)),
    onTap: () => Navigator.of(context).pop(),
  ));

  opc.add(Divider(color: Colors.white, thickness: 2));

  opc.add(ListTile(
    leading: Icon(Icons.person_outline, color: Colors.white),
    title:
        Text("Mi Perfil", style: TextStyle(fontSize: 20, color: Colors.white)),
    onTap: () {
      Navigator.of(context).pop();
    },
  ));

  opc.add(ListTile(
    leading: Icon(Icons.list, color: Colors.white),
    title: Text("Mis Platillos",
        style: TextStyle(fontSize: 20, color: Colors.white)),
    onTap: () {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VistaPlatillos(title: ""),
        ),
      );
    },
  ));

  opc.add(ListTile(
    leading: Icon(Icons.info_outline, color: Colors.white),
    title:
        Text('Acerca de', style: TextStyle(fontSize: 20, color: Colors.white)),
    onTap: () {
      Navigator.of(context).pop();
    },
  ));

  return opc;
}
