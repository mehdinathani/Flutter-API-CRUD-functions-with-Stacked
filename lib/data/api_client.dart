import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseURL =
      "https://crudcrud.com/api/edaed25cb1b84e1ebd6e12c157fe107a";

  Future<List<dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse("$baseURL/$endpoint"),
    );
    if (response.statusCode >= 200 || response.statusCode <= 300) {
      log(response.body);

      return json.decode(response.body);
    } else {
      return throw Exception("API error");
    }
  }

  Future<dynamic> post(String endpoint, dynamic data) async {
    log("$baseURL/$endpoint");
    final response = await http.post(
      Uri.parse("$baseURL/$endpoint"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode >= 200 || response.statusCode < 300) {
      log(response.body);
      return json.decode(response.body);
    } else {
      throw Exception("API error - ${response.statusCode}: ${response.body}");
    }
  }

  Future<dynamic> put(String endpoint, dynamic data, String id) async {
    log("$baseURL/$endpoint/$id");
    final response = await http.post(
      Uri.parse("$baseURL/$endpoint"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode >= 200 || response.statusCode < 300) {
      log(response.body);
      return json.decode(response.body);
    } else {
      throw Exception("API error - ${response.statusCode}: ${response.body}");
    }
  }

  // Future<Map<String, dynamic>> put(
  //     String endpoint, String id, dynamic data) async {
  //   log("$baseURL/$endpoint/$id");
  //   final response = await http.put(
  //     Uri.parse("$baseURL/$endpoint/$id"),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode(data),
  //   );
  //   if (response.statusCode >= 200 || response.statusCode < 300) {
  //     log(response.body);
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception("API error - ${response.statusCode}: ${response.body}");
  //   }
  // }

  Future<void> delete(String endpoint, String id) async {
    final response = await http.delete(
      Uri.parse("$baseURL/$endpoint/$id"),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      log("Deleted successfully");
    } else {
      throw Exception("API error");
    }
  }
}
