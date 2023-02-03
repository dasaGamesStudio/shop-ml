import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:markethelper/services/authservice.dart';
import '../models/cart_item_model.dart';
import '../models/item_model.dart';

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

Future AddUserCartToServer(List<CartItem> cartItems) async{
  print("Adding Cart Items");
  final products = await FirebaseFirestore.instance.collection("UserProDuctList").doc(AuthService.uid);
  cartItems.forEach((element) {
    products.collection("cartItems").add(element.toJson());
  });
}




