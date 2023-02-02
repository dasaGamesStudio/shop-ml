import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class TakeShelfImage extends StatefulWidget {
  const TakeShelfImage({Key? key}) : super(key: key);

  @override
  State<TakeShelfImage> createState() => _TakeShelfImageState();
}

class _TakeShelfImageState extends State<TakeShelfImage> {
  final ImagePicker _picker = ImagePicker();
  XFile? capturedRackImage = null;

  _takePhoto(double maxHeight, double maxWidth) async {
    try{
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera, maxHeight: 500, maxWidth: 500, );
      setState(() {
        capturedRackImage = pickedFile;
      });
    } catch (e) {
      print("Error occured $e");
    }
  }

  _identifyChars() async {
    //Image.asset("assets/Images/cover.png", width: 500, fit: BoxFit.contain,)
    var postUri = Uri.parse("https://28r7i2vkmc.execute-api.us-east-1.amazonaws.com/ocr");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
    request.files.add(new http.MultipartFile.fromBytes('file', await File("assets/Images/cover.png").readAsBytes()));

    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    double refLength =
        (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.05;
    double fontSize = refLength * 0.04;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Identify Shelf",
            style: TextStyle(color: Colors.white, fontSize: fontSize * 1.6),
          ),
          centerTitle: false,
        ),
        body: Center(
          child: Column(
            children: [
              Semantics(child: capturedRackImage != null ? Image.file(File(capturedRackImage!.path)) : Image.asset("assets/Images/cover.png", width: 500, fit: BoxFit.contain,),),
              if (capturedRackImage != null) ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: paddingVal, vertical: paddingVal * 0.1))),
                onPressed: () {
                  _takePhoto(scSize.height, scSize.width);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                    ),
                    Text(
                      "Take a picture",
                      style: TextStyle(color: Colors.white, fontSize: fontSize * 1.5),
                    ),
                  ],
                ),
              ) else Column(children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: paddingVal, vertical: paddingVal * 0.1))),
                  onPressed: () {
                    _identifyChars();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.search, color: Colors.white,),
                      ),
                      Text(
                        "Identify Rack",
                        style: TextStyle(color: Colors.white, fontSize: fontSize * 1.5),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: paddingVal, vertical: paddingVal * 0.1))),
                  onPressed: () {
                    _takePhoto(scSize.height, scSize.width);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                      ),
                      Text(
                        "Re-take",
                        style: TextStyle(color: Colors.white, fontSize: fontSize * 1.5),
                      ),
                    ],
                  ),
                )
              ],),
            ],
          ),
        ));
  }
}
