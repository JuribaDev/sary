import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:sary/app/common/exception/failure.dart';
import 'package:sary/app/common/native_plugn/custom_toast_message.dart';
import 'package:sary/app/modules/item/model/item_model.dart';
import 'package:sary/app/modules/item/service/item_service.dart';

class ItemController with ChangeNotifier {
  List<ItemModel> items = [];
  late ItemModel itemModel;

  //close item box
  static closeItemBox() {
    Hive.box('items').close();
  }

  //get items
  getItems() async {
    items.clear();
    var res = await ItemService.getItems();
    res.fold((items) {
      this.items = items;
      // log(items.toString());
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }

  //add item
  addItem({required ItemModel item}) async {
    var res = await ItemService.addItem(itemModel: item);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getItems();
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }

  //delete item
  Future<bool?> deleteItem({required String itemId}) async {
    var res = await ItemService.deleteItem(itemId: itemId);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getItems();
      return true;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      return false;
    });
    notifyListeners();
    return null;
  }

  //update item
  updateItem({required String itemId, required ItemModel itemModel}) async {
    var res =
        await ItemService.updateItem(itemId: itemId, itemModel: itemModel);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getItems();
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }

  //update item
  getSingelItem({String? itemId}) async {
    var res = await ItemService.getSingelItem(itemId: itemId!);
    res.fold((item) {
      itemModel = item;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
    });
    notifyListeners();
  }
}
