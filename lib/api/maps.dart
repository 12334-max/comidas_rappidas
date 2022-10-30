import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsService extends StatefulWidget {
  const MapsService({Key? key}) : super(key: key);

  @override
  State<MapsService> createState() => _MapsServiceState();
}

class _MapsServiceState extends State<MapsService> {
  int puntoActual = 0;
  bool loading = true;
  //La posicion inicial de la camara en el mapa
  final initialCameraPosition =
      const CameraPosition(target: LatLng(16.9147152, -92.094464), zoom: 15);

  //Controlador del maps
  final Completer<GoogleMapController> _controller = Completer();

  //Lista de Puntos del constructor
  static final List<Lugar> puntos = [
    Lugar(
      "Ocosing",
      const CameraPosition(
          target: LatLng(16.9147152, -92.094464),
          zoom: 15,
          bearing: 0,
          tilt: 0),
    ),
    Lugar(
      "Tonina",
      const CameraPosition(
          target: LatLng(16.8987622, -92.0062749),
          zoom: 15,
          bearing: 15,
          tilt: 45),
    ),
    Lugar(
      "Jatate",
      const CameraPosition(
          target: LatLng(16.8288727, -91.8877347),
          zoom: 16,
          tilt: 45,
          bearing: 15),
    )
  ];

  //consumiendo la API de google maps
  Future obtenerDistancia(String destino) async {
    try {
      final _respuesta = await http.Client()
          .get(Uri.https('maps.googleapis.com', '/maps/api/directions/json', {
        "key": "AIzaSyDPLKZRlYnhsh5LvNrNxrX-tUiPUKJNJ9Y",
        "origin": "16.9147152, -92.094464",
        "destination": destino,
        "mode": "driving"
      }));

      if (_respuesta.statusCode == 200) {
        print("La Respuesta es: " + _respuesta.body);
      }
    } on SocketException {
      print("Error de conexion API de google maps");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GOOGLE MAPS'),
        backgroundColor: Colors.orange,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: _siguiente,
        label: const Text("Siguiente"),
        icon: const Icon(Icons.skip_next),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          //color: Colors.black,
          height: 400,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: puntos[puntoActual % 4].ubicacion,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Center(
          child: Text('Lugar' + puntos[puntoActual % 4].nombre),
        )
      ]),
    );
  }

  Future<void> _siguiente() async {
    puntoActual++;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(puntos[puntoActual % 4].ubicacion));
    String dist = puntos[puntoActual % 4].ubicacion.target.latitude.toString() +
        "," +
        puntos[puntoActual % 4].ubicacion.target.longitude.toString();
    obtenerDistancia(dist);
    setState(() {});
  }
}

class Lugar {
  String nombre;
  CameraPosition ubicacion;
  Lugar(this.nombre, this.ubicacion);
}
