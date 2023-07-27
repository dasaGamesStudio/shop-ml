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
        Uri.parse("http://ec2-52-90-15-2.compute-1.amazonaws.com/ocr/optimized");
    var request = new http.MultipartRequest("POST", postUri);
    request.files.add(new http.MultipartFile.fromBytes(
        'image', await img.readAsBytes(), filename: "image.jpg", contentType: new MediaType('image','jpeg')));
    print(request.files[0].field);
    request.send().then((response) async {
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseToString = String.fromCharCodes(responseData);
        var res = json.decode(responseToString);
        print('response');
        print(res['content']);
        if(res['content'] == "") {
          setState(() {
            errMsg = "Invalid rack number. Please Re-scan the image";
          });
        } else {
          // check the number is exists on rack id
          var positionMap = {"1001":"1a", "1002":"1b","1003":"1c","1004":"1d","1005":"1e","1006":"1f", "2001":"2a", "2002":"2b","2003":"2c","2004":"1d","2005":"2e","2006":"2f", "3001":"3a", "3002":"3b","3003":"3c","3004":"3d","3005":"3e","3006":"3f",  };
          var rackNo = res['content'].replaceAll(new RegExp(r'[^0-9]'),'');

          String? rack = positionMap[rackNo];
          print(rack);
          if(rack == null) {
            setState(() {
              errMsg = "Invalid rack number. Please Re-scan the image";
            });
            return;
          }

          // pass starting point and other points to drawmap page
          if(rack != null ) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapPage(rack: rack)));
          }
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
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: paddingVal,
                                  vertical: paddingVal * 0.1))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MapPage(rack: '1a')));

                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Navigate From Door",
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
