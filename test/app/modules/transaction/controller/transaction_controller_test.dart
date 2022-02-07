import 'package:flutter_test/flutter_test.dart';
import 'package:sary/app/modules/transaction/controller/transaction_controller.dart';
import 'package:sary/app/modules/transaction/model/transaction_model.dart';

void main() {
  group("CRUD Transactions", () {
    TransactionModel transactionModel;
    TransactionController controller = TransactionController();
    test(" add transacion  ", () {
      transactionModel = TransactionModel(
          id: '1',
          itemId: '1',
          transName: 'jbn',
          quantity: '22',
          createdAT: DateTime.now(),
          inboundAt: DateTime.now().toString(),
          outboundAt: DateTime.now().toString(),
          type: 'moz');
      String itemId = '1';

      controller.addTransaction(trans: transactionModel, itemId: itemId);
      expect(controller.transactions.first.id, '2');
    });
  });
}
