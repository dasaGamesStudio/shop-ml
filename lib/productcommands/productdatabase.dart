import 'package:cloud_firestore/cloud_firestore.dart';
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

Future CreateAUserProductList(String userID, Item item) async {
  final userProductList;
  userProductList = FirebaseFirestore.instance.collection("UserProDuctList").doc(userID);

  await userProductList.add(item.toJson());
}



