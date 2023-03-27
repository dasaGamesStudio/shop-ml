import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markethelper/appfunctions/productdatabase.dart';
import 'package:markethelper/components/autocomplete.dart';
import 'package:markethelper/components/shoplistcard.dart';
import 'package:markethelper/models/cart_item_model.dart';
import 'package:markethelper/models/item_model.dart';
import 'package:markethelper/navigationSystem/navalgo.dart';
import 'package:markethelper/navigationSystem/navpoints.dart';
import 'package:markethelper/pages/drawmap_page.dart';
import 'package:markethelper/pages/take_shelf_image.dart';
import 'package:markethelper/services/authservice.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Item> itemsInDb = <Item>[];

  _loadProducts() async {
    print("_laodProducts");
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("products").get();
    List<Item> items = <Item>[];

    data.docs.forEach((item) {
      Map<String, dynamic> obj = item.data() as Map<String, dynamic>;
      Item i = Item.fromJson(obj);
      items.add(i);
    });

    if (mounted) {
      setState(() {
        itemsInDb = items;
      });
    }
  }

  addToCart(CartItem cartItem) {
    print("addToCart invoked with item " + cartItem.name!);
    AddCartItemToCart(cartItem);
  }

  // getItemsInCartFDatabase() async {
  //   print("getitems in cart database");
  //   QuerySnapshot data =
  //       await FirebaseFirestore.instance.collection("userplist").get();
  //   List<CartItem> items = <CartItem>[];
  //   print(data.size);
  //   // data.docs.forEach((item){
  //   //   Map<String, dynamic> obj = item.data() as Map<String, dynamic>;
  //   //   CartItem i = CartItem.fromJson(obj);
  //   //   items.add(i);
  //   // });
  //   //
  //   //
  //   // if(mounted) {
  //   //   setState(() {
  //   //     itemsInCart = items;
  //   //   });
  //   // }
  // }

  deleteItemFromCart(CartItem cartItem) {
    print("Deleting Happen");
    DeleteItemFromCart(cartItem);
  }


  @override
  void initState() {
    print("initState");
    _loadProducts();
    //getItemsInCartFDatabase();
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
        title: Text(
          "Shopping Cart",
          style: TextStyle(color: Colors.white, fontSize: fontSize * 1.6),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Show Best Route",
        onPressed: () {
          // go to camera view
          Navigator.push(context,
              //MaterialPageRoute(builder: (context) => const TakeShelfImage()));
              MaterialPageRoute(builder: (context) => MapPage()));
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
            AutocompleteWidget(
              itemList: itemsInDb,
              addToCart: addToCart,
            ),
            SizedBox(
              height: paddingVal * 1.5,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("UserCart")
                      .doc(AuthService.uid)
                      .collection("cartItems")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        if(snapshot.data == null) return CircularProgressIndicator();
                        final CartItem item = CartItem(
                            id: snapshot.data?.docs[index].id,
                            name: snapshot.data?.docs[index]['name']!,
                            shelfID: snapshot.data?.docs[index]['shelfID']!,
                            sectionID: snapshot.data?.docs[index]['sectionID']!,
                        );
                        return UserItemTile(
                          cartItem: item,
                          onDeleting: () {
                            //print("pressed");
                            deleteItemFromCart(item);
                          },
                        );
                      },
                    );
                  }),
            ),
            ElevatedButton(onPressed: ()=> AuthService().SignOut(), child: Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
