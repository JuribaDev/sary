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

  @HiveField(6)
  final String transName;

  @HiveField(6)
  final DateTime createdAT;

  TransactionModel(
      {required this.id,
      required this.type,
      required this.itemId,
      required this.quantity,
      required this.inboundAt,
      required this.outboundAt,
      required this.transName,
      required this.createdAT,
      });


    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "itemId": itemId,
        "quantity": quantity,
        "inbound_at": inboundAt,
        "outbound_at": outboundAt,
        "trans_name": transName,
        "created_at": transName,
      };
}
/*
 "id": 1,
      "type": "inbound",
      "itemId": 2,
      "quantity": 45,
      "inbound_at": "2012-02-27 11:00:00",
      "outbound_at": "2012-02-27 13:27:00"


// */ 