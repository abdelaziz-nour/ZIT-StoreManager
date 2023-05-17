import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/globals.dart';

class OrderedItems extends StatefulWidget {
  const OrderedItems({
    required this.orderedItems,
    required this.lang,
    required this.location,
    required this.status,
    required this.id,
    required this.storeID,
    required this.storeName,
  });
  final int lang;
  final orderedItems;
  final location;
  final status;
  final id;
  final int storeID;
  final String storeName;

  @override
  State<OrderedItems> createState() => _OrderedItemsState(
      lang: lang,
      id: id,
      location: location,
      storeID: storeID,
      storeName: storeName,
      orderedItems: orderedItems,
      status: status);
}

class _OrderedItemsState extends State<OrderedItems> {
  _OrderedItemsState(
      {required this.lang,
      required this.orderedItems,
      required this.location,
      required this.status,
      required this.storeID,
      required this.storeName,
      required this.id});
  final int lang;
  final orderedItems;
  final location;
  late final status;
  final id;
  final int storeID;
  final String storeName;

  late String _selectedOption;
  @override
  void initState() {
    super.initState();
    _selectedOption = status;
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    Global global = Global();
    int? total = 0;
    for (var item in widget.orderedItems) {
      total = (total! + item['Subtotal']) as int?;
    }
    Map map = widget.orderedItems.asMap();
    //print(widget.orderedItems);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: global.accent,
          elevation: 0,
          leading: BackButton(
            color: global.black,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            storeName,
            style: TextStyle(color: global.primary),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.lang == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(color: global.black, fontSize: 20),
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
                        style: TextStyle(color: global.black, fontSize: 20),
                      ),
                    ],
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButton<String>(
                    dropdownColor: global.primary,
                    // style: TextStyle(color: Colors.white),
                    underline: SizedBox(),
                    value: _selectedOption,
                    borderRadius: BorderRadius.circular(20),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                    items: status == 'Preparing'
                        ? <String>[
                            'Preparing',
                            'OnDelivery',
                            'Delivered',
                            'Canceled'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        : <String>['OnDelivery', 'Delivered', 'Canceled']
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    child: Text(widget.lang == 1 ? 'Save' : 'حفظ',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    onPressed: () async {
                      await databaseHelper.changeOrderStatus(
                          orderID: id.toString(), status: _selectedOption);
                    },
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.location,
              style: TextStyle(fontSize: 20),
              textDirection: TextDirection.rtl,
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
                          widget.lang == 1 ? 'No' : "رقم",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          widget.lang == 1 ? 'Product' : "المنتج",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          widget.lang == 1 ? 'Quantity' : "الكمية",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: global.primary,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          widget.lang == 1 ? 'Price' : "السعر",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: global.primary),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          widget.lang == 1 ? 'Subtotal' : "المجموع",
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
