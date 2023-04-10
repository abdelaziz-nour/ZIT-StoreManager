import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../myAnimations/fadeAnimation.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final int quantity;
  final int price;

  const ProductCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => ProductCardState(
        title: title,
        subtitle: subtitle,
        price: price,
        quantity: quantity,
      );
}

class ProductCardState extends State<ProductCard> {
  ProductCardState({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    Key? key,
  });
  final String title;
  final String subtitle;
  final int quantity;
  final int price;
  var quantityController = TextEditingController(text: '0');

  bool _isEnabled = false;
  callbackFunction(bool val) => {setState(() => _isEnabled = val)};

  void _handleTap(String tap) {
    if (quantityController.text == "") {
      quantityController.text = "0";
    } else if (tap == "+") {
      setState(() {
        quantityController.text =
            (int.parse(quantityController.text) + 1).toString();
      });
    } else if (tap == "-" && int.parse(quantityController.text) > 0) {
      setState(() {
        quantityController.text =
            (int.parse(quantityController.text) - 1).toString();
      });
    }

    if (int.parse(quantityController.text) > 0) {
      callbackFunction(false);
    } else {
      callbackFunction(true);
    }
  }

  bool is_pressed = false;

  final dishImage =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/malika%2FRectangle%2013.png?alt=media&token=6a5f056c-417c-48d3-b737-f448e4f13321";

  final orangeColor = const Color(0xffFF8527);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      2,
      Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        print('4');
                      },
                    ),
                  ],
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        is_pressed = !is_pressed;
                      });
                    },
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          dishImage,
                        )),
                    title: Text(title),
                    subtitle: Text('$subtitle\n$quantity'),
                    trailing: Text('$price\nSDG'),
                    isThreeLine: true,
                  ),
                ),
                is_pressed == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () => _handleTap('-'),
                              child: Text("-")),
                          SizedBox(
                            width: 30,
                            child: TextField(
                              controller: quantityController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[1-9][0-9]*'))
                              ],
                              textAlign: TextAlign.center,
                            ),
                          ),
                          TextButton(
                              onPressed: () => _handleTap('+'),
                              child: Text("+")),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
          is_pressed == true
              ? Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        is_pressed = false;
                      });
                    },
                    child: Text("Finish"),
                  ))
              : Container()
        ],
      ),
    );
  }
}
