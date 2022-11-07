import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Cocktails {
  String nombre;
  String instruccion;
  String ingredientes;
  Image url;

  Cocktails(
      {required this.nombre,
      required this.instruccion,
      required this.ingredientes,
      required this.url});

  static Cocktails fromJSON(Map<String, dynamic> datos) {
    return Cocktails(
        nombre: datos["strCategory"],
        instruccion: datos["strInstructions"],
        ingredientes: datos["strIngredient1"],
        url: datos["strDrinkThumb"]);
  }

  static Future<List<Cocktails>> leeTodos() async {
    try {
      var url = Uri.https(
          'www.thecocktaildb.com', '/api/json/v1/1/search.php', {'f': 'a'});
      final respuesta = await http.Client().get(url);

      print("RESPUESTA " + respuesta.body);

      String json = utf8.decode(respuesta.bodyBytes);
      final respuestaJSON = jsonDecode(json);

      List<Cocktails> list = [];

      for (var element in respuestaJSON["drinks"]) {
        list.add(Cocktails(
            nombre: element["strGlass"],
            instruccion: element["strInstructionsES"],
            ingredientes: element["strIngredient2"],
            url: Image.network(element["strDrinkThumb"])));
      }

      // List<Map<String, dynamic>> cocktelesJSON =
      //     respuestaJSON.cast<Map<String, dynamic>>();
      // List<Cocktails> cocktails = List.generate(cocktelesJSON.length, (index) {
      //   return fromJSON(cocktelesJSON[index]);
      // });

      return list;
    } on Exception catch (e) {
      print('ERROR: ' + e.toString());
      return [];
    }
  }
}
