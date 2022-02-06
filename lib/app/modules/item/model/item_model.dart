import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 1)
class ItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final String sku;

  @HiveField(4)
  final String description;

  ItemModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.sku,
      required this.description});

        Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "sku": sku,
        "description": description,
      };
}
/*
 {
      "id": 1,
      "name": "Barbican Beer Drink",
      "price": "92.61",
      "sku": "PRO-SA3",
      "description": "320 × 6 ml",
      "image": ""
    },


// */ 