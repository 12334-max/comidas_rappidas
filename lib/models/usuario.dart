import 'package:http/http.dart' as http;

class Usuario {
  String api_key;
  String email;
  String password;

  Usuario(this.api_key, this.email, this.password);

  static Future<String> valida(String e, String c) async {
    try {
      final respuesta = await http.Client()
          .get(Uri.http('localhost', '/comidas/public/api/login',
              {'email': e, 'pass': c}))
          .timeout(const Duration(seconds: 5));

      print("RESPUESTA ${respuesta.body}");
      return respuesta.body.toString();
    } on Exception catch (e) {
      print('ERROR: $e');
      return "Error de conexión";
    }
  }
}
