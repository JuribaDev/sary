import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:sary/app/common/exception/failure.dart';
import 'package:sary/app/modules/item/model/item_model.dart';

class ItemService {
  static Future<Either<String, CacheFailure>> addItem(
      {required ItemModel itemModel}) async {
    try {
      Box<ItemModel> item = await openBox();
      item.add(ItemModel(
          id: itemModel.id,
          name: itemModel.name,
          price: itemModel.price,
          sku: itemModel.sku,
          description: itemModel.description));
      return const Left('Item added successfully');
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<String, CacheFailure>> deleteItem(
      {required String itemId}) async {
    try {
      Box<ItemModel> item = await openBox();
      final deletedItem = item.values.firstWhere((item) => item.id == itemId);
      deletedItem.delete();
      return const Left('Item deleted successfully');
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<String, CacheFailure>> updateItem(
      {required String itemId, required ItemModel itemModel}) async {
    try {
      Box<ItemModel> item = await openBox();
      final updatedItem = item.values.firstWhere((item) => item.id == itemId);
      final index = updatedItem.key as int;
      item.put(
        index,
        ItemModel(
            id: itemModel.id,
            name: itemModel.name,
            price: itemModel.price,
            sku: itemModel.sku,
            description: itemModel.description),
      );
      return const Left('Item updated successfully');
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<ItemModel, CacheFailure>> getSingelItem(
      {required String itemId}) async {
    try {
      Box<ItemModel> item = await openBox();
      ItemModel getItem = item.values.firstWhere((item) => item.id == itemId);
      log('service = ' + getItem.name);
      return Left(getItem);
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Either<List<ItemModel>, CacheFailure>> getItems() async {
    try {
      Box<ItemModel> item = await openBox();
      return Left(item.values.toList());
    } catch (e) {
      return Right(CacheFailure(message: 'Error'));
    }
  }

  static Future<Box<ItemModel>> openBox() async {
    Box<ItemModel> item = await Hive.openBox<ItemModel>('items');
    return item;
  }
}
