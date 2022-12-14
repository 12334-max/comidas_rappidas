import 'package:flutter/material.dart';
import 'package:rappi_2/models/db.dart';
import 'package:rappi_2/models/pedido.dart';
import 'package:rappi_2/ui/platillos_add.dart';
import '../ui/menu_opciones.dart';

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

  Function refresca() {
    return () {
      setState(() {});
    };
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
      drawer: drawer(context),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AgregaPlatillo(
                    title: "Agregar Platillo", refrescaVentana: refresca()),
              ));
        },
      ),
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
      const Text("Pedidos"),
      Radio(
          value: "PROCESO",
          groupValue: _filtroSeleccionado,
          onChanged: (value) {
            setState(() {
              _filtroSeleccionado = "PROCESO";
            });
          }),
      const Text("En Proceso"),
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
