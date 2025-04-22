import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://cicloverso.duckdns.org/api';

  static Future<List<dynamic>> getServizi() async {
    final response = await http.get(Uri.parse('$baseUrl/servizi'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Errore nel recupero dei servizi');
    }
  }

  static Future<List<dynamic>> getSlots({
    required String start,
    required String end,
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl/slot?start=$start&end=$end'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Errore nel recupero degli slot');
    }
  }
}
