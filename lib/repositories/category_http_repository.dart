import 'dart:convert';

import 'package:documentation/model/category/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CategoryHttpRepository {
  Future<Set<Category>> fetchCategories() async {
    final response = await http.get(
      Uri.parse("${dotenv.env['host']}/categories"),
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
    );

    return (jsonDecode(response.body) as List<dynamic>)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toSet();
  }
}
