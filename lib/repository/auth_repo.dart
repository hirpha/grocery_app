import 'dart:convert';

import 'package:grocery_app/utils/Session.dart';
import 'package:grocery_app/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth.dart';

class AuthRepository {
  final http.Client httpClient;
  AuthRepository({required this.httpClient});
  Future<void> loginUser(Auth auth) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final url = Uri.parse(EndPoints.login());
      Session().logSession("url", url.toString());
      final res = await httpClient.post(url,
          headers: <String, String>{'Content-Type': 'application/json'},
          body: json.encode(auth.toMap()));
      Session().logSession("login success", res.body);
      Session().logSession("statuscode", res.statusCode.toString());
      if (res.statusCode == 200) {
        final decode = json.decode(res.body);
        final token = decode["data"]['token'];
        prefs.setString("token", token);
        Session().logSession("token", token);
        return;
      } else {
        throw "Incorrect Phone or Password";
      }
    } catch (e) {
      Session().logError("error", e.toString());
      rethrow;
    }
  }
}
