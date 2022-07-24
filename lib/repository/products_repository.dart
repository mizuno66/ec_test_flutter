import 'dart:convert';
import 'package:ec_test/models/products.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductRepository{
  Future<List<Product>> fetch() async {
    debugPrint("call ProductRepository fetch()");
    try {
      final response = await http.get(Uri.http('localhost:3000', 'product'));
      await Future.delayed(
        const Duration(seconds: 3),
      );
      List<dynamic> jsonArray = jsonDecode(response.body);
      List<Product> list = jsonArray.map((i) => Product.fromJson(i)).toList();
      return Future<List<Product>>.value(list);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
