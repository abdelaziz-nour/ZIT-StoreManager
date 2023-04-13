import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_manager/myFunctions/myFunctions.dart';
import 'package:store_manager/globals.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

addCategory({required context, required lang}) {
  final primaryColor = Color(0xff4338CA);
  final secondaryColor = Color(0xff6D28D9);
  final accentColor = Color(0xffffffff);
  final formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  MyFunctions myFunctions = MyFunctions();
  Global global = Global();
  var imageFile;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: accentColor.withOpacity(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                Text(lang == 1 ? "Add New Category" : "اضافة فئة جديدة",
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
                          controller: categoryNameController,
                          decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 20),
                              hintText:
                                  lang == 1 ? "Category Name" : "إسم الفئة",
                              hintStyle: TextStyle(color: Colors.grey[400],)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return lang == 1
                                  ? 'Categpry name field is required'
                                  : "حقل اسم الفئة مطلوب";
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
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
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
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ))),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              if (imageFile == null) {
                                final imageBytes =
                                    await rootBundle.load('assets/zit.jpg');
                                final imageData =
                                    imageBytes.buffer.asUint8List();
                                final multipartFile =
                                    http.MultipartFile.fromBytes(
                                  'Image',
                                  imageData,
                                  filename: 'zit.jpg',
                                  contentType: MediaType('image', 'png'),
                                );
                                await global.databaseHelper.addCategory(
                                    image: multipartFile,
                                    categoryName: categoryNameController.text);
                              } else {
                                await global.databaseHelper.addCategory(
                                    image: imageFile,
                                    categoryName: categoryNameController.text);
                              }
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            lang == 1 ? 'Finish' : "إنهاء",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
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
}
