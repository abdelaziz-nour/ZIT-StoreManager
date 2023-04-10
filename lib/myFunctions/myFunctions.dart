import 'dart:io';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

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
      "payment_Notification",
      File(file?.path ?? "").readAsBytesSync(),
      filename: "Notification Image",
    );
    print(mFile.toString());
  }

  
}
