import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';

class Global {
  Color primary = Color.fromARGB(255, 76, 154, 203);
  Color secondary = Color.fromARGB(255, 50, 83, 114);
  Color accent = Color.fromARGB(100, 228, 227, 232);
  DatabaseHelper databaseHelper = DatabaseHelper();
  String searchText = "";
  screenwidth(context) {
    return MediaQuery.of(context).size.width;
  }

  screenwheight(context) {
    return MediaQuery.of(context).size.height;
  }
}
