import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // GANTI sesuai IP Laravel kamu
  static const String baseUrl = "http://127.0.0.1:8000/api";

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Accept": "application/json"},
      body: {"email": email, "password": password},
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Accept": "application/json"},
      body: {"name": name, "email": email, "password": password},
    );

    return jsonDecode(response.body);
  }
}
