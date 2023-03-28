import 'package:flutter/material.dart';
import '../myWidgets/loginForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final loginformKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final usernameController = TextEditingController();
    TabController _controller = TabController(length: 2, vsync: this);
    final addLoginformKey = GlobalKey<FormState>();
    final addPasswordController = TextEditingController();
    final addUsernameController = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
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
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: TabBar(
                  controller: _controller,
                  tabs: const [
                    Tab(
                      icon: Icon(
                        Icons.storefront_sharp,
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Store',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.insert_chart_outlined,
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Addvertiser',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    LoginForm(
                        formKey: loginformKey,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        context: context),
                    LoginForm(
                        formKey: addLoginformKey,
                        usernameController: addUsernameController,
                        passwordController: addPasswordController,
                        context: context),
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
