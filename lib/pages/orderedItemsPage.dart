import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrderedItems extends StatelessWidget {
  const OrderedItems({required this.orderedItems});
  final orderedItems;

  @override
  Widget build(BuildContext context) {
    int? total = 0;
    for (var item in orderedItems) {
      total = (total! + int.parse(item['Price']) * item['Quantity']) as int?;
    }
    Map map = orderedItems.asMap();
    print(orderedItems);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            'Store Name',
            style: TextStyle(color: Color(0xff4338CA)),
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: orderedItems == null ? 0 : 1,
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
                                  color: Color(0xff4338CA)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Product',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff4338CA)),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Quantity',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Color(0xff4338CA),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'price',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xff4338CA)),
                            ),
                          ),
                        ],
                        rows: map.entries
                            .map(
                              (entry) => DataRow(
                                cells: [
                                  DataCell(Text((entry.key + 1).toString())),
                                  DataCell(Text(entry.value['ProductName'])),
                                  DataCell(Text(
                                      (entry.value['Quantity']).toString())),
                                  DataCell(
                                      Text((entry.value['Price']).toString())),
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
              'Total items are : ${orderedItems.length}\nOrder price : $total SDG',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Color(0xff4338CA),
              ),
            ),
          )
        ],
      )),
    );
  }
}
