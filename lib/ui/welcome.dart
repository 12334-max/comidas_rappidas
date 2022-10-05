import 'package:flutter/material.dart';

import 'package:rappi_2/models/db.dart';
import 'package:rappi_2/models/pedido.dart';

class Contenido extends StatefulWidget {
  const Contenido({Key? key}) : super(key: key);

  @override
  State<Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  String? _token = "";
  List<Pedido> _pedidos = [];
  String _filtroSeleccionado = "PEDIDO";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperaToken();
    leePedidos();
  }

  void recuperaToken() async {
    _token = await Datos.leeToken();
    setState(() {});
  }

  void leePedidos() {
    _pedidos.add(Pedido(
        id: 1,
        cliente: "Cliente 1",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PEDIDO"));
    _pedidos.add(Pedido(
        id: 2,
        cliente: "Cliente 2",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PEDIDO"));
    _pedidos.add(Pedido(
        id: 3,
        cliente: "Cliente 3",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PROCESO"));
    _pedidos.add(Pedido(
        id: 4,
        cliente: "Cliente 4",
        fecha: DateTime(2022, 9, 26, 19, 38),
        total: 254.34,
        status: "PROCESO"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                Navigator.pushNamed(context, '/Home');
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
      ),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('RAPPI 2'),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.blueGrey,
            onPressed: () {
              Navigator.pushNamed(context, '/Home');
            },
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 40.0,
            ),
            padding: const EdgeInsets.only(right: 30.0),
          )
        ],
      ),
      body: _columnaCentral(),
    );
  }

  Widget _columnaCentral() {
    return SingleChildScrollView(
        child: Column(
      children: [_filtros(), _listaPedidos()],
    ));
  }

  Widget _filtros() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Radio(
          value: "PEDIDO",
          groupValue: _filtroSeleccionado,
          onChanged: (value) {
            setState(() {
              _filtroSeleccionado = "PEDIDO";
            });
          }),
      Text("Pedidos"),
      Radio(
          value: "PROCESO",
          groupValue: _filtroSeleccionado,
          onChanged: (value) {
            setState(() {
              _filtroSeleccionado = "PROCESO";
            });
          }),
      Text("En Proceso"),
    ]);
  }

  Widget _listaPedidos() {
    List<Pedido> _filtrados = [];
    for (Pedido p in _pedidos) {
      if (p.status == _filtroSeleccionado) {
        _filtrados.add(p);
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Pedido p = _filtrados[i];
        return ListTile(
          title: Text("#" + p.id.toString() + " " + p.fecha.toString()),
          subtitle: Text(p.cliente + " \$" + p.total.toString()),
          trailing: IconButton(
            icon: Icon(p.status == "PEDIDO" ? Icons.tab : Icons.access_alarms),
            onPressed: null,
            color: Colors.green,
          ),
        );
      },
      itemCount: _filtrados.length,
    );
  }
}
