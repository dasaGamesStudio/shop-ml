class Item {
  String name;
  String id;
  String description;
  //List<String> tags;
  String shelfID;
  String floorID;
  int stockAmount;
  String sectionID;

  Item({
    required this.name,
    required this.id,
    required this.description,
    //required this.tags,
    required this.shelfID,
    required this.floorID,
    required this.sectionID,
    required this.stockAmount,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'description': description,
    //'tags': tags,
    'shelfID': shelfID,
    'floorID': floorID,
    'sectionID': sectionID,
    'stockAmount': stockAmount,
  };

  static Item fromJson(Map<String, dynamic> json) => Item(
    name: json['name'],
    id: json['id'],
    description: json['description'],
    shelfID: json['shelfID'],
    sectionID: json['sectionID'],
    floorID: json['floorID'],
    stockAmount: json['stockAmount']
  );
}
