import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';

class Global {
  //69,109,179
  Color primary = Color.fromARGB(255, 69, 109, 179);
  //225,71,98
  Color secondary = Color.fromARGB(255, 255, 71, 98);
  //229,227,241
  Color accent = Color.fromARGB(255, 229, 227, 241);
  Color black = Color.fromRGBO(0, 0, 0, 1);
  DatabaseHelper databaseHelper = DatabaseHelper();
  String searchText = "";
  screenwidth(context) {
    return MediaQuery.of(context).size.width;
  }

  screenwheight(context) {
    return MediaQuery.of(context).size.height;
  }
}
