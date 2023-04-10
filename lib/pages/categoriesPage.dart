import 'package:flutter/material.dart';
import 'package:store_manager/myWidgets/addCategoryForm.dart';
import 'package:store_manager/myWidgets/card.dart';
import 'package:store_manager/myWidgets/searchBar.dart';

import '../myAnimations/fadeAnimation.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController _textEditingController = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SearchInputFb1(
              hintText: '',
              searchController: _textEditingController,
            ),
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
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                PromoCard(categoryName: 'categoryName 1',),
                PromoCard(categoryName: 'categoryName 2',),
                PromoCard(categoryName: 'categoryName 3',),
                PromoCard(categoryName: 'categoryName 4',),
                PromoCard(categoryName: 'categoryName 5',),
                PromoCard(categoryName: 'categoryName 6',),
                PromoCard(categoryName: 'categoryName 7',),
                PromoCard(categoryName: 'categoryName 8',),
              ],
            )
          ],
        ),
      ),
    );
  }
}
