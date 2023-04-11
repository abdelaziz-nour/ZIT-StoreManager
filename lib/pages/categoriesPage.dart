import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/myWidgets/addCategoryForm.dart';
import 'package:store_manager/myWidgets/categoryCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

import '../myAnimations/fadeAnimation.dart';
import '../myFunctions/myFunctions.dart';
import '../myWidgets/loadingIndicator.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final primaryColor = Color(0xff4338CA);
  final secondaryColor = Color(0xff6D28D9);
  final accentColor = Color(0xffffffff);
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  MyFunctions myFunctions = MyFunctions();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  var imageFile;

  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputFb1(hintText: 'Search', onchange: (val) {}),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      child: Text(
                        "Add Category",
                        style: TextStyle(
                            color: Color.fromRGBO(62, 70, 225, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        // _databaseHelper.addCategory(categoryName: categoryNameController.text, image: imageFile??Image.asset('assets/zit.jpg'));
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
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
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(12, 26),
                                            blurRadius: 50,
                                            spreadRadius: 0,
                                            color: Colors.grey.withOpacity(.1)),
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
                                      Text("Add New Category",
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
                                                textAlign: TextAlign.center,
                                                controller:
                                                    categoryNameController,
                                                decoration: InputDecoration(
                                                    hintText: "Category Name",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Colors.grey[400])),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              OutlinedButton(
                                                style: ButtonStyle(
                                                    elevation:
                                                        MaterialStateProperty
                                                            .all(0),
                                                    alignment: Alignment.center,
                                                    side: MaterialStateProperty
                                                        .all(BorderSide(
                                                            width: 1,
                                                            color:
                                                                accentColor)),
                                                    padding:
                                                        MaterialStateProperty.all(
                                                            const EdgeInsets.only(
                                                                right: 35,
                                                                left: 35,
                                                                top: 12.5,
                                                                bottom: 12.5)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.transparent),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ))),
                                                onPressed: () async {
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
                                                        MaterialStateProperty
                                                            .all(0),
                                                    alignment: Alignment.center,
                                                    side: MaterialStateProperty
                                                        .all(BorderSide(
                                                            width: 1,
                                                            color:
                                                                accentColor)),
                                                    padding:
                                                        MaterialStateProperty.all(
                                                            const EdgeInsets.only(
                                                                right: 75,
                                                                left: 75,
                                                                top: 12.5,
                                                                bottom: 12.5)),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.transparent),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ))),
                                                onPressed: () async {
                                                  await _databaseHelper.addCategory(
                                                      image: imageFile ??
                                                          Image.asset(
                                                              'assets/zit.jpg'),
                                                      categoryName:
                                                          categoryNameController
                                                              .text);
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Finish',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }),
                ),
              ),
              FutureBuilder<dynamic>(
                future: _databaseHelper.getMyCategories(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            print(
                                'url>>>>>>>>>>>>>>>>>>>>>>>>>>\nhttp://vzzoz.pythonanywhere.com${snapshot.data.elementAt(index)['Image']}');
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CategoryCard(
                                  dategoryId:
                                      snapshot.data.elementAt(index)['id'],
                                  image:
                                      snapshot.data.elementAt(index)['Image'],
                                  categoryName: snapshot.data
                                      .elementAt(index)['Name']
                                      .toString()),
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
