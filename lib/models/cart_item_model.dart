class CartItem {
  String id;
  String name;
  String shelfID;

  CartItem({
    required this.id, required this.name, required this.shelfID
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'shelfID': shelfID,
  };

  static CartItem fromJson(Map<String, dynamic> json) => CartItem(
      name: json['name'],
      id: json['id'],
      shelfID: json['shelfID'],
  );
}