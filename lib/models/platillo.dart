import 'dart:convert';

import 'package:http/http.dart' as http;

class Platillo {
  int id;
  String nombre;
  String descripcion;
  double precio;
  String categoria;
  String status;

  Platillo(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.categoria,
      required this.status});

  static Platillo fromJSON(Map<String, dynamic> datos) {
    return Platillo(
        id: datos['id'],
        nombre: datos['nombre'],
        descripcion: datos['descripcion'],
        precio: double.parse(datos['precio']),
        categoria: datos['categoria'],
        status: datos['status']);
  }

  static Future<List<Platillo>> leeTodos(String token, String txt) async {
    try {
      final respuesta = await http.Client()
          .get(Uri.http('192.168.1.73:8000', '/api/platillos',
              {'api_token': token, 'txt': txt}))
          .timeout(Duration(seconds: 5));

      print("RESPUESTA " + respuesta.body);
      String json = respuesta.body.toString();
      List<dynamic> respuestaJSON = jsonDecode(json);
      List<Map<String, dynamic>> platillosJSON =
          respuestaJSON.cast<Map<String, dynamic>>();
      List<Platillo> platillos = List.generate(platillosJSON.length, (index) {
        return fromJSON(platillosJSON[index]);
      });

      return platillos;
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return [];
    }
  }

  Future<bool> registra(String token) async {
    try {
      final respuesta = await http.Client()
          .post(Uri.http('192.168.1.73:8000', '/api/platillos', {
            'api_token': token,
            'nombre': this.nombre,
            'descr': this.descripcion,
            'precio': this.precio.toString(),
            'cat': this.categoria
          }))
          .timeout(Duration(seconds: 5));

      print("RESPUESTA " + respuesta.body);

      return respuesta.body == 'OK';
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return false;
    }
  }
}
