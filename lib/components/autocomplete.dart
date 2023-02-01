import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethelper/models/cart_item_model.dart';

import '../models/item_model.dart';

class AutocompleteWidget extends StatelessWidget {
  final List<Item> itemList;
  final Function addToCart;

  AutocompleteWidget({Key? key, required this.itemList, required this.addToCart}) : super(key: key);
  static String _displayStringForOption(Item option) => option.name;
  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {

    Size scSize = MediaQuery.of(context).size;
    double refLength =
    (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.05;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    print(this.itemList.length);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: paddingVal * 0.6, right: paddingVal, bottom: paddingVal * 0.2,top: paddingVal * 0.3,),
        child: SizedBox(
          height: refLength * 0.09,
          child: Autocomplete<Item>(
            displayStringForOption: _displayStringForOption,
            optionsBuilder: (TextEditingValue textEditingValue) {
              if(textEditingValue.text == '') {
                return const Iterable<Item>.empty();
              }
              return itemList.where((Item i) {
                return i.name.toString().toLowerCase().contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (Item selectedItem) {
              print("item is selected " + selectedItem.name);
              // CartItem(id: selectedItem.id, name: selectedItem.name, shelfID: selectedItem.shelfID);
              addToCart(CartItem(id: selectedItem.id, name: selectedItem.name, shelfID: selectedItem.shelfID));
              textEditingController.text = "";
            },
            fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
              textEditingController = fieldTextEditingController;
              return TextField(

                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(top: paddingVal * 0.05),
                    child: Icon(CupertinoIcons.add, size: fontSize * 2,),
                  ),
                  border: InputBorder.none,

                ),

                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: GoogleFonts.itim(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
      ),
    );
  }
}
