import 'package:flutter/material.dart';
import 'package:store_manager/pages/dashboard.dart';

class Messages {
  void showMyDialog(
      {required context,
      required String title,
      required String content,
      var page}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 11, 35, 55)),
                    child: new Text(
                      'No',
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: new Text(
                      'Yes',
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content) {
                        return Dashboard();
                      }));
                    }),
              ]);
        });
  }
}
