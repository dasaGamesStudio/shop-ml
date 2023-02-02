import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class ShowMapPage extends StatefulWidget {
  const ShowMapPage({Key? key}) : super(key: key);

  @override
  State<ShowMapPage> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<ShowMapPage> {
  @override
  Widget build(BuildContext context) {

    Size scSize = MediaQuery.of(context).size;
    double refLength =
    (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.05;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Item Detail",
            style: GoogleFonts.fredokaOne(
                fontSize: fontSize * 2, color: Colors.white),
          )
      ),
      body: PhotoView(
        imageProvider: NetworkImage("https://images.edrawsoft.com/articles/supermarket-plan-examples/example1.png"),
        backgroundDecoration: BoxDecoration(
          color: Colors.white
        ),
      ),
    );
  }
}
