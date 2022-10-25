import 'package:flutter/material.dart';
import 'package:rappi_2/models/db.dart';
import 'package:rappi_2/models/platillo.dart';

class AgregaPlatillo extends StatefulWidget {
  const AgregaPlatillo(
      {Key? key, required this.title, required this.refrescaVentana})
      : super(key: key);

  final String title;
  final Function refrescaVentana;

  @override
  State<AgregaPlatillo> createState() => _AgregaPlatilloState();
}

class _AgregaPlatilloState extends State<AgregaPlatillo> {
  String? _token = "";
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _precioController = TextEditingController();
  TextEditingController _categoriaController = TextEditingController();

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nombreController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    label: Text('Nombre:'), helperText: 'Nombre del platillo'),
              ),
              TextField(
                controller: _descripcionController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    label: Text('Descripción:'),
                    helperText: 'Descripción del platillo'),
              ),
              TextField(
                controller: _precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Precio:'),
                    helperText: 'Precio de venta del platillo'),
              ),
              TextField(
                controller: _categoriaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    label: Text('Categoría:'),
                    helperText: 'Categoría del platillo'),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      Platillo platillo = Platillo(
                          id: 0,
                          nombre: _nombreController.text,
                          descripcion: _descripcionController.text,
                          precio: double.parse(_precioController.text),
                          categoria: _categoriaController.text,
                          status: '');

                      bool respuesta = await platillo.registra(_token!);

                      if (respuesta) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('¡Platillo Registrado!')));
                        Navigator.of(context).pop();
                        widget.refrescaVentana.call();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('¡ERROR!')));
                      }
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
