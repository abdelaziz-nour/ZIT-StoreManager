import 'package:flutter/material.dart';
import 'package:store_manager/pages/loginPage.dart';

import '../myWidgets/customButton.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final primaryColor = Color(0xff4338CA);
    final secondaryColor = Color(0xff6D28D9);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/zit.jpg'), fit: BoxFit.fill)),
            ),
            Text(
              'Zoal IT',
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight / 15,
                fontFamily: 'Pacifico',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: screenHeight / 15,
                    width: screenWidth / 2.5,
                    child: ButtonImage(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      text: 'عربي',
                    )),
                SizedBox(
                    height: screenHeight / 15,
                    width: screenWidth / 2.5,
                    child: ButtonImage(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                      text: 'English',
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
