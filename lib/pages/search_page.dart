import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:markethelper/components/shoplistcard.dart';
import 'package:markethelper/models/item_model.dart';
import 'package:markethelper/productcommands/productdatabase.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size scSize = MediaQuery.of(context).size;
    double refLength =
        (scSize.width > scSize.height) ? scSize.height : scSize.width;
    double paddingVal = refLength * 0.05;
    double fontSize = refLength * 0.04;
    double borderRadius = refLength * 0.02;

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("products").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final Item item = Item(
                        name: snapshot.data?.docs[index]['name'],
                        id: snapshot.data?.docs[index]['id'],
                        description: snapshot.data?.docs[index]['description'],
                        shelfID: snapshot.data?.docs[index]['shelfID'],
                        floorID: snapshot.data?.docs[index]['floorID'],
                        sectionID: snapshot.data?.docs[index]['sectionID'],
                        stockAmount: snapshot.data?.docs[index]['stockAmount']);
                    return (index == 0)? Padding(
                      padding: EdgeInsets.only(top: paddingVal),
                      child: ProductItemTile(
                        item: item,
                      ),
                    ) : ProductItemTile(item: item);
                  });
            } else {
              return Text("No Data");
            }
          }),
    );
  }
}

Widget buildItemProduct(Item item) => ListTile(
      title: Text(item.name),
    );
