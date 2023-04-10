import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  var status;
  var token;

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

//1 login
  loginData(String username, String password) async {
    Uri myUrl = Uri.parse('http://127.0.0.1:8000/login');
    final response =
        await http.post(myUrl, body: {"username": "aziz2", "password": "1234"});
    status = response.body.contains('Incorrect username or password');
    var data = json.decode(response.body);
    print(data);

  }
}
