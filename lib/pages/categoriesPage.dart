import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/addCategoryForm.dart';
import 'package:store_manager/myWidgets/categoryCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';
import 'package:store_manager/globals.dart';

class Categories extends StatefulWidget {
  const Categories(
      {Key? key,
      required this.lang,
      required this.storeName,
      required this.storeID});
  final int lang;
  final String storeID;
  final String storeName;
  @override
  State<Categories> createState() =>
      _CategoriesState(lang: lang, storeID: storeID, storeName: storeName);
}

class _CategoriesState extends State<Categories> {
  _CategoriesState(
      {required this.lang, required this.storeName, required this.storeID});
  final int lang;
  final String storeID;
  final String storeName;
  Global global = Global();
  List _filteredData = [];
  bool first = true;
  void _filterData(String query, data) {
    ////print(data);
    setState(() {
      first = false;
      _filteredData = data
          .where((item) =>
              item['Name']!.toLowerCase().contains(query.toLowerCase())
                  ? true
                  : false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: global.accent,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<dynamic>(
                stream: global.databaseHelper
                    .getMyCategories(storeID: storeID.toString())
                    .asStream(),
                builder: (context, snapshot) {
                  ////print(snapshot.data);
                  return snapshot.hasData
                      ? Column(
                          children: [
                            SearchInputFb1(
                                hintText: lang == 1 ? 'Search' : 'البحث',
                                onchange: (value) => setState(
                                    () => _filterData(value, snapshot.data))),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20),
                              child: Align(
                                alignment: lang == 1
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                child: TextButton(
                                    child: Text(
                                      lang == 1 ? "Add Category" : "إضافة فئة",
                                      style: TextStyle(
                                          color: global.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    onPressed: () {
                                      addCategory(
                                          context: context,
                                          lang: lang,
                                          edit: false);
                                    }),
                              ),
                            ),
                            GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                ),
                                itemCount: _filteredData.isEmpty
                                    ? snapshot.data.length
                                    : _filteredData.length,
                                itemBuilder: (context, int index) {
                                  return _filteredData.isNotEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CategoryCard(
                                            storeID: storeID,
                                            storeName: storeName,
                                            categoryId: _filteredData
                                                .elementAt(index)['id'],
                                            image: _filteredData
                                                .elementAt(index)['Image'],
                                            categoryName: _filteredData
                                                .elementAt(index)['Name']
                                                .toString(),
                                            lang: lang,
                                          ),
                                        )
                                      : first == true
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CategoryCard(
                                                storeID: storeID,
                                                storeName: storeName,
                                                categoryId: snapshot.data
                                                    .elementAt(index)['id']
                                                    .toString(),
                                                image: snapshot.data
                                                    .elementAt(index)['Image'],
                                                categoryName: snapshot.data
                                                    .elementAt(index)['Name']
                                                    .toString(),
                                                lang: lang,
                                              ),
                                            )
                                          : Container();
                                }),
                          ],
                        )
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
