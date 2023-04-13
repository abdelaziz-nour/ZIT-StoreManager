import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/addCategoryForm.dart';
import 'package:store_manager/myWidgets/categoryCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';
import 'package:store_manager/globals.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key, required this.lang});
  final int lang;
  @override
  State<Categories> createState() => _CategoriesState(lang: lang);
}

class _CategoriesState extends State<Categories> {
  _CategoriesState({required this.lang});
  final int lang;
  @override
  Widget build(BuildContext context) {
    Global global = Global();
    return Scaffold(
      backgroundColor: global.accent,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputFb1(
                  hintText: lang == 1 ? 'Search' : 'البحث', onchange: (val) {}),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Align(
                  alignment:
                      lang == 1 ? Alignment.centerLeft : Alignment.centerRight,
                  child: TextButton(
                      child: Text(
                        lang == 1 ? "Add Category" : "إضافة فئة",
                        style: TextStyle(
                            color: global.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        addCategory(context: context, lang: lang);
                      }),
                ),
              ),
              FutureBuilder<dynamic>(
                future: global.databaseHelper.getMyCategories(),
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
