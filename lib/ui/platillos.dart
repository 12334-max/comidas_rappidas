import 'package:flutter/material.dart';
import '../models/db.dart';
import '../models/platillo.dart';

class VistaPlatillos extends StatefulWidget {
  VistaPlatillos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<VistaPlatillos> createState() => _VistaPlatillosState();
}

class _VistaPlatillosState extends State<VistaPlatillos> {
  String? _token = "";
  List<Platillo> _platillos = [];
  TextEditingController _txtController = TextEditingController();

  @override
  void initState() {
    print("Iniciando");
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: _token == ""
          ? const CircularProgressIndicator(color: Colors.amberAccent)
          : FutureBuilder(
              future: Platillo.leeTodos(_token!, _txtController.text),
              builder: (context, AsyncSnapshot<List<Platillo>> snapshot) {
                if (snapshot.hasData) {
                  _platillos = snapshot.data!;
                  return _columnaCentral();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.amberAccent),
                  );
                }
              },
            ),
      //drawer: menuOpciones(context),
    );
  }

  Widget _filtros() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: TextField(
        controller: _txtController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            label: Text('Buscar:'), helperText: 'Busca platillos'),
      ),
      trailing: IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          print("Buscando " + _txtController.text);
          setState(() {});
        },
      ),
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
