import 'package:flutter/material.dart';
import 'package:store_manager/pages/orderedItemsPage.dart';
import 'package:store_manager/globals.dart';

class Orders extends StatelessWidget {
  Orders({required this.lang,required this.storeID,required this.storeName});
  final int lang;
  final String storeID;
  final String storeName;
  @override
  Widget build(BuildContext context) {
    Global global = Global();
    return Scaffold(
        backgroundColor: global.accent,
        body: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: lang == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'O',
                        style: TextStyle(color: global.primary, fontSize: 30),
                      ),
                      Text(
                        'rders',
                        style: TextStyle(color: global.black, fontSize: 30),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'لبات',
                        style: TextStyle(color: global.black, fontSize: 30),
                      ),
                      Text(
                        'الطـ',
                        style: TextStyle(color: global.primary, fontSize: 30),
                      ),
                    ],
                  ),
          ),
          StreamBuilder<dynamic>(
            stream: global.databaseHelper.getMyOrders(storeID: storeID.toString()).asStream(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length - 1,
                      itemBuilder: (context, index) {
                        //print(snapshot.data);
                        return Card(
                            elevation: 4,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OrderedItems(
                                      lang: lang,
                                      storeID: storeID,
                                      storeName: storeName,
                                      id: snapshot.data[index]['id'],
                                      location: snapshot.data[index]
                                          ['Location'],
                                      status: snapshot.data[index]['Status'],
                                      orderedItems: snapshot.data[index]
                                          ['OrderItems']);
                                }));
                              },
                              title: Text(
                                  '${snapshot.data[index]['id'].toString()}\n${snapshot.data[index]['Status'].toString()}'),
                              subtitle: Text(
                                snapshot.data[index]['CreatedBy'].toString(),
                                style: TextStyle(color: global.primary),
                              ),
                              trailing: Text(
                                snapshot.data[index]['CreatedOn']
                                        .substring(0, 10) +
                                    '\n' +
                                    snapshot.data[index]['CreatedOn']
                                        .substring(11, 16),
                              ),
                            ));
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ]));
  }
}
