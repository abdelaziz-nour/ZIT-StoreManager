import 'package:flutter/material.dart';
import 'package:store_manager/globals.dart';

class OrderedItems extends StatelessWidget {
  const OrderedItems({required this.orderedItems, required this.lang});
  final int lang;
  final orderedItems;

  @override
  Widget build(BuildContext context) {
    Global global = Global();
    int? total = 0;
    for (var item in orderedItems) {
      total = (total! + item['Subtotal']) as int?;
    }
    Map map = orderedItems.asMap();
    print(orderedItems);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: global.accent,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            'Store Name',
            style: TextStyle(color: global.primary),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: lang == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      Text(
                        '$total SDG',
                        style: TextStyle(color: global.primary, fontSize: 20),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$total SDG',
                        style: TextStyle(color: global.primary, fontSize: 20),
                      ),
                      Text(
                        'المبلغ',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
          ),
          Column(
            children: [
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          lang == 1 ? 'No' : "رقم",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          lang == 1 ? 'Product' : "المنتج",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          lang == 1 ? 'Quantity' : "الكمية",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: global.primary,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          lang == 1 ? 'Price' : "السعر",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          lang == 1 ? 'Subtotal' : "المجموع",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                    ],
                    rows: map.entries
                        .map(
                          (entry) => DataRow(
                            cells: [
                              DataCell(Text(
                                (entry.key + 1).toString(),
                              )),
                              DataCell(Text(entry.value['ProductName'])),
                              DataCell(Center(
                                  child: Text(
                                      (entry.value['Quantity']).toString()))),
                              DataCell(Text((entry.value['Price']).toString())),
                              DataCell(
                                  Text((entry.value['Subtotal']).toString())),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
