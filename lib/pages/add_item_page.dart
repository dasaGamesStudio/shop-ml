import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethelper/dropdowns.dart';
import 'package:markethelper/models/item_model.dart';
import 'package:markethelper/models/storeItemPlacement_model.dart';

import '../productcommands/productdatabase.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  @override
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  final TextEditingController shelfIDController = TextEditingController();
  final TextEditingController sectionIDController = TextEditingController();
  final TextEditingController floorIDController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    desController.dispose();
    stockController.dispose();
    shelfIDController.dispose();
    floorIDController.dispose();
    sectionIDController.dispose();
    super.dispose();
  }

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
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: fontSize * 1.5,
          color: Colors.white,
        ),
        title: Text(
          "Item Detail",
          style: GoogleFonts.fredokaOne(
              fontSize: fontSize * 2, color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingVal),
          child: Column(
            children: [
              SizedBox(
                height: paddingVal * 2,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(height: paddingVal),
              TextField(
                controller: idController,
                decoration: InputDecoration(
                    hintText: "Item ID",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(height: paddingVal),
              TextField(
                controller: desController,
                decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(
                height: paddingVal,
              ),
              TextField(
                controller: stockController,
                decoration: InputDecoration(
                    hintText: "Stock Amount",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(
                height: paddingVal,
              ),
              TextField(
                controller: shelfIDController,
                decoration: InputDecoration(
                    hintText: "Shelf ID",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(
                height: paddingVal,
              ),
              TextField(
                controller: sectionIDController,
                decoration: InputDecoration(
                    hintText: "Section ID",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(
                height: paddingVal,
              ),
              TextField(
                controller: floorIDController,
                decoration: InputDecoration(
                    hintText: "Floor ID",
                    hintStyle: GoogleFonts.roboto(
                      fontSize: fontSize,
                    )),
              ),
              SizedBox(
                height: paddingVal,
              ),
              SizedBox(
                height: paddingVal,
              ),
              SizedBox(
                height: paddingVal,
              ),
              ElevatedButton(
                  onPressed: () {
                    final product = Item(
                        name: nameController.text,
                        id: idController.text,
                        description: desController.text,
                        shelfID: shelfIDController.text,
                        floorID: floorIDController.text,
                        sectionID: sectionIDController.text,
                        stockAmount: int.parse(stockController.text));
                    CreateAProduct(item: product);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.all(paddingVal * 0.6))),
                  child: Text(
                    "Add Product",
                    style: TextStyle(
                        color: Colors.white, fontSize: fontSize * 1.5),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
