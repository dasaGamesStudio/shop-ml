import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethelper/components/shoplistcard.dart';

class KartPage extends StatefulWidget {
  const KartPage({Key? key}) : super(key: key);

  @override
  State<KartPage> createState() => _KartPageState();
}

class _KartPageState extends State<KartPage> {
  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    double refLength =
        (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.03;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    List<String> shopList = ["carrot", "Macaroni", "Cheese", "Cake", "Eggs"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        leading: Icon(
          CupertinoIcons.back,
          size: fontSize * 1.6,
          color: Colors.white,
        ),
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white, fontSize: fontSize * 1.6),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.shopping_cart,
              size: fontSize * 1.6,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Show Best Route",
        onPressed: () {
          // go to map view
        },
        child: Icon(
          Icons.my_location,
          size: fontSize * 1.6,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingVal * 0.8),
        child: Column(
          children: [
            SizedBox(
              width: scSize.width,
              height: refLength * 0.16,
              child: ElevatedButton(onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                      side: BorderSide(

                      )
                    ))
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingVal),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Search Products", style: GoogleFonts.itim(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold, color: Colors.grey[500]),),
                        Icon(CupertinoIcons.add, size: fontSize * 2,)
                      ],
                    ),
                  )),
            ),
            SizedBox(
              height: paddingVal * 1.5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shopList.length,
                itemBuilder: (context, index) {
                  return UserItemTile(
                    itemName: shopList[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
