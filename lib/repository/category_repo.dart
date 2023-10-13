import 'dart:convert';

import 'package:grocery_app/models/category.dart';
import 'package:grocery_app/service/get_token.dart';
import 'package:grocery_app/utils/Session.dart';
import 'package:grocery_app/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

class CategoryRepository {
  final http.Client httpClient;
  CategoryRepository({required this.httpClient});
  Future<List<Category>> categoryLoad() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = await getAuthToken();
      final url = Uri.parse(EndPoints.categories());
      Session().logSession("url", url.toString());
      final res = await httpClient.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      Session().logSession("category success success", res.body);
      Session().logSession("statuscode", res.statusCode.toString());
      if (res.statusCode == 200) {
        final decode = json.decode(res.body);

        return (decode['data'] as List).map((category)=>Category.fromJson(category)).toList();
      } else {
        throw "Incorrect Phone or Password";
      }
    } catch (e) {
      Session().logError("error", e.toString());
      rethrow;
    }
  }
}
