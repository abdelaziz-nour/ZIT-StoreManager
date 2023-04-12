import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/myWidgets/messages.dart';
import 'package:store_manager/myWidgets/productCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

import '../myFunctions/myFunctions.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key, required this.categoryID});
  final int categoryID;
  @override
  State<ItemsList> createState() => _ItemsListState(categoryID);
}

class _ItemsListState extends State<ItemsList> {
  final categoryID;
  _ItemsListState(this.categoryID);
  DatabaseHelper _databaseHelper = DatabaseHelper();
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
  final primaryColor = Color(0xff4338CA);
  final secondaryColor = Color(0xff6D28D9);
  final accentColor = Color(0xffffffff);
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productSubtitleController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();
  MyFunctions myFunctions = MyFunctions();
  var imageFile;

  @override
  Widget build(BuildContext context) {
    final Messages _messages = Messages(categoryID: categoryID);
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SingleChildScrollView(
                              child: AlertDialog(
                                backgroundColor: accentColor.withOpacity(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                actions: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          primaryColor,
                                          secondaryColor
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(12, 26),
                                              blurRadius: 50,
                                              spreadRadius: 0,
                                              color:
                                                  Colors.grey.withOpacity(.1)),
                                        ]),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              accentColor.withOpacity(.05),
                                          radius: 25,
                                          child: Image.network(
                                              "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/FlutterBricksLogo-Med.png?alt=media&token=7d03fedc-75b8-44d5-a4be-c1878de7ed52"),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text("Add New Product",
                                            style: TextStyle(
                                                color: accentColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(
                                          height: 3.5,
                                        ),
                                        Form(
                                          key: formKey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      productNameController,
                                                  decoration: InputDecoration(
                                                      hintText: "Product Name",
                                                      hintStyle: TextStyle(
                                                          color: Colors
                                                              .grey[400])),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      productSubtitleController,
                                                  decoration: InputDecoration(
                                                      hintText: "Subtitle",
                                                      hintStyle: TextStyle(
                                                          color: Colors
                                                              .grey[400])),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      productPriceController,
                                                  decoration: InputDecoration(
                                                      hintText: "Price",
                                                      hintStyle: TextStyle(
                                                          color: Colors
                                                              .grey[400])),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextFormField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                      productQuantityController,
                                                  decoration: InputDecoration(
                                                      hintText: "Quantity",
                                                      hintStyle: TextStyle(
                                                          color: Colors
                                                              .grey[400])),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                OutlinedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty.all(
                                                              0),
                                                      alignment:
                                                          Alignment.center,
                                                      side: MaterialStateProperty
                                                          .all(BorderSide(
                                                              width: 1,
                                                              color:
                                                                  accentColor)),
                                                      padding: MaterialStateProperty.all(
                                                          const EdgeInsets.only(
                                                              right: 35,
                                                              left: 35,
                                                              top: 12.5,
                                                              bottom: 12.5)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Colors
                                                                  .transparent),
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ))),
                                                  onPressed: () {
                                                    setState(() async {
                                                      imageFile =
                                                          await myFunctions
                                                              .getFromGallery();
                                                    });
                                                  },
                                                  child: Text(
                                                    'Add Image',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                OutlinedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty.all(
                                                              0),
                                                      alignment:
                                                          Alignment.center,
                                                      side: MaterialStateProperty
                                                          .all(BorderSide(
                                                              width: 1,
                                                              color:
                                                                  accentColor)),
                                                      padding: MaterialStateProperty.all(
                                                          const EdgeInsets.only(
                                                              right: 75,
                                                              left: 75,
                                                              top: 12.5,
                                                              bottom: 12.5)),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Colors
                                                                  .transparent),
                                                      shape: MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.0),
                                                      ))),
                                                  onPressed: () async {
                                                    await _databaseHelper.addProduct(
                                                        name:
                                                            productNameController
                                                                .text,
                                                        decription:
                                                            productSubtitleController
                                                                .text,
                                                        price: int.parse(
                                                            productPriceController
                                                                .text),
                                                        quantity: int.parse(
                                                            productQuantityController
                                                                .text),
                                                        categoryID: categoryID,
                                                        image: imageFile);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Finish',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),

              FutureBuilder(
                future: _databaseHelper.getMyProducts(categoryID: categoryID),
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

              // ListView.builder(
              //     primary: false,
              //     shrinkWrap: true,
              //     itemCount: data.isEmpty ? 0 : data.length,
              //     itemBuilder: (context, i) {
              //       if (data
              //           .elementAt(i)['title']
              //           .toString()
              //           .toLowerCase()
              //           .contains((searchText.toLowerCase()))) {
              //         return ProductCard(
              //           title: data.elementAt(i)['title'].toString(),
              //           subtitle: data.elementAt(i)['subtitle'].toString(),
              //           price: int.parse(data.elementAt(i)['price'].toString()),
              //           quantity:
              //               int.parse(data.elementAt(i)['quantity'].toString()),
              //         );
              //       }
              //       return SizedBox();
              //     })
            ]),
          ),
        ));
  }
}
