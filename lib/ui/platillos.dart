import 'dart:ffi';

import 'package:comidas_app/model/db.dart';
import 'package:comidas_app/model/pedido.dart';
import 'package:comidas_app/model/platillo.dart';
import 'package:comidas_app/ui/menu_opciones.dart';
import 'package:flutter/material.dart';

class VistaPlatillos extends StatefulWidget {
  const VistaPlatillos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<VistaPlatillos> createState() => _VistaPlatillosState();
}

class _VistaPlatillosState extends State<VistaPlatillos> {
  String? _token = "";
  List<Platillo> _platillos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperaToken();
  }

  void recuperaToken() async {
    _token = await Datos.leeToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: [
        BackButton(onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        }),
      ]),
      body: FutureBuilder(
        future: Platillo.leeTodos(_token!),
        builder: (context, AsyncSnapshot<List<Platillo>> snapshot) {
          if (snapshot.hasData) {
            _platillos = snapshot.data!;
            return _columnaCentral();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      drawer: menuOpciones(context),
    );
  }

  Widget _columnaCentral() {
    return SingleChildScrollView(
        child: Column(
      children: [_listaPlatillos()],
    ));
  }

  Widget _listaPlatillos() {
    print("CREANDO LISTA CON " + _platillos.length.toString() + " PLATILLOS");
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Platillo p = _platillos[i];
        return ListTile(
          title: Text(p.nombre),
          subtitle: Text(p.descripcion),
          trailing: Text("\$" + p.precio.toString()),
        );
      },
      itemCount: _platillos.length,
    );
  }
}
