import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/startPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: GoogleFonts.amiri(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                .fontFamily),
        home: StartPage());
  }
}
