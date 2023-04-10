import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/AddProductForm.dart';
import 'package:store_manager/myWidgets/messages.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

class ItemsList extends StatefulWidget {
  ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  TextEditingController _textEditingController = TextEditingController();
  Messages _messages = Messages();

  @override
  Widget build(BuildContext context) {
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
            'Category Name',
            style: TextStyle(color: Color(0xff4338CA)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _messages.showMyDialog(
                      context: context, title: 'Deletion', content: 'Do you want to delete this category ?');
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchInputFb1(
                  hintText: 'Search', searchController: _textEditingController),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
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
              title: 'title 1',
              subtitle: 'subtitle 1',
              quantity: 0,
              price: 2500,
            ),
            ProductCard(
              title: 'title 2',
              subtitle: 'subtitle 2',
              quantity: 0,
              price: 4200,
            ),
          ]),
        ));
  }
}
