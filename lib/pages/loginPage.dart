import 'package:flutter/material.dart';
import '../myWidgets/loginForm.dart';
import 'package:store_manager/globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _controller = TabController(length: 2, vsync: this);
    Global global = Global();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 228, 227, 232),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: global.screenwheight(context) / 2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/zit.jpg'), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[],
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TabBar(
                    controller: _controller,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.storefront_sharp,
                          color: global.primary,
                        ),
                        child: Text(
                          'Store',
                          style: TextStyle(color: global.primary),
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.insert_chart_outlined,
                          color: global.primary,
                        ),
                        child: Text(
                          'Addvertiser',
                          style: TextStyle(color: global.primary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: global.screenwheight(context),
                    child: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        LoginForm(),
                        Text(
                          'Comming Soon',
                          style: TextStyle(
                              color: global.primary,
                              fontSize: global.screenwheight(context) / 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
