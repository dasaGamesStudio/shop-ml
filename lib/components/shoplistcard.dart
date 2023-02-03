import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethelper/models/item_model.dart';

import '../models/cart_item_model.dart';


class UserItemTile extends StatelessWidget {
  final CartItem cartItem;
  final Function()? onDeleting;
  const UserItemTile({
    Key? key,
    required this.cartItem,
    required this.onDeleting,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size scSize = MediaQuery.of(context).size;
    double refLength = (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.03;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    return Padding(
      padding: EdgeInsets.only(bottom: paddingVal * 0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          color: Colors.amber[200],
          child: Padding(
            padding: EdgeInsets.only(left: paddingVal),
            child: ClipRRect(
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(paddingVal*1.5),
                  child: Container(
                    width: scSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItem.name, style: GoogleFonts.itim(
                            fontSize: fontSize * 1.5,
                            fontWeight: FontWeight.bold
                        ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        IconButton(onPressed: onDeleting, icon: Icon(CupertinoIcons.delete, size: fontSize * 1.5,))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ProductItemTile extends StatelessWidget {

  late Item item;
  final Function? onAddCart;

  ProductItemTile({Key? key, required this.item,
    this.onAddCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    double refLength = (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.03;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    return Padding(
      padding: EdgeInsets.only(bottom: paddingVal * 1, left: paddingVal, right: paddingVal),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          color: Colors.amber[200],
          child: Padding(
            padding: EdgeInsets.only(left: paddingVal),
            child: ClipRRect(
              child: Container(
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: ((context){
                          //add item to list
                          onAddCart!();
                        }),
                        backgroundColor: Colors.green,
                        icon: CupertinoIcons.shopping_cart,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(paddingVal*1.5),
                    child: Container(
                      width: scSize.width,
                      child: Text(item.name, style: GoogleFonts.itim(
                          fontSize: fontSize * 1.5,
                          fontWeight: FontWeight.bold
                      ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

