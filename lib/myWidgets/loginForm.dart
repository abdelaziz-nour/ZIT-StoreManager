import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/loginMessage.dart';
import 'package:store_manager/pages/dashboard.dart';
import '../myAnimations/fadeAnimation.dart';
import 'package:store_manager/globals.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.lang});
  final int lang;

  @override
  State<LoginForm> createState() => _LoginFormState(lang: lang);
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState({required this.lang});
  final int lang;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  Global global = Global();
  LoginMessage loginMessage = LoginMessage();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                FadeAnimation(
                    1.8,
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                  hintTextDirection: lang == 1
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  border: InputBorder.none,
                                  hintText:
                                      lang == 1 ? "Username" : 'اسم المستخدم',
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == 1
                                      ? 'username field is required'
                                      : "حقل اسم المستخدم مطلوب";
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintTextDirection: lang == 1
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  border: InputBorder.none,
                                  hintText:
                                      lang == 1 ? "Password" : "كلمة السر",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == 1
                                      ? 'password field is required'
                                      : "حقل كلمة السر مطلوب";
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                FadeAnimation(
                    2,
                    GestureDetector(
                      onTap: () async {
                        var data;
                        if (formKey.currentState!.validate()) {
                          data = await global.databaseHelper.loginData(
                              username: usernameController.text.trim(),
                              password: passwordController.text);
                        }
                        if (global.databaseHelper.success == true) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Dashboard(
                              lang: lang,
                              storeID: data['StoreID'].toString(),
                              storeName: data['StoreName'],
                            );
                          }));
                        } else {
                          loginMessage.showMyDialog(
                              context: context, lang: lang);
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: const [
                              Color.fromARGB(255, 3, 89, 170),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: Center(
                          child: Text(
                            lang == 1 ? "Login" : "تسجيل الدخول",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
