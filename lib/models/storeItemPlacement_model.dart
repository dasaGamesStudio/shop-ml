class ItemPlacement{
  String storeName;
  List<String> shelfIDs;
  List<String> sectionIDs;
  List<String> floorIDs;

  ItemPlacement({required this.storeName, required this.shelfIDs, required this.sectionIDs, required this.floorIDs});

  Map<String,dynamic> toJson() => {
    'storeName': storeName,
    'shelfIDs' : shelfIDs,
    'sectionIDs': sectionIDs,
    'floorIDs': floorIDs,
  };

  static ItemPlacement fromJson(Map<String, dynamic> json) => ItemPlacement(
      storeName: json['StoreName'], shelfIDs: json['ShelfIDs'], sectionIDs: json['SectionIDs'], floorIDs: json['FloorIDs']);
}