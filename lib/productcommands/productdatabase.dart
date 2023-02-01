import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:markethelper/models/storeItemPlacement_model.dart';

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

Future<List<Iterable<ItemPlacement>>> GetItemsPlacements() =>
    FirebaseFirestore.instance
        .collection("store")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ItemPlacement.fromJson(doc.data())))
        .toList();

Future<List<Iterable<Item>>> GetProducts() =>
    FirebaseFirestore.instance
        .collection("products")
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Item.fromJson(doc.data())))
        .toList();

// Future getShelfIDs() async {
//   await FirebaseFirestore.instance.collection("store").doc("LSwDV9Dta4Q7LqoGEjEj").snapshots().forEach((element) {
//     Map<String, dynamic> data = element.data() as Map<String, dynamic>;
//     //print(data['shelfIDs']);
//     return data['shelfIDs'];
//   });
//
// }
//
// Future getSectionIDs() async {
//   await FirebaseFirestore.instance.collection("store").doc("LSwDV9Dta4Q7LqoGEjEj").snapshots().forEach((element) {
//     Map<String, dynamic> data = element.data() as Map<String, dynamic>;
//     return data['sectionIDs'];
//   });
// }
//
// Future getFloorIDs() async {
//   await FirebaseFirestore.instance.collection("store").doc("LSwDV9Dta4Q7LqoGEjEj").snapshots().forEach((element) {
//     Map<String, dynamic> data = element.data() as Map<String, dynamic>;
//     return data['floorIDs'];
//   });
// }
//
// Future<ItemPlacement> getPlacements(String storeID) async {
//   var ip;
//   await FirebaseFirestore.instance.collection("store").doc(storeID).snapshots().forEach((element) {
//     Map<String, dynamic> data = element.data() as Map<String, dynamic>;
//     ip = ItemPlacement(storeName: data["storeName"], shelfIDs: data['shelfIDs'] as List<String>, sectionIDs: data['sectionIDs'] as List<String>, floorIDs: data['floorIDs'] as List<String>);
//   });
//   return ip;
// }
