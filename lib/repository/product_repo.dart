import 'dart:convert';

import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/service/get_token.dart';
import 'package:grocery_app/utils/Session.dart';
import 'package:grocery_app/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

class ProductRepository {
  final http.Client httpClient;
  ProductRepository({required this.httpClient});
  Future<List<Product>> getProducts() async {
    try {
      final token = await getAuthToken();
      final url = Uri.parse(EndPoints.products());
      Session().logSession("url", url.toString());
      final res = await httpClient.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      Session().logSession("Product success success", res.body);
      Session().logSession("statuscode", res.statusCode.toString());
      if (res.statusCode == 200) {
        final decode = json.decode(res.body);

        return (decode['data'] as List)
            .map((product) => Product.fromJson(product))
            .toList();
      } else {
        throw "Incorrect Phone or Password";
      }
    } catch (e) {
      Session().logError("error", e.toString());
      rethrow;
    }
  }

  Future<Product> getSingleProduct(String id) async {
    try {
      final token = await getAuthToken();
      final url = Uri.parse(EndPoints.productDetail(id));
      Session().logSession("url", url.toString());
      final res = await httpClient.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      Session().logSession("Product success success", res.body);
      Session().logSession("statuscode", res.statusCode.toString());
      if (res.statusCode == 200) {
        final decode = json.decode(res.body);

        return Product.fromJson(decode['data']);
      } else {
        throw "Incorrect Phone or Password";
      }
    } catch (e) {
      Session().logError("error", e.toString());
      rethrow;
    }
  }
}
