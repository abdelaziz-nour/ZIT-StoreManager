import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/messages.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';
import 'package:store_manager/globals.dart';
import '../myWidgets/AddProductForm.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key, required this.categoryID,required this.categoryName, required this.lang,required this.storeID,required this.storeName});
  final int lang;
  final int categoryID;
  final String categoryName ;
  final int storeID;
  final String storeName ;
  @override
  State<ItemsList> createState() => _ItemsListState(categoryID, lang: lang,storeID: storeID,storeName: storeName, categoryName: categoryName);
}

class _ItemsListState extends State<ItemsList> {
  Global global = Global();
  final int lang;
  final categoryID;
  final String categoryName;
  final int storeID;
  final String storeName ;
  _ItemsListState(this.categoryID, {required this.lang,required this.categoryName,required this.storeID,required this.storeName});
  @override
  Widget build(BuildContext context) {
    final Messages _messages = Messages(categoryID: categoryID, lang: lang,storeID: storeID,storeName: storeName);
    return Scaffold(
        backgroundColor: global.accent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: global.accent,
          elevation: 0,
          leading: BackButton(
            color: global.black,
            onPressed: () => {Navigator.pop(context)},
          ),
          title: Text(
            categoryName,
            style: TextStyle(color: global.primary),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _messages.showMyDialog(
                      context: context,
                      title: lang == 1 ? 'Deletion' : "حذف",
                      content: lang == 1
                          ? 'Do you want to delete this category ?'
                          : "هل تريد حذف هذه الفئة");
                },
                icon: Icon(
                  Icons.delete,
                  color: global.secondary,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: [
              SearchInputFb1(
                  hintText: lang == 1 ? 'Search ...' : "البحث...",
                  onchange: (value) =>
                      {setState(() => global.searchText = value)}),
              Align(
                alignment:
                    lang == 1 ? Alignment.centerLeft : Alignment.centerRight,
                child: TextButton(
                    child: Text(
                      lang == 1 ? "Add Product" : "اضافة منتج",
                      style: TextStyle(
                          color: global.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    onPressed: () {
                      addProductDialog(
                          context: context, categoryID: categoryID, lang: lang);
                    }),
              ),
              StreamBuilder(
                  stream: global.databaseHelper
                      .getMyProducts(categoryID: categoryID)
                      .asStream(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.isEmpty
                                ? 0
                                : snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return snapshot.data![i]['Name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          (global.searchText.toLowerCase()))
                                  ? ProductCard(
                                      id: snapshot.data![i]['id'],
                                      title: snapshot.data![i]['Name'],
                                      subtitle: snapshot.data![i]['Decription'],
                                      price:
                                          int.parse(snapshot.data![i]['Price']),
                                      quantity: snapshot.data![i]['Quantity'],
                                      image: snapshot.data![i]['Image'],
                                      lang: lang,
                                    )
                                  : Container();
                            })
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
              // FutureBuilder(
              //   future:
              //       global.databaseHelper.getMyProducts(categoryID: categoryID),
              //   builder: (context, snapshot) {
              //     return snapshot.hasData
              //         ? ListView.builder(
              //             primary: false,
              //             shrinkWrap: true,
              //             itemCount: snapshot.data!.isEmpty
              //                 ? 0
              //                 : snapshot.data!.length,
              //             itemBuilder: (context, i) {
              //               return snapshot.data![i]['Name']
              //                       .toString()
              //                       .contains(global.searchText)
              //                   ? ProductCard(
              //                       id: snapshot.data![i]['id'],
              //                       title: snapshot.data![i]['Name'],
              //                       subtitle: snapshot.data![i]['Decription'],
              //                       price:
              //                           int.parse(snapshot.data![i]['Price']),
              //                       quantity: snapshot.data![i]['Quantity'],
              //                       image: snapshot.data![i]['Image'],
              //                       lang: lang,
              //                     )
              //                   : Container();
              //             })
              //         : Center(
              //             child: CircularProgressIndicator(),
              //           );
              //   },
              // ),
            ]),
          ),
        ));
  }
}
