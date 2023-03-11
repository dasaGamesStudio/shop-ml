import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return Scaffold(
      backgroundColor: Colors.black,
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
            ElevatedButton(onPressed: (){
              NavPoint.GetNavNeighbors();
              NavSys.FindPath(NavPoint.w30, NavPoint.w8);
            }, child: Text("Get Neighbors")),
          ]),
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

    final List<WNode> list = NavSys.NavPath;

    // list.forEach((element) {
    //   canvas.drawCircle(Offset(element.position.width, element.position.height), 15, paint);
    // });

    for(int i = 1; i < list.length; i++){
      canvas.drawLine(
          Offset(list[i-1].position.width, list[i-1].position.height), Offset(list[i].position.width, list[i].position.height),
          paint..color = Colors.green..strokeWidth = 30..strokeCap = StrokeCap.round
      );
    }
    canvas.drawCircle(Offset(list[0].position.width, list[0].position.height), 40, paint..color = Colors.blue);
    canvas.drawCircle(Offset(list[list.length-1].position.width, list[list.length-1].position.height), 40, paint..color = Colors.green);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

