import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:markethelper/navigationSystem/navalgo.dart';
import 'package:markethelper/navigationSystem/waypoint_model.dart';
import 'package:markethelper/services/authservice.dart';
import '../models/cart_item_model.dart';
import '../models/item_model.dart';

class CartMapData{
  static List<CartItem> cmItems = [];
  static List<CartItem> cItemsatPlace = [];

  static int tempCartLength = 0;

  static int GetCartLength(){
    return cmItems.length;
  }

  static GetModCartItemNames(){
    String names = "";
    cmItems.forEach((element) {
      if(element.shelfID+element.sectionID == NavSys.TargetNode.id){
        names += element.name +"\n";
      }
    });
    return names;
  }
  static GetCartItemsAtNode(String nodeID){
    cItemsatPlace.clear();
    cmItems.forEach((element) {
      if(element.shelfID+element.sectionID == NavSys.TargetNode.id){
        cItemsatPlace.add(element);
      }
    });
  }

}

Future CreateAProduct({required Item item}) async {
  final docProduct;
  if (item.id.isEmpty) {
    docProduct = FirebaseFirestore.instance.collection("products").doc();
    item.id = docProduct.id;
  } else {
    docProduct = FirebaseFirestore.instance.collection("products").doc(item.id);
  }
  await docProduct.set(item.toJson());
}

Future DeleteAProduct(String productID) async {
  final docProduct =
      FirebaseFirestore.instance.collection("products").doc(productID);
  await docProduct.delete();
}

Future AddUserCartToServer(List<CartItem> cartItems) async {
  print("Adding Cart Items");
  final products = await FirebaseFirestore.instance
      .collection("UserProDuctList")
      .doc(AuthService.uid);
  cartItems.forEach((element) {
    products.collection("cartItems").add(element.toJson());
  });
}

Future AddCartItemToCart(CartItem cartItem) async {
  CartMapData.tempCartLength +=1;
  final cart = await FirebaseFirestore.instance
      .collection("UserCart")
      .doc(AuthService.uid);
  cart.collection("cartItems").add(cartItem.toJson());
}



Future DeleteItemFromCart(CartItem item) async {
  CartMapData.cmItems.remove(item);
  CartMapData.tempCartLength -= 1;

  print("Deleting: ${item.id} from ${AuthService.uid} id");
  return await FirebaseFirestore.instance
      .collection("UserCart")
      .doc(AuthService.uid)
      .collection("cartItems").doc(item.id).delete();

}