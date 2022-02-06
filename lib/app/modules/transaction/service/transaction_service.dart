import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:sary/app/common/exception/failure.dart';
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
          outboundAt: transactionModel.outboundAt));
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
            outboundAt: transactionModel.outboundAt),
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
      // log('service = ' + getItem.name);
      return Left(getTrans);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<TransactionModel>, CacheFailure>>
      getTransactions() async {
    try {
      Box<TransactionModel> trans = await openBox();
      return Left(trans.values.toList());
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
