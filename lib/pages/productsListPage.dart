import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/myWidgets/messages.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';
import 'package:store_manager/globals.dart';
import '../myWidgets/AddProductForm.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key, required this.categoryID});
  final int categoryID;
  @override
  State<ItemsList> createState() => _ItemsListState(categoryID);
}

class _ItemsListState extends State<ItemsList> {
  Global global = Global();
  final categoryID;
  _ItemsListState(this.categoryID);
  @override
  Widget build(BuildContext context) {
    final Messages _messages = Messages(categoryID: categoryID);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 237, 233, 243),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: global.accent,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            'Category Name',
            style: TextStyle(color: global.primary),
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
                  onchange: (value) =>
                      {setState(() => global.searchText = value)}),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                          color: global.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      addProductDialog(
                          context: context, categoryID: categoryID);
                    }),
              ),
              FutureBuilder(
                future:
                    global.databaseHelper.getMyProducts(categoryID: categoryID),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.isEmpty
                              ? 0
                              : snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return ProductCard(
                              id: snapshot.data![i]['id'],
                              title: snapshot.data![i]['Name'],
                              subtitle: snapshot.data![i]['Decription'],
                              price: int.parse(snapshot.data![i]['Price']),
                              quantity: snapshot.data![i]['Quantity'],
                              image: snapshot.data![i]['Image'],
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ]),
          ),
        ));
  }
}
