import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:sary/app/common/exception/failure.dart';
import 'package:sary/app/common/util/date_time_format.dart';
import 'package:sary/app/modules/transaction/model/transaction_model.dart';

class TransactionService {
  static Future<Either<String, CacheFailure>> addTransaction(
      {required TransactionModel transactionModel}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      trans.add(TransactionModel(
        id: transactionModel.id,
        type: transactionModel.type,
        itemId: transactionModel.itemId,
        quantity: transactionModel.quantity,
        inboundAt: transactionModel.inboundAt,
        outboundAt: transactionModel.outboundAt,
        transName: transactionModel.transName,
        createdAT: transactionModel.createdAT,
      ));
      return const Left('Transaction added successfully');
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<String, CacheFailure>> deleteTransaction(
      {required String transId}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      final deletedTrans =
          trans.values.firstWhere((trans) => trans.id == transId);
      deletedTrans.delete();
      return const Left('Transaction deleted successfully');
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<String, CacheFailure>> updateTransaction(
      {required String transId,
      required TransactionModel transactionModel}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      final updatedTrans =
          trans.values.firstWhere((trans) => trans.id == transId);
      final index = updatedTrans.key as int;
      trans.put(
        index,
        TransactionModel(
          id: transactionModel.id,
          type: transactionModel.type,
          itemId: transactionModel.itemId,
          quantity: transactionModel.quantity,
          inboundAt: transactionModel.inboundAt,
          outboundAt: transactionModel.outboundAt,
          transName: transactionModel.transName,
          createdAT: transactionModel.createdAT,
        ),
      );
      return const Left('Transaction updated successfully');
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<TransactionModel, CacheFailure>> getSingelTransaction(
      {required String transId}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      TransactionModel getTrans =
          trans.values.firstWhere((trans) => trans.id == transId);
      log('service = ' + getTrans.id.toString());
      return Left(getTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<TransactionModel>, CacheFailure>> getTransactions(
      {required String itemId}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      List<TransactionModel> getTrans =
          trans.values.where((trans) => trans.itemId == itemId).toList();
      return Left(getTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<TransactionModel>, CacheFailure>> searchByName(
      {required String itemId, required String transName}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      List<TransactionModel> getTrans = trans.values
          .where((trans) =>
              trans.itemId == itemId && trans.transName.toLowerCase().contains(transName.toLowerCase()))
          .toList();

      return Left(getTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<TransactionModel>, CacheFailure>>
      filterByTansactionQuantity(
          {required String itemId,
          required String from,
          required String to}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      List<TransactionModel> getTrans =
          trans.values.where((trans) => trans.itemId == itemId).toList();
      List<TransactionModel> filteredTrans = [];

      for (var trans in getTrans) {
        double quantity = double.parse(trans.quantity.toString());
        double quantityFrom = double.parse(from);
        double quantityTo = double.parse(to);
        if (quantity >= quantityFrom && quantity <= quantityTo) {
          filteredTrans.add(trans);
        }
      }

      return Left(filteredTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<TransactionModel>, CacheFailure>>
      filterByTansactionCreatedAt(
          {required String itemId,
          required DateTime from,
          required DateTime to}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      List<TransactionModel> getTrans = trans.values
          .where(
            (trans) =>
                trans.itemId == itemId 
          )
          .toList();
      List<TransactionModel> filteredTrans = [];

      for (var trans in getTrans) {
        if (trans.createdAT.isAfter(from) &&
            trans.createdAT.isBefore(to)) {
          filteredTrans.add(trans);
        }
      }

      return Left(filteredTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<TransactionModel>, CacheFailure>>
      filterByTransactionType(
          {required String itemId, required String transType}) async {
    try {
      Box<TransactionModel> trans = await openBox();
      List<TransactionModel> getTrans = trans.values
          .where((trans) =>
              trans.itemId == itemId && trans.type.contains(transType))
          .toList();

      return Left(getTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Box<TransactionModel>> openBox() async {
    Box<TransactionModel> trans =
        await Hive.openBox<TransactionModel>('transactions');
    return trans;
  }
}
