import 'package:flutter/material.dart';
import 'package:store_manager/pages/orderedItemsPage.dart';
import 'package:store_manager/globals.dart';
import '../myWidgets/searchBar.dart';

class Orders extends StatefulWidget {
  Orders({
    Key? key,
    required this.lang,
    required this.storeID,
    required this.storeName,
  }) : super(key: key);

  final int lang;
  final String storeID;
  final String storeName;

  @override
  State<Orders> createState() => _OrdersState(lang: lang,storeID: storeID,storeName: storeName);
}

class _OrdersState extends State<Orders> {
  _OrdersState({required this.lang,
    required this.storeID,
    required this.storeName,});
    final int lang;
  final String storeID;
  final String storeName;
  Global global = Global();
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  bool firstRender = true;

  void _filterData(String query) {
    setState(() {
      firstRender = false;
      _filteredData = _data
          .where((item) =>
              item['id'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data =
        await global.databaseHelper.getMyOrders(storeID: widget.storeID);
    setState(() {
      _data = data ; // Handle null case
      _filteredData = data ; // Handle null case
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: global.accent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: widget.lang == 1
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
            SearchInputFb1(
              hintText: widget.lang == 1 ? 'Search ...' : "البحث...",
              onchange: (value) => _filterData(value),
            ),
            if (_filteredData.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredData.length - 1 == 0
                    ? _filteredData.length
                    : _filteredData.length - 1,
                itemBuilder: (context, index) {
                  if (_filteredData[index].containsKey('id')) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OrderedItems(
                                lang: lang,
                                storeID: storeID,
                                storeName: storeName,
                                id: _filteredData[index]['id'],
                                location: _filteredData[index]['Location'],
                                status: _filteredData[index]['Status'],
                                orderedItems: _filteredData[index]
                                    ['OrderItems']);
                          }));
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _filteredData[index]['id'],
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              _filteredData[index]['Status'],
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    _filteredData[index]['Status'] == 'Canceled'
                                        ? Colors.red
                                        : _filteredData[index]['Status'] ==
                                                'OnDelivery'
                                            ? Colors.orange
                                            : _filteredData[index]['Status'] ==
                                                    'Preparing'
                                                ? Colors.black
                                                : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          _filteredData[index]['CreatedBy'].toString(),
                          style: TextStyle(color: global.primary, fontSize: 18),
                        ),
                        trailing: Text(
                          _filteredData[index]['CreatedOn']?.substring(0, 10),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    );
                  } else {
                    Center(
                      child: Text(
                        'No orders found.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                },
              )
            else if (!firstRender)
              Center(
                child: Text(
                  'No orders found.',
                  style: TextStyle(fontSize: 18),
                ),
              )
            else
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
