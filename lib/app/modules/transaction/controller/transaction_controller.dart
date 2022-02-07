import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sary/app/common/native_plugn/custom_toast_message.dart';

import 'package:sary/app/modules/transaction/model/transaction_model.dart';
import 'package:sary/app/modules/transaction/service/transaction_service.dart';

class TransactionController with ChangeNotifier {
  List<TransactionModel> transactions = [];
  late TransactionModel transactionModel;
  bool isLoading = false;

  //get trans
  getTransactions({required String itemId}) async {
    isLoading = true;
    transactions.clear();
    var res = await TransactionService.getTransactions(itemId: itemId);
    res.fold((transactions) {
      this.transactions = transactions;
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //add trans
  addTransaction(
      {required TransactionModel trans, required String itemId}) async {
    isLoading = true;

    var res = await TransactionService.addTransaction(transactionModel: trans);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getTransactions(itemId: itemId);
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;

    notifyListeners();
  }

  //delete trans
  Future<bool?> deleteTransaction(
      {required String transId, required String itemId}) async {
    var res = await TransactionService.deleteTransaction(transId: transId);
    res.fold((succes) {
      isLoading = true;
      SaryToastMessage.showToast(message: succes);
      getTransactions(itemId: itemId);
      isLoading = false;
      return true;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
      return false;
    });
    isLoading = false;
    notifyListeners();
    return null;
  }

  //update trans
  updateTransaction(
      {required String transId,
      required TransactionModel trans,
      required String itemId}) async {
    isLoading = true;
    var res = await TransactionService.updateTransaction(
        transId: transId, transactionModel: trans);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getTransactions(itemId: itemId);
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //get singel trans
  getSingelTransaction({String? transId}) async {
    isLoading = true;
    var res = await TransactionService.getSingelTransaction(transId: transId!);
    res.fold((trans) {
      transactionModel = trans;
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //search by name
  searchByname({
    required String itemId,
    required String query,
  }) async {
    isLoading = true;
    transactions.clear();
    var res =
        await TransactionService.searchByName(itemId: itemId, transName: query);
    res.fold((transactions) {
      this.transactions = transactions;
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //filter by inbound or outbound
  filterByTansactionType(
      {required String itemId, required String transType}) async {
    isLoading = true;
    transactions.clear();
    var res = await TransactionService.filterByTransactionType(
        itemId: itemId, transType: transType);
    res.fold((transactions) {
      this.transactions = transactions;
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  searchOrFilter(
      {required OperationType operationType, String? query, String? itemId}) {
    switch (operationType) {
      case OperationType.search:
        searchByname(itemId: itemId!, query: query!);
        break;
      case OperationType.filterByQuantity:
        break;
      case OperationType.filterByCreatedAt:
        break;
      case OperationType.filterByInbound:
        filterByTansactionType(itemId: itemId!, transType: query!);
        break;
      case OperationType.filterByOutbound:
      filterByTansactionType(itemId: itemId!, transType: query!);
        break;
      default:
    }
  }
}

// search and filter operations
enum OperationType {
  search,
  filterByQuantity,
  filterByCreatedAt,
  filterByInbound,
  filterByOutbound,
}
