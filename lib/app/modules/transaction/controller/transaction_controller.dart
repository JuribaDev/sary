
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sary/app/common/native_plugn/custom_toast_message.dart';

import 'package:sary/app/modules/transaction/model/transaction_model.dart';
import 'package:sary/app/modules/transaction/service/transaction_service.dart';

class TransactionController with ChangeNotifier {
  List<TransactionModel> transactions = [];
  late TransactionModel transactionModel;

  //close trans box
  static closeTransactionBox() {
    Hive.box('transactions').close();
  }

  //get trans
  getTransactions() async {
    transactions.clear();
    var res = await TransactionService.getTransactions();
    res.fold((transactions) {
      this.transactions = transactions;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }

  //add trans
  addTransaction({required TransactionModel trans}) async {
    var res = await TransactionService.addTransaction(transactionModel: trans);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getTransactions();
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }

  //delete trans
  Future<bool?> deleteTransaction({required String transId}) async {
    var res = await TransactionService.deleteTransaction(transId: transId);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getTransactions();
      return true;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      return false;
    });
    notifyListeners();
    return null;
  }

  //update trans
  updateTransaction({required String transId, required TransactionModel trans}) async {
    var res =
        await TransactionService.updateTransaction(transId: transId, transactionModel: trans);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getTransactions();
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }

  //update trans
  getSingelTransaction({String? transId}) async {
    var res = await TransactionService.getSingelTransaction(transId: transId!);
    res.fold((trans) {
      transactionModel = trans;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }
}
