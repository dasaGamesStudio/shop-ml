import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markethelper/components/autocomplete.dart';
import 'package:markethelper/components/shoplistcard.dart';
import 'package:markethelper/models/cart_item_model.dart';
import 'package:markethelper/models/item_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Item> itemsInDb = <Item>[];
  List<CartItem> itemsInCart = <CartItem>[];

  _loadProducts() async {
    print("_laodProducts");
    QuerySnapshot data = await FirebaseFirestore.instance.collection("products").get();
    List<Item> items = <Item>[];

    data.docs.forEach((item){
      Map<String, dynamic> obj = item.data() as Map<String, dynamic>;
      Item i = Item.fromJson(obj);
      items.add(i);
    });

    if(mounted) {
      setState(() {
        itemsInDb = items;
      });
    }
  }

  addToCart(CartItem cartItem) {
    print("addToCart invoked with item " + cartItem.name);
    itemsInCart.add(cartItem);
    setState(() {
      itemsInCart = itemsInCart;
    });
  }

  @override
  void initState() {
    print("initState");
    _loadProducts();
  }

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
            // SizedBox(
            //   width: scSize.width,
            //   height: refLength * 0.16,
            //   child: ElevatedButton(onPressed: () {},
            //       style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
            //         padding: MaterialStateProperty.all(EdgeInsets.zero),
            //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(borderRadius),
            //           side: BorderSide(
            //
            //           )
            //         ))
            //       ),
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(horizontal: paddingVal),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("Search Products", style: GoogleFonts.itim(fontSize: fontSize * 1.5, fontWeight: FontWeight.bold, color: Colors.grey[500]),),
            //             Icon(CupertinoIcons.add, size: fontSize * 2,)
            //           ],
            //         ),
            //       )),
            // ),
            AutocompleteWidget(itemList: itemsInDb, addToCart: addToCart,),
            SizedBox(
              height: paddingVal * 1.5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemsInCart.length,
                itemBuilder: (context, index) {
                  return UserItemTile(
                    itemName: itemsInCart[index].name,
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
