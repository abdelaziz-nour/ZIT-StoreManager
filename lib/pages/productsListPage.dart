import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/messages.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';
import 'package:store_manager/globals.dart';
import '../myWidgets/AddProductForm.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({
    Key? key,
    required this.category,
    required this.categoryName,
    required this.lang,
    required this.storeID,
    required this.storeName,
  }) : super(key: key);

  final int lang;
  final String category;
  final String categoryName;
  final String storeID;
  final String storeName;

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  Global global = Global();
  List<dynamic> _data = [];
  List<dynamic> _filteredData = [];
  bool _isLoading = true;

  void _filterData(String query) {
    setState(() {
      _filteredData = _data
          .where((item) => item['Name'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await global.databaseHelper.getMyProducts(categoryID: widget.category);
    setState(() {
      _data = data;
      _filteredData = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Messages _messages = Messages(
      categoryID: widget.category,
      lang: widget.lang,
      storeID: widget.storeID,
      storeName: widget.storeName,
    );
    return Scaffold(
      backgroundColor: global.accent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: global.accent,
        elevation: 0,
        leading: BackButton(
          color: global.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName,
          style: TextStyle(color: global.primary),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            color: global.primary,
            onPressed: fetchData,
          ),
          IconButton(
            onPressed: () {
              _messages.showMyDialog(
                context: context,
                title: widget.lang == 1 ? 'Deletion' : "حذف",
                content: widget.lang == 1 ? 'Do you want to delete this category?' : "هل تريد حذف هذه الفئة",
              );
            },
            icon: Icon(
              Icons.delete,
              color: global.secondary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputFb1(
                hintText: widget.lang == 1 ? 'Search ...' : "البحث...",
                onchange: (value) => _filterData(value),
              ),
              Align(
                alignment: widget.lang == 1 ? Alignment.centerLeft : Alignment.centerRight,
                child: TextButton(
                  child: Text(
                    widget.lang == 1 ? "Add Product" : "اضافة منتج",
                    style: TextStyle(
                      color: global.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    addProductDialog(
                      context: context,
                      categoryID: widget.category,
                      lang: widget.lang,
                      edit: false,
                    );
                  },
                ),
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else if (_filteredData.isNotEmpty)
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: _filteredData.length,
                  itemBuilder: (context, i) {
                    return ProductCard(
                      id: _filteredData[i]['id'],
                      title: _filteredData[i]['Name'],
                      subtitle: _filteredData[i]['Description'],
                      price: int.parse(_filteredData[i]['Price']),
                      quantity: _filteredData[i]['Quantity'],
                      image: _filteredData[i]['Image'],
                      lang: widget.lang,
                      categoryID: widget.category,
                    );
                  },
                )
              else
                Center(
                  child: Text(
                    widget.lang == 1 ? 'No products found.' : 'لا توجد منتجات.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
