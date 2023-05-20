import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/pages/dashboard.dart';

class Messages {
  Messages({required this.categoryID, required this.lang,required this.storeID,required this.storeName});
  final categoryID;
  final int lang;
  final String storeID;
  final String storeName;
  DatabaseHelper _databaseHelper = DatabaseHelper();
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
                      lang == 1 ?'No':"لا",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: new Text(
                      lang == 1 ?'Yes':"نعم",
                    ),
                    onPressed: () async {
                      await _databaseHelper.deleteCategory(
                          categoryID: categoryID.toString());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content) {
                        return Dashboard(
                          lang: 0,
                          storeID: storeID,
                          storeName: storeName,
                        );
                      }));
                    }),
              ]);
        });
  }
}
