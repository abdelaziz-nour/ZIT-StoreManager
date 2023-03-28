import 'package:flutter/material.dart';
import '../myAnimations/fadeAnimation.dart';

LoginForm(
    {required context,
    required formKey,
    required usernameController,
    required passwordController}) {
  return Padding(
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
                      boxShadow: [
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
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[400])),
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
                  onTap: () {
                    print('hi');
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(0, 10, 203, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ));
}
