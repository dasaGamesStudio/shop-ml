import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:markethelper/pages/drawmap_page.dart';
import 'dart:convert';

import '../navigationSystem/navalgo.dart';
import '../navigationSystem/navpoints.dart';

class TakeShelfImage extends StatefulWidget {
  const TakeShelfImage({Key? key}) : super(key: key);

  @override
  State<TakeShelfImage> createState() => _TakeShelfImageState();
}

class _TakeShelfImageState extends State<TakeShelfImage> {
  final ImagePicker _picker = ImagePicker();
  XFile? capturedRackImage = null;
  String errMsg = "";

  _takePhoto(double maxHeight, double maxWidth) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 500,
        maxWidth: 500,
      );
      setState(() {
        capturedRackImage = pickedFile;
      });
    } catch (e) {
      print("Error occured $e");
    }
  }

  _identifyChars(XFile img) async {
    //Image.asset("assets/Images/cover.png", width: 500, fit: BoxFit.contain,)
    var postUri =
        Uri.parse("http://ec2-52-90-15-2.compute-1.amazonaws.com/ocr");
    var request = new http.MultipartRequest("POST", postUri);
    request.files.add(new http.MultipartFile.fromBytes(
        'image', await img.readAsBytes(), filename: "image.jpg", contentType: new MediaType('image','jpeg')));
    print(request.files[0].field);
    request.send().then((response) async {
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseToString = String.fromCharCodes(responseData);
        var res = json.decode(responseToString);
        print(res['content']);
        if(res['content'] == "") {
          setState(() {
            errMsg = "Invalid rack number. Please Re-scan the image";
          });
        } else {
          // check the number is exists on rack ids

          // pass starting point and other points to drawmap page
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MapPage()));
        }
      } else {
        setState(() {
          errMsg = "Error occured when trying to analyzing the image - status code ${response.statusCode}";
        });
      }
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
              Semantics(
                child: capturedRackImage != null
                    ? Image.file(File(capturedRackImage!.path))
                    : Image.asset(
                        "assets/Images/cover.png",
                        width: 500,
                        fit: BoxFit.contain,
                      ),
              ),
              if (capturedRackImage == null)
                ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                          horizontal: paddingVal, vertical: paddingVal * 0.1))),
                  onPressed: () {
                    // _identifyChars(null);

                    _takePhoto(scSize.height, scSize.width);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Take a picture",
                        style: TextStyle(
                            color: Colors.white, fontSize: fontSize * 1.5),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: paddingVal,
                                  vertical: paddingVal * 0.1))),
                      onPressed: () {
                        _identifyChars(capturedRackImage!);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Identify Rack",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontSize * 1.5),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.orange),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: paddingVal,
                                  vertical: paddingVal * 0.1))),
                      onPressed: () {
                        _takePhoto(scSize.height, scSize.width);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Re-take",
                            style: TextStyle(
                                color: Colors.white, fontSize: fontSize * 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if(errMsg != "") Center(child: Text(errMsg, style: TextStyle(color: Colors.red, fontSize: 16),),),
            ],
          ),
        ));
  }
}
