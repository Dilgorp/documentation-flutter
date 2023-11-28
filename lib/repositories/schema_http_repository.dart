import 'dart:convert';

import 'package:documentation/model/schema/schema.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SchemaHttpRepository {
  Future<Schema> fetchSchema() async {
    final response = await http.get(
      Uri.parse("${dotenv.env['host']}/schemas/1"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    return Schema.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
