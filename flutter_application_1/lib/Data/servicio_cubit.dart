import 'dart:convert';
import 'package:http/http.dart' as http;

class APIServicio {
  final String baseUrl = 'https://api.example.com';

  Future<List<dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
