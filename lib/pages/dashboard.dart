import 'package:flutter/material.dart';
import 'package:store_manager/pages/categoriesPage.dart';
import 'package:store_manager/pages/loginPage.dart';
import 'ordersPage.dart';
import 'package:store_manager/globals.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(
      {super.key,
      required this.lang,
      required this.storeID,
      required this.storeName});
  final int lang;
  final String storeID;
  final String storeName;

  @override
  State<Dashboard> createState() =>
      _DashboardState(lang: lang, storeID: storeID, storeName: storeName);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState(
      {required this.lang, required this.storeID, required this.storeName});
  final int lang;
  final String storeID;
  final String storeName;
  Global global = Global();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      Categories(
        lang: lang,
        storeID: storeID,
        storeName: storeName,
      ),
      Orders(lang: lang, storeID: storeID, storeName: storeName),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: global.accent,
        elevation: 0,
        title: Text(storeName, style: TextStyle(color: global.primary)),
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          lang: lang,
                        )),
                (route) => false, // Disable ability to go back
              );
            },
            icon: Icon(
              Icons.logout_sharp,
              color: global.primary,
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            color: global.primary,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Dashboard(
                          lang: lang,
                          storeID: storeID,
                          storeName: storeName,
                        )),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: lang == 1 ? 'Categories' : "الفئات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: lang == 1 ? 'Follow-ups' : "المتابعة",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 76, 154, 203),
        onTap: _onItemTapped,
      ),
    );
  }
}
