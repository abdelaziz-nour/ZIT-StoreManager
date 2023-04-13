import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_manager/globals.dart';

class MyFunctions {
  /// Get Image From Gallery
  getFromGallery() async {
    final picker = ImagePicker();

    // use the image picker to pick image from Gallery
    var file = await picker.pickImage(
      source: ImageSource.gallery,
    );

    // convert the picked image to Multipart file to upload using http
    var mFile = MultipartFile.fromBytes(
        "Image", File(file?.path ?? "").readAsBytesSync(),
        filename: 'Image.png');
    return mFile;
  }

  noImageField(context, lang) {
    Global global = Global();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(lang == 1 ? 'Error' : "خطأ"),
              content: Text(
                  lang == 1 ? 'Image field is required' : "حقل الصورة مطلوب"),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: global.primary),
                    child: Text(
                      lang == 1 ? 'Close' : "إغلاق",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
