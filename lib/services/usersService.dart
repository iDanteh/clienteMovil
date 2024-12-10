import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:servicios_apis/utils/url.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService {
  static Future<bool> login(String email, String password) async {
    final url = '${Constants.baseUrl}/login';
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final token = responseData['accessToken'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        return true;
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> register(String name, String email, String password) async {
    final url = '${Constants.baseUrl}/register';
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'role': 'user',
    });

    try {
        final response = await http.post(
            Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: body,
        );

        if (response.statusCode == 201) {
    try {
        final responseData = json.decode(response.body);
        final token = responseData['accessToken']; // Asegúrate de que este campo exista
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        return true; // Registro exitoso
    } catch (e) {
        print('Error al decodificar la respuesta: $e');
        return false;
    }
} else {
    print('Error en registro: ${response.body}');
    return false; // Registro fallido
}
    } catch (e) {
        print('Error de conexión: $e');
        return false; // Error de conexión
    }
  }

  // Método para obtener los datos del usuario
  static Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authToken');
  if (token == null) return null;

  try {
    final decodedToken = Jwt.parseJwt(token);
    // Convertir el id a String antes de retornarlo
    return decodedToken['id'].toString(); 
  } catch (e) {
    print('Error al decodificar el token: $e');
    return null;
  }
}

static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) return null;

    final url = '${Constants.baseUrl}/users/me'; // Asegúrate de usar la URL correcta

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Usamos el token para autenticar la solicitud
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData; // Devuelve los datos del usuario
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Método para actualizar la información del usuario usando el id
  static Future<bool> updateUser(String name, String email, String password) async {
    final userId = await getUserId();
    if (userId == null) return false; // No se pudo obtener el id del usuario

    final url = '${Constants.baseUrl}/users/$userId'; // Usamos el id en la URL de la API
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    if (token == null) return false;

    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return true; // Actualización exitosa
      } else {
        print('Error: ${response.body}');
        return false; // Error en la actualización
      }
    } catch (e) {
      print(e);
      return false; // Error de conexión
    }
  }
}