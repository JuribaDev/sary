import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String itemId;

  @HiveField(3)
  final String quantity;

  @HiveField(4)
  final String inboundAt;

  @HiveField(5)
  final String outboundAt;

  TransactionModel(
      {required this.id,
      required this.type,
      required this.itemId,
      required this.quantity,
      required this.inboundAt,
      required this.outboundAt});
}
/*
 "id": 1,
      "type": "inbound",
      "itemId": 2,
      "quantity": 45,
      "inbound_at": "2012-02-27 11:00:00",
      "outbound_at": "2012-02-27 13:27:00"


// */ 