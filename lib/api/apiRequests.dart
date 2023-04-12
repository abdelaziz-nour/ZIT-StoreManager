import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  var success;
  var token;

  void printStreamedResponse(http.StreamedResponse response) {
    final buffer = StringBuffer(); // Buffer to accumulate the response body

    response.stream.listen(
      (data) {
        buffer.write(
            utf8.decode(data)); // Convert bytes to string and append to buffer
      },
      onDone: () {
        print(buffer.toString()); // Print the accumulated response body
      },
      onError: (error) {
        print(
            'Error: $error'); // Handle any errors that occur while reading the stream
      },
      cancelOnError: true, // Cancel the stream on error
    );
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  loginData(String username, String password) async {
    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com//login');
    final response = await http
        .post(myUrl, body: {"username": username, "password": password});
    var data = json.decode(response.body);
    success = data['success'];
    print('success = $success');
    if (success) {
      _save(data['data']['token']);
      print(data['data']['token']);
    } else {
      print(data['message']);
    }
  }

  getMyCategories() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com/getstorecategories');
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'}, body: {"Store": "1"});
    var data = json.decode(response.body);
    print(data['data']);
    return data['data'];
  }

  addCategory({required String categoryName, required image}) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    // send the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://vzzoz.pythonanywhere.com/addcategory"),
    );

    request.headers["Authorization"] = "token $value";
    request.fields["Name"] = categoryName;
    request.files.add(image);
    print(image.toString());
    var response = await request.send();
    printStreamedResponse(response);
  }

  Future<List> getMyProducts({required int categoryID}) async {
    print(categoryID);
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    Uri myUrl =
        Uri.parse('http://vzzoz.pythonanywhere.com/getcategoryproducts');

    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Category": categoryID.toString()});
    print(response.statusCode);
    var data = json.decode(response.body);
    print(data);
    return data['data'];
  }

  addProduct(
      {required String name,
      required String decription,
      required int price,
      required int quantity,
      required int categoryID,
      required image}) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    // send the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://vzzoz.pythonanywhere.com/addproduct"),
    );

    request.headers["Authorization"] = "token $value";
    request.fields["Name"] = name;
    request.fields["Decription"] = decription;
    request.fields["Price"] = price.toString();
    request.fields["Quantity"] = quantity.toString();
    request.fields["Category"] = categoryID.toString();
    request.files.add(image);
    print(image.toString());
    var response = await request.send();
    printStreamedResponse(response);
  }

  deleteCategory({required String categoryID}) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/deletecategory");

    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Category": categoryID});
    print(response.statusCode);
    print(response.body);
  }

  deleteProduct({required String productID}) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/deleteproduct");
    print('productID : $productID');
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Product": productID});
    print(response.statusCode);
    print(response.body);
  }

  addProductQuantity(
      {required String productID, required String quantity}) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    Uri myUrl = Uri.parse("http://vzzoz.pythonanywhere.com/addproductquantity");
    print('productID : $productID');
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'},
        body: {"Product": productID, "Quantity": quantity});
    print(response.statusCode);
    print(response.body);
  }

  getMyorders() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;

    Uri myUrl = Uri.parse('http://vzzoz.pythonanywhere.com/getstoreorders');
    var response = await http.post(myUrl,
        headers: {'Authorization': 'token $value'}, body: {"Store": "1"});
    var data = json.decode(response.body);
    print(data['data']);
    return data['data'];
  }




}
