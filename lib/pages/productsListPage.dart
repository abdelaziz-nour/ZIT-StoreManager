import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/AddProductForm.dart';
import 'package:store_manager/myWidgets/messages.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  TextEditingController _textEditingController = TextEditingController();
  final Messages _messages = Messages();
  var data = {
    {'title': 'kfc', 'subtitle': 'subtitle', 'quantity': 7, 'price': 1200},
    {
      'title': 'mcdonalds',
      'subtitle': 'subtitle 2',
      'quantity': 12,
      'price': 2200000000000000000
    },
    {
      'title': 'donalds',
      'subtitle': 'subtitle 3',
      'quantity': 23,
      'price': 42000
    }
  };
  String searchText = '';

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
                      context: context,
                      title: 'Deletion',
                      content: 'Do you want to delete this category ?');
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: [
              SearchInputFb1(
                  hintText: 'Search ...',
                  onchange: (value) => {setState(() => searchText = value)}),
              Align(
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
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: data.isEmpty ? 0 : data.length,
                  itemBuilder: (context, i) {
                    if (data
                        .elementAt(i)['title']
                        .toString()
                        .toLowerCase()
                        .contains((searchText.toLowerCase()))) {
                      return ProductCard(
                        title: data.elementAt(i)['title'].toString(),
                        subtitle: data.elementAt(i)['subtitle'].toString(),
                        price: int.parse(data.elementAt(i)['price'].toString()),
                        quantity:
                            int.parse(data.elementAt(i)['quantity'].toString()),
                      );
                    }
                    return SizedBox();
                  })
            ]),
          ),
        ));
  }
}
