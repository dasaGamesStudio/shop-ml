import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markethelper/appfunctions/productdatabase.dart';
import 'package:markethelper/navigationSystem/navalgo.dart';
import 'package:markethelper/navigationSystem/navpoints.dart';
import 'package:markethelper/navigationSystem/waypoint_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();
    NavPoint.GetNavNeighbors();
    loadImage("assets/maps/shopmap.png");
    List<String> idslist =[];
    CartMapData.cmItems.forEach((element) {
      idslist.add(element.shelfID+element.sectionID);
    });
    //print(idslist[0]+" Bhanuka Idiot");
    print(CartMapData.cmItems.length.toString() + " Bhanuka Haraka");
    NavSys.GetProductPlacementNodes(idslist);
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

    print(NavSys.PPLaceNodes.length.toString() +" hefrjhfjfvdjfhvkdhvkdhfvjkfhkvjf");
    NavSys.FindPathFromMultiple(NavPoint.w2, NavSys.PPLaceNodes);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Map View",
          style: TextStyle(color: Colors.white, fontSize: fontSize * 1.6),
        ),
      ),
      body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
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
                        border: Border.all(color: Colors.grey.shade800, width: paddingVal * 0.08),
                        borderRadius: BorderRadius.circular(refLength * 0.05),
                        color: Color.fromARGB(150, 255, 255, 255)
                      ),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10000))),
                                side: MaterialStateProperty.all(BorderSide(width: 1,color: Colors.white)),
                                padding: MaterialStateProperty.all(EdgeInsets.all(refLength * 0.05)),
                              ),
                              onPressed: (){},
                              child: Icon(Icons.close_rounded, color: Colors.white,size: fontSize * 2,)
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Apple",style: TextStyle(fontSize: fontSize * 2, color: Colors.green),),
                              Text("Shelf: 2a",style: TextStyle(fontSize: fontSize, color: Colors.grey[600]),),
                              Text("Floor: 2",style: TextStyle(fontSize: fontSize, color: Colors.grey[600]),),
                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10000))),
                              side: MaterialStateProperty.all(BorderSide(width: 1,color: Colors.white)),
                              padding: MaterialStateProperty.all(EdgeInsets.all(refLength * 0.05)),
                            ),
                              onPressed: (){},
                              child: Icon(Icons.shopping_bag_rounded, color: Colors.white,size: fontSize * 2,)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
      )
      ,
    );
  }
}

class MapImagePainter extends CustomPainter {
  final ui.Image image;

  const MapImagePainter(this.image);

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = Colors.red;
    canvas.drawImage(image, Offset.zero, paint);

    final List<WNode> list = NavPoint.NavPList;

    list.forEach((element) {
      canvas.drawCircle(Offset(element.position.width, element.position.height), 10, paint);
    });

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DrawPath extends CustomPainter {

//  const DrawPath(this.image);

  @override
  void paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = Colors.green;
   // canvas.drawImage(image, Offset.zero, paint);

    final List<WNode> wayPlist = NavSys.NavPath;

    for(int i = 1; i < wayPlist.length; i++){
      canvas.drawLine(
          Offset(wayPlist[i-1].position.width, wayPlist[i-1].position.height), Offset(wayPlist[i].position.width, wayPlist[i].position.height),
          paint..color = Colors.blue.shade800..strokeWidth = 35..strokeCap = StrokeCap.round
      );
    }
    for(int i = 1; i < wayPlist.length; i++){
      canvas.drawLine(
          Offset(wayPlist[i-1].position.width, wayPlist[i-1].position.height), Offset(wayPlist[i].position.width, wayPlist[i].position.height),
          paint..color = Colors.blue.shade300..strokeWidth = 25..strokeCap = StrokeCap.round
      );
    }

    // User Location markeer
    canvas.drawCircle(Offset(wayPlist[0].position.width, wayPlist[0].position.height), 40, paint..color = Colors.grey.shade700);
    canvas.drawCircle(Offset(wayPlist[0].position.width, wayPlist[0].position.height), 32, paint..color = Colors.grey.shade400);

    // Product Location Marker
    canvas.drawCircle(Offset(wayPlist[wayPlist.length-1].position.width, wayPlist[wayPlist.length-1].position.height), 40, paint..color = Colors.grey.shade800);
    canvas.drawCircle(Offset(wayPlist[wayPlist.length-1].position.width, wayPlist[wayPlist.length-1].position.height), 32, paint..color = Colors.grey.shade100);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ElevatedButton(onPressed: (){
// NavPoint.GetNavNeighbors();
// NavSys.FindPathFromMultiple(NavPoint.w30, [NavPoint.w20,NavPoint.w1, NavPoint.w39]);
// }, child: Text("Get Neighbors")),