import 'dart:convert';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:markethelper/mypackages/mathdgs.dart';
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
                        foregroundPainter: MapRoutePainter(image!, mapRes: Size(40,28)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: ()=> NavPoint.GetNavNeighbors(), child: Text("Get Neighbors")),
          ]),
    );
  }
}

class MapRoutePainter extends CustomPainter {
  final ui.Image image;
  final Size mapRes;

  const MapRoutePainter(this.image, {this.mapRes = Size.zero});

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final paint = Paint()
      ..color = Colors.red;
    canvas.drawImage(image, Offset.zero, paint);

    final List<WNode> list = NavPoint.NavPList;

    list.forEach((element) {
      canvas.drawCircle(Offset(element.position.width, element.position.height), 20, paint);
    });

    NavPoint.w27.neighbors.forEach((element) {
      canvas.drawCircle(Offset(element.position.width, element.position.height), 25, paint..color =Colors.green);
    });

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

