import 'package:flutter/material.dart';
import 'package:store_manager/api/apiRequests.dart';
import 'package:store_manager/myFunctions/myFunctions.dart';


addDialog({required context}) {

}
/*
AlertDialog(
      backgroundColor: accentColor.withOpacity(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [primaryColor, secondaryColor]),
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
                        controller: categoryNameController,
                        decoration: InputDecoration(
                            hintText: "Category Name",
                            hintStyle: TextStyle(color: Colors.grey[400])),
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
                        onPressed: () {
                          setState(() {
                            imageFile=myFunctions.getFromGallery();
                          });
                        },
                        child: Text(
                          'Add Image',
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
                          await _databaseHelper.addCategory(
                              image: imageFile ?? Image.asset('assets/zit.jpg'),
                              categoryName: categoryNameController.text);
                        },
                        child: Text(
                          'Finish',
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
*/