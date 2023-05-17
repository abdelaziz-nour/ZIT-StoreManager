import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/pages/dashboard.dart';

class LoginMessage {

  void showMyDialog(
      {required context,
      required lang,
      var page}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              
              title: new Text( lang == 1 ?"Failed":'فشل',textDirection: lang == 1 ?TextDirection.ltr:TextDirection.rtl,),
              content: new Text( lang == 1 ?'No Store Manager Account Match Giving Credentials':"لا يوجد حساب لمدير متجر بهذه البيانات"),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 35, 55)),
                    child: new Text(
                      lang == 1 ?'OK':"حسناً",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),

              ]);
        });
  }
}
