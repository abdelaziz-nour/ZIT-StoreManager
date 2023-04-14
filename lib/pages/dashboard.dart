import 'package:flutter/material.dart';
import 'package:store_manager/pages/categoriesPage.dart';
import 'package:store_manager/pages/loginPage.dart';
import 'ordersPage.dart';
import 'package:store_manager/globals.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required this.lang});
  final int lang;

  @override
  State<Dashboard> createState() => _DashboardState(lang: lang);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState({required this.lang});
  final int lang;
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
      Categories(lang: lang),
      Orders(lang: lang),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: global.accent,
        elevation: 0,
        title: Text('Store Name', style: TextStyle(color: global.primary)),
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
