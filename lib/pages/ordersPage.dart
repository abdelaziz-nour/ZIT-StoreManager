import 'package:flutter/material.dart';
import 'package:store_manager/pages/orderedItemsPage.dart';

import '../api/apiRequests.dart';

class Orders extends StatelessWidget {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(shrinkWrap: true, children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              'O',
              style: TextStyle(color: Color(0xff4338CA), fontSize: 30),
            ),
            Text(
              'rders',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ],
        ),
      ),
      FutureBuilder<dynamic>(
        future: _databaseHelper.getMyorders(),
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
                          title: Text(snapshot.data[index]['id'].toString()),
                          subtitle: Text(
                              snapshot.data[index]['CreatedBy'].toString()),
                          trailing: Text(
                            snapshot.data[index]['CreatedOn'].substring(0, 10) +
                                '\n' +
                                snapshot.data[index]['CreatedOn']
                                    .substring(11, 16),
                          ),
                        )
                        // Text(
                        //   'Order\t${snapshot.data[index]['id'].toString()}\nDate\t${snapshot.data[index]['CreatedOn'].toString()}\nBy:\t${snapshot.data[index]['CreatedBy'].toString()}',
                        //   style: TextStyle(color: Color(0xff4338CA)),
                        // ),
                        );
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

class CasesClass extends StatelessWidget {
  var list;
  CasesClass(this.list);
  @override
  Widget build(BuildContext context) {
    Map map = list.asMap();

    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: list == null ? 0 : 1,
            itemBuilder: (context, index) {
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'No',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Donor',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Student ID',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Amount',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Date And Time',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ],
                      rows: map.entries
                          .map(
                            (entry) => DataRow(
                              cells: [
                                DataCell(Text((entry.key).toString())),
                                DataCell(Text(entry.value['donor'])),
                                DataCell(
                                    Text((entry.value['student']).toString())),
                                DataCell(Text((entry.value['donation_amount'])
                                    .toString())),
                                DataCell(Text(
                                    '${entry.value['date'].substring(0, 10)}' +
                                        '  ${entry.value['date'].substring(11, 16)}')),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            }),
        Center(
          child: Text(
            'Total Donations are : ${list.length}',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.pink,
            ),
          ),
        )
      ],
    );
  }
}
