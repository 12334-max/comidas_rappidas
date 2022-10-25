import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsService extends StatefulWidget {
  const MapsService({Key? key}) : super(key: key);

  @override
  State<MapsService> createState() => _MapsServiceState();
}

class _MapsServiceState extends State<MapsService> {
  //La posicion inicial de la camara en el mapa
  final initialCameraPosition =
      const CameraPosition(target: LatLng(16.9147152, -92.094464), zoom: 15);

  //Controlador del maps
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GOOGLE MAPS')),
      body: _body(),
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
            initialCameraPosition: initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        )
      ]),
    );
  }
}
