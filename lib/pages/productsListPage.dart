import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/AddProductForm.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

class ItemsList extends StatelessWidget {
  ItemsList({super.key});
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(
            'Store Name',
            style: TextStyle(color: Colors.blue),
          )),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchInputFb1(
                  hintText: 'Search', searchController: _textEditingController),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                          color: Color.fromRGBO(62, 70, 225, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      addProductDialog(context: context);
                    }),
              ),
            ),
            ProductCard(
              title: 'title',
              subtitle: 'subtitle',
              price: 250,
            )
          ]),
        ));
  }
}
