import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/addCategoryForm.dart';
import 'package:store_manager/myWidgets/categoryCard.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

import '../myAnimations/fadeAnimation.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var data = {
    {
      'Name': 'Clothes',
    },
    {
      'Name': 'Accessories',
    },
    {
      'Name': 'Food',
    },
  };
  String searchText = "";

  List<Map<String, String>> _filteredData = [];
  void _filterData(String query) {
    setState(() {
      _filteredData = data
          .where((item) =>
              item['Name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchInputFb1(
                  hintText: 'Search',
                  onchange: (value) => {_filterData(value)}),
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
                        addDialog(context: context);
                      }),
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: _filteredData.isEmpty
                      ? data.length
                      : _filteredData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _filteredData.isEmpty
                        ? CategoryCard(
                            categoryName:
                                data.elementAt(index)['Name'].toString())
                        : CategoryCard(
                            categoryName:
                                _filteredData[index]['Name'].toString());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
