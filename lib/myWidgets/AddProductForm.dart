import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manager/myFunctions/myFunctions.dart';
import 'package:store_manager/globals.dart';

addProductDialog(
    {required context, required String categoryID, required int lang}) {
  final primaryColor = Color(0xff4338CA);
  final secondaryColor = Color(0xff6D28D9);
  final accentColor = Color(0xffffffff);
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final productSubtitleController = TextEditingController();
  final productPriceController = TextEditingController();
  final productQuantityController = TextEditingController();
  MyFunctions myFunctions = MyFunctions();
  Global global = Global();
  var imageFile;
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            actions: [
              Container(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [primaryColor, secondaryColor]),
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
                        backgroundColor: accentColor.withOpacity(.05),
                        radius: 25,
                        child: Image.asset('assets/FlutterBricksLogo.png')),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(lang == 1 ? "Add New Product" : "اضافة منتج جديد",
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
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              controller: productNameController,
                              decoration: InputDecoration(
                                  hintText:
                                      lang == 1 ? "Product Name" : "اسم المنتج",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == 1
                                      ? 'Product Name field is required'
                                      : "حقل اسم المنتج مطلوب";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              controller: productSubtitleController,
                              decoration: InputDecoration(
                                  hintText: lang == 1 ? "Description" : "الوصف",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == 1
                                      ? ' Description field is required'
                                      : "حقل الوصف مطلوب";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.center,
                              controller: productPriceController,
                              decoration: InputDecoration(
                                  hintText: lang == 1 ? "Price" : "السعر",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == 1
                                      ? ' Price field is required'
                                      : "حقل السعر مطلوب";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textAlign: TextAlign.center,
                              controller: productQuantityController,
                              decoration: InputDecoration(
                                  hintText: lang == 1 ? "Quantity" : "الكمية",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return lang == 1
                                      ? ' Quantity field is required'
                                      : "حقل الكمية مطلوب";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  alignment: Alignment.center,
                                  side: MaterialStateProperty.all(
                                      BorderSide(width: 1, color: accentColor)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          right: 35,
                                          left: 35,
                                          top: 12.5,
                                          bottom: 12.5)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ))),
                              onPressed: () async {
                                imageFile = await myFunctions.getFromGallery();
                              },
                              child: Text(
                                lang == 1 ? 'Add Image' : "اضافة صورة",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  alignment: Alignment.center,
                                  side: MaterialStateProperty.all(
                                      BorderSide(width: 1, color: accentColor)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.only(
                                          right: 75,
                                          left: 75,
                                          top: 12.5,
                                          bottom: 12.5)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ))),
                              onPressed: () async {
                                try {
                                  if (formKey.currentState!.validate()) {
                                    await global.databaseHelper.addProduct(
                                        name: productNameController.text,
                                        description:
                                            productSubtitleController.text,
                                        price: int.parse(
                                            productPriceController.text),
                                        quantity: int.parse(
                                            productQuantityController.text),
                                        categoryID: categoryID,
                                        image: imageFile);
                                    Navigator.pop(context);
                                  }
                                } catch (e) {
                                  return myFunctions.noImageField(
                                      context, lang);
                                }
                              },
                              child: Text(
                                lang == 1 ? 'Finish' : "إنهاء",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
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
}
