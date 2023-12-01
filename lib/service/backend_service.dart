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
    final response = await http.get(Uri.parse('$baseUrl/$endPoint'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Request failed
      return [];
    }
  }

  Future<dynamic> getOne(String endPoint, String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$endPoint/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Request failed
      return null;
    }
  }

  Future<List<dynamic>> postAll(String endPoint, object) async {
    var waos =object.toJson();
    final response = await http.post(Uri.parse(
      '$baseUrl/$endPoint'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(object.toJson()),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Request failed
      return [];
    }
  }

  Future<List<dynamic>> putAll(String endPoint, object) async {
    final response = await http.put(Uri.parse(
      '$baseUrl/$endPoint'),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(object.toJson()),
    );
    if (response.statusCode == 200) {
      if (response.body != "null") {
        return json.decode(response.body);
      } else {
        return [];
      }
    } else {
      // Request failed
      return [];
    }
  }

  Future<List<dynamic>> getOneAll (String endPoint, String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$endPoint/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Request failed
      return [];
    }
  }

  Future<dynamic> put(String endPoint, Map<String, dynamic> object, String id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endPoint/$id'),
      headers: {
        "Content-Type": "application/json",
      },
      body: object != null ? json.encode(object) : null,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      // Request failed
      return null;
    }
  }

  Future<void> putVisit(String id) async {
    final response = await http.put(
      Uri.parse("houses/$id/views"),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }

  Future<dynamic> post(String endPoint, dynamic object) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endPoint'),
      headers: {
        "Content-Type": "application/json",
      },
      body: object != null ? json.encode(object) : null,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Request failed
      return null;
    }
  }


}