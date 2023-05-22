import 'package:flutter/material.dart';
import 'package:store_manager/pages/loginPage.dart';
import 'package:store_manager/globals.dart';
import '../myWidgets/customButton.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Global global = Global();
    return SafeArea(
      child: Scaffold(
        backgroundColor: global.accent,
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/zit.jpg'), fit: BoxFit.fill)),
              ),
            ),
            Text(
              'Zoal IT',
              style: TextStyle(
                color: global.primary,
                fontSize: global.screenwheight(context) / 15,
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
                    height: global.screenwheight(context) / 15,
                    width: global.screenwidth(context) / 2.5,
                    child: ButtonImage(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage(
                            lang: 0,
                          );
                        }));
                      },
                      text: 'عربي',
                    )),
                SizedBox(
                    height: global.screenwheight(context) / 15,
                    width: global.screenwidth(context) / 2.5,
                    child: ButtonImage(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage(
                            lang: 1,
                          );
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
