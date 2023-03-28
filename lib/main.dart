import 'package:flutter/material.dart';
import 'package:store_manager/pages/dashboard.dart';
import 'package:store_manager/pages/loginPage.dart';
import 'package:store_manager/pages/productsListPage.dart';

import 'pages/startPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ItemsList());
  }
}
