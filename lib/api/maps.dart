import 'dart:async';
import 'dart:convert';
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

  //Controlador del maps
  final Completer<GoogleMapController> _controller = Completer();

  //la distancia
  String distancia = "0 km";
  //tiempo de llegada
  String tiempo = "0 min";

  //Lista de Puntos del constructor
  static final List<Lugar> puntos = [
    Lugar(
      "Restaurant",
      const CameraPosition(
          target: LatLng(16.9147152, -92.094464),
          zoom: 15,
          bearing: 0,
          tilt: 0),
    ),
    Lugar(
      "Barrio Tonina",
      const CameraPosition(
          target: LatLng(16.909373, -92.085774),
          zoom: 15,
          bearing: 15,
          tilt: 10),
    ),
    Lugar(
      "Ganadera",
      const CameraPosition(
          target: LatLng(16.904234, -92.0942218),
          zoom: 16,
          tilt: 45,
          bearing: 15),
    ),
    Lugar(
      "San Sebastian",
      const CameraPosition(
          target: LatLng(16.905745, -92.100711),
          zoom: 16,
          tilt: 45,
          bearing: 15),
    )
  ];
  //AlzaSyD1BvGcL4RcRDwtct5muLBdc0fbncjQrn8
  //AIzaSyD1BvGcL4RcRDwtct5muLBdc0fbncjQrn8

  //consumiendo la API de google maps
  Future obtenerDistancia(String destino) async {
    try {
      final respuesta = await http.Client()
          .get(Uri.https('maps.googleapis.com', '/maps/api/directions/json', {
        "key": "AIzaSyD1BvGcL4RcRDwtct5muLBdc0fbncjQrn8",
        "origin": "16.9147152, -92.094464",
        "destination": destino,
        "mode": "driving"
      }));

      if (respuesta.statusCode == 200) {
        print("La Respuesta es: " + respuesta.body);
        Map<String, dynamic> respuestaJSON = json.decode(respuesta.body);
        distancia = respuestaJSON['routes'][0]['legs'][0]['distance']['text'];
        tiempo = respuestaJSON['routes'][0]['legs'][0]['duration']['text'];
        print(respuestaJSON);

        return true;
      }
    } on SocketException {
      print("Error de conexion API de google maps");
    }
    return false;
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
        label: const Text("s"),
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
            markers: _creaMarcas(),
            mapType: MapType.hybrid,
            initialCameraPosition: puntos[puntoActual % 4].ubicacion,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Center(
          child: Container(
            height: 50,
            color: Colors.blue,
            child: Column(
              children: [
                Text('Lugar: restaurante a ${puntos[puntoActual].nombre}'),
                Text("La distacia: " + distancia),
                Text("En un estimado de: " + tiempo + " Llegará su Orden"),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Future<void> _siguiente() async {
    puntoActual++;
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(puntos[puntoActual % 4].ubicacion));

    String dest =
        "${puntos[puntoActual % 4].ubicacion.target.latitude},${puntos[puntoActual % 4].ubicacion.target.longitude}";
    await obtenerDistancia(dest);
    setState(() {});
  }

  Set<Marker> _creaMarcas() {
    var tmp = <Marker>{};
    tmp.add(const Marker(
        markerId: MarkerId("restaurant"),
        position: LatLng(16.9147152, -92.094464),
        infoWindow: InfoWindow(title: "Restaurante")));
    tmp.add(Marker(
      markerId: const MarkerId("DESTINO"),
      position: LatLng(puntos[puntoActual % 4].ubicacion.target.latitude,
          puntos[puntoActual % 4].ubicacion.target.longitude),
      infoWindow: InfoWindow(title: puntos[puntoActual].nombre),
    ));

    return tmp;
  }
}

class Lugar {
  String nombre;
  CameraPosition ubicacion;
  Lugar(this.nombre, this.ubicacion);
}
