import 'package:flutter/material.dart';
import 'package:store_manager/pages/orderedItemsPage.dart';
import 'package:store_manager/globals.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Global global = Global();
    return Scaffold(
        backgroundColor: global.accent,
        body: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'O',
                  style: TextStyle(color: global.primary, fontSize: 30),
                ),
                Text(
                  'rders',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ],
            ),
          ),
          FutureBuilder<dynamic>(
            future: global.databaseHelper.getMyorders(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length - 1,
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 4,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return OrderedItems(
                                      orderedItems: snapshot.data[index]
                                          ['OrderItems']);
                                }));
                              },
                              title:
                                  Text(snapshot.data[index]['id'].toString()),
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
