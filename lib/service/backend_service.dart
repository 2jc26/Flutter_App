import 'package:http/http.dart' as http;
import 'dart:convert';

class BackendService {

  final baseUrl = 'http://34.123.214.132:8000/senehouse';

  static final BackendService _instance = BackendService._internal();

  factory BackendService() {
    return _instance;
  }

  BackendService._internal();

  Future<List<dynamic>> getAll(String endPoint) async {
    final response = await http.get(Uri.parse('$baseUrl/houses'));
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      return json.decode(response.body);
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }

  Future<dynamic> getOne(String endPoint, String id) async {
    final response = await http.get(Uri.parse('$baseUrl/houses/$id'));
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      return json.decode(response.body);
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      return null;
    }
  }

  Future<void> post(String endPoint, object) async {
    final response = await http.post(Uri.parse(
      '$baseUrl/houses'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(object.toJson()),
    );
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
    }
  }

}