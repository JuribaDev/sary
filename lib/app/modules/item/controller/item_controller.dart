import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:sary/app/common/native_plugn/custom_toast_message.dart';
import 'package:sary/app/modules/item/model/item_model.dart';
import 'package:sary/app/modules/item/service/item_service.dart';

class ItemController with ChangeNotifier {
  List<ItemModel> items = [];
  late ItemModel itemModel;
  bool isLoading = false;

  //get items
  getItems() async {
    isLoading = true;
    items.clear();
    var res = await ItemService.getItems();
    res.fold((items) {
      this.items = items;
      isLoading = false;
      // log(items.toString());
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //add item
  addItem({required ItemModel item}) async {
    isLoading = true;
    var res = await ItemService.addItem(itemModel: item);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      isLoading = false;
      getItems();
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //delete item
  Future<bool?> deleteItem({required String itemId}) async {
    isLoading = true;
    var res = await ItemService.deleteItem(itemId: itemId);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getItems();
      isLoading = false;
      return true;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
      return false;
    });
    notifyListeners();
    isLoading = false;
    return null;
  }

  //update item
  updateItem({required String itemId, required ItemModel itemModel}) async {
    isLoading = true;
    var res =
        await ItemService.updateItem(itemId: itemId, itemModel: itemModel);
    res.fold((succes) {
      SaryToastMessage.showToast(message: succes);
      getItems();
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }

  //update item
  getSingelItem({String? itemId}) async {
    isLoading = true;
    var res = await ItemService.getSingelItem(itemId: itemId!);
    res.fold((item) {
      itemModel = item;
      isLoading = false;
    }, (error) {
      SaryToastMessage.showToast(message: error.message);
      isLoading = false;
    });
    isLoading = false;
    notifyListeners();
  }
}
