import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:store_manager/pages/productsListPage.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.categoryName,
    required this.image,
    required this.dategoryId,
    required this.lang,
  }) : super(key: key);
  final int lang;
  final String categoryName;
  final String image;
  final int dategoryId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ItemsList(
            lang: lang,
            categoryID: dategoryId,
          );
        }));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                colors: [Color(0xff53E88B), Color(0xff15BE77)])),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'http://vzzoz.pythonanywhere.com$image',
                  height: 10000,
                  width: 10000,
                  fit: BoxFit.fill,
                )),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Center(
                      child: Text(
                        categoryName,
                        style: TextStyle(
                            color: Colors.white,
                            shadows: const <Shadow>[
                              Shadow(
                                offset: Offset(5.0, 5.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
