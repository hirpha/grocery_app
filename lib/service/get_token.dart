import 'package:shared_preferences/shared_preferences.dart';

Future<String> getAuthToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("token")!;
}
