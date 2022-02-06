import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/modules/item/controller/item_controller.dart';
import 'package:sary/app/modules/item/model/item_model.dart';
import 'package:sary/app/modules/item/view/item_shared_widget.dart';
import 'package:uuid/uuid.dart';

class ItemFormView extends StatefulWidget {
  bool isUpdate = false;
  String? itemId;
  ItemFormView({Key? key, required this.isUpdate, this.itemId})
      : super(key: key);

  @override
  State<ItemFormView> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ItemModel? itemModel;
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var skuController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    // widget.isUpdate ? itemModel =  Provider.of<ItemController>(context,listen: false)
    //     .getSingelItem(itemId: widget.itemId) as ItemModel  : null;
    nameController = TextEditingController();
    priceController = TextEditingController();
    skuController = TextEditingController();
    descriptionController = TextEditingController();
    if (widget.isUpdate) {
      Provider.of<ItemController>(context, listen: false)
          .getSingelItem(itemId: widget.itemId)
          .then((_) {
        ItemModel itemModel =
            Provider.of<ItemController>(context, listen: false).itemModel;
        nameController = TextEditingController(text: itemModel.name);
        priceController = TextEditingController(text: itemModel.price);
        skuController = TextEditingController(text: itemModel.sku);
        descriptionController =
            TextEditingController(text: itemModel.description);
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    skuController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
      builder: (context, cart, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: SharedWidget.appBar(
                title: widget.isUpdate ? 'Update Item' : 'Add Item'),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Column(
                      children: [
                        SharedWidget.box(0, 80.h),
                        ItemSharedWidget.textForm(
                          controller: nameController,
                          labelText: 'Name',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the name";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            nameController.text = val;
                          },
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 10.h),
                        ItemSharedWidget.textForm(
                          controller: priceController,
                          labelText: 'Price',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the price";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            priceController.text = val;
                          },
                          textInputType: TextInputType.number,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 10.h),
                        ItemSharedWidget.textForm(
                          controller: skuController,
                          labelText: 'SKU',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the SKU";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            skuController.text = val;
                          },
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 10.h),
                        ItemSharedWidget.textForm(
                          controller: descriptionController,
                          labelText: 'Description',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the Description";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            descriptionController.text = val;
                          },
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 30.h),
                        ItemSharedWidget.button(
                            buttonLabel:
                                widget.isUpdate ? 'Update Item' : 'Add Item',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                var uuid = const Uuid();
                                if (widget.isUpdate) {
                                  Provider.of<ItemController>(context,
                                          listen: false)
                                      .updateItem(
                                          itemId: widget.itemId!,
                                          itemModel: ItemModel(
                                              id: widget.itemId!,
                                              name: nameController.text,
                                              price: priceController.text,
                                              sku: skuController.text,
                                              description:
                                                  descriptionController.text));
                                } else {
                                  Provider.of<ItemController>(context,
                                          listen: false)
                                      .addItem(
                                          item: ItemModel(
                                              id: uuid.v1(),
                                              name: nameController.text,
                                              price: priceController.text,
                                              sku: skuController.text,
                                              description:
                                                  descriptionController.text));
                                }
                              }

                              nameController.clear();
                              priceController.clear();
                              skuController.clear();
                              descriptionController.clear();
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
