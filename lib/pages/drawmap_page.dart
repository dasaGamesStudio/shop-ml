import 'dart:ui' as ui;
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markethelper/appfunctions/productdatabase.dart';
import 'package:markethelper/models/cart_item_model.dart';
import 'package:markethelper/navigationSystem/navalgo.dart';
import 'package:markethelper/navigationSystem/navpoints.dart';
import 'package:markethelper/navigationSystem/waypoint_model.dart';

import '../services/authservice.dart';

class MapPage extends StatefulWidget {
  MapPage({Key? key, required this.rack}) : super(key: key);

  final String? rack;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ui.Image? image;

  var startingNode = null;

  loadCartItem() async {
    CartMapData.cmItems.clear();
    var data = await FirebaseFirestore.instance.collection("UserCart").doc(AuthService.uid).collection("cartItems").get();
    data.docs.forEach((item) {
      Map<String, dynamic> obj = item.data() as Map<String, dynamic>;
      CartItem ci = CartItem.fromJson(obj);
      print(ci.name);
      CartMapData.cmItems.add(ci);
      print("Length of cart items is ${CartMapData.cmItems.length}");

    });

    List<String> idslist = [];
    CartMapData.cmItems.forEach((element) {
      idslist.add(element.shelfID + element.sectionID);
    });
    NavSys.GetProductPlacementNodes(idslist);
    NavSys.FindPathFromMultiple(startingNode, NavSys.PPLaceNodes);
    CartMapData.GetCartItemsAtNode(NavSys.TargetNode.id);



  }


  removeShoppedItems(){
    CartMapData.cItemsatPlace.forEach((element) {
      NavSys.updateNodePositions();
    });

    //loadCartItem();
  }




  @override
  void initState() {
    super.initState();
    NavPoint.GetNavNeighbors();
    loadImage("assets/maps/shopmap.png");
    print("Welcome to map page");
    loadCartItem();
  }

  Future loadImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    setState(() => this.image = image);
  }

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    double refLength =
        (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.05;
    double fontSize = refLength * 0.04;

    // switch(widget.rack) {
    //   case '1a':
    //     startingNode = NavPoint.w2;
    //     break;
    //   case '1b':
    //     startingNode = NavPoint.w3;
    //     break;
    //   default:
    //     startingNode = NavPoint.w2;
    // }

    NavPoint.NavPList.forEach((element) {
      if(element.id == widget.rack){
        startingNode = element;
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Map View",
          style: TextStyle(color: Colors.white, fontSize: fontSize * 1.6),
        ),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Center(
          child: image == null
              ? CircularProgressIndicator()
              : InteractiveViewer(
                  minScale: 1,
                  maxScale: 5,
                  child: Container(
                    color: Colors.white,
                    width: scSize.width,
                    height: scSize.height,
                    child: FittedBox(
                      child: SizedBox(
                        width: image?.width.toDouble(),
                        height: image?.height.toDouble(),
                        child: CustomPaint(
                          painter: MapImagePainter(image!),
                          foregroundPainter: DrawPath(),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        SafeArea(
          bottom: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingVal * 0.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(refLength * 0.05),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.shade800,
                          width: paddingVal * 0.08),
                      borderRadius: BorderRadius.circular(refLength * 0.05),
                      color: Color.fromARGB(150, 255, 255, 255)),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${"${CartMapData.cItemsatPlace[0].name}"}",
                              style: TextStyle(
                                  fontSize: fontSize * 1.5, color: Colors.green,
                                overflow: TextOverflow.ellipsis
                              ),
                            ),
                            Text(
                              "Aisle: ${NavSys.TargetNode.id}",
                              style: TextStyle(
                                  fontSize: fontSize, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10000))),
                            side: MaterialStateProperty.all(
                                BorderSide(width: 1, color: Colors.white)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.all(refLength * 0.04)),
                          ),
                          onPressed: () {
                            setState(() {
                              if(NavSys.PPLaceNodes.length > 0){
                                removeShoppedItems();
                                NavSys.FindPathFromMultiple(NavSys.TargetNode, NavSys.PPLaceNodes);
                                CartMapData.GetCartItemsAtNode(NavSys.TargetNode.id);
                              }
                            });
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Items at Point"),
                                    content: Text(
                                      CartMapData.GetModCartItemNames(),
                                    ),
                                    actions: [
                                      CupertinoButton(
                                          child: Text("Okay"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  );
                                });
                          },
                          child: Icon(
                            Icons.shopping_bag_rounded,
                            color: Colors.white,
                            size: fontSize * 2,
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class MapImagePainter extends CustomPainter {
  final ui.Image image;

  const MapImagePainter(this.image);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()..color = Colors.red;
    canvas.drawImage(image, Offset.zero, paint);

    final List<WNode> list = NavPoint.NavPList;

    list.forEach((element) {
      canvas.drawCircle(
          Offset(element.position.width, element.position.height), 10, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DrawPath extends CustomPainter {
//  const DrawPath(this.image);

  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint()..color = Colors.green;
    // canvas.drawImage(image, Offset.zero, paint);

    final List<WNode> wayPlist = NavSys.NavPath;

    for (int i = 1; i < wayPlist.length; i++) {
      canvas.drawLine(
          Offset(
              wayPlist[i - 1].position.width, wayPlist[i - 1].position.height),
          Offset(wayPlist[i].position.width, wayPlist[i].position.height),
          paint
            ..color = Colors.blue.shade800
            ..strokeWidth = 35
            ..strokeCap = StrokeCap.round);
    }
    for (int i = 1; i < wayPlist.length; i++) {
      canvas.drawLine(
          Offset(
              wayPlist[i - 1].position.width, wayPlist[i - 1].position.height),
          Offset(wayPlist[i].position.width, wayPlist[i].position.height),
          paint
            ..color = Colors.blue.shade300
            ..strokeWidth = 25
            ..strokeCap = StrokeCap.round);
    }

    // User Location markeer
    canvas.drawCircle(
        Offset(wayPlist[0].position.width, wayPlist[0].position.height),
        40,
        paint..color = Colors.grey.shade700);
    canvas.drawCircle(
        Offset(wayPlist[0].position.width, wayPlist[0].position.height),
        32,
        paint..color = Colors.grey.shade400);

    // Product Location Marker
    canvas.drawCircle(
        Offset(wayPlist[wayPlist.length - 1].position.width,
            wayPlist[wayPlist.length - 1].position.height),
        40,
        paint..color = Colors.grey.shade800);
    canvas.drawCircle(
        Offset(wayPlist[wayPlist.length - 1].position.width,
            wayPlist[wayPlist.length - 1].position.height),
        32,
        paint..color = Colors.grey.shade100);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ElevatedButton(onPressed: (){
// NavPoint.GetNavNeighbors();
// NavSys.FindPathFromMultiple(NavPoint.w30, [NavPoint.w20,NavPoint.w1, NavPoint.w39]);
// }, child: Text("Get Neighbors")),
