class CartItem {
  String? id;
  String name;
  String shelfID;
  String sectionID;

  CartItem({
    required this.id, required this.name, required this.shelfID, required this.sectionID
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'shelfID': shelfID,
    'sectionID':sectionID
  };

  static CartItem fromJson(Map<String, dynamic> json) => CartItem(
      name: json['name'],
      id: json['id'],
      shelfID: json['shelfID'],
      sectionID: json['sectionID']
  );

}