import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/modules/item/controller/item_controller.dart';
import 'package:sary/app/modules/item/model/item_model.dart';
import 'package:sary/app/modules/transaction/controller/transaction_controller.dart';
import 'package:sary/app/modules/transaction/model/transaction_model.dart';
import 'package:uuid/uuid.dart';

class TransactionFormView extends StatefulWidget {
  bool isUpdate = false;
  String? transId;
  String? itemId;
  TransactionFormView({Key? key, required this.isUpdate, this.transId})
      : super(key: key);

  @override
  State<TransactionFormView> createState() => _ItemFormState();
}

class _ItemFormState extends State<TransactionFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ItemModel? itemModel;
  var typeController = TextEditingController();
  var quantityController = TextEditingController();
  var inboundAtController = TextEditingController();
  var outboundAtController = TextEditingController();

  @override
  void initState() {
    // widget.isUpdate ? itemModel =  Provider.of<ItemController>(context,listen: false)
    //     .getSingelItem(itemId: widget.itemId) as ItemModel  : null;
    typeController = TextEditingController();
    quantityController = TextEditingController();
    inboundAtController = TextEditingController();
    outboundAtController = TextEditingController();
    if (widget.isUpdate) {
      Provider.of<ItemController>(context, listen: false)
          .getSingelItem(itemId: widget.transId)
          .then((_) {
        TransactionModel transactionModel =
            Provider.of<TransactionController>(context, listen: false)
                .transactionModel;
        typeController = TextEditingController(text: transactionModel.type);
        quantityController =
            TextEditingController(text: transactionModel.quantity);
        inboundAtController =
            TextEditingController(text: transactionModel.inboundAt.toString());
        outboundAtController =
            TextEditingController(text: transactionModel.outboundAt.toString());
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    typeController.dispose();
    quantityController.dispose();
    inboundAtController.dispose();
    outboundAtController.dispose();
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
                        SharedWidget.box(0, 40.h),
                        //
                        SharedWidget.box(0, 10.h),

                        //
                        SharedWidget.box(0, 10.h),
                        //
                        SharedWidget.box(0, 10.h),
                        SharedWidget.textForm(
                          controller: quantityController,
                          labelText: 'Quantity',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the Quantity";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            quantityController.text = val;
                          },
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 30.h),
                        SharedWidget.button(
                            buttonLabel:
                                widget.isUpdate ? 'Update Item' : 'Add Item',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                var uuid = const Uuid();
                                if (widget.isUpdate) {
                                  Provider.of<TransactionController>(context,
                                          listen: false)
                                      .updateTransaction(
                                          transId: widget.transId!,
                                          trans: TransactionModel(
                                              id: widget.transId!,
                                              type: typeController.text,
                                              itemId: widget.itemId!,
                                              quantity: quantityController.text,
                                              inboundAt:
                                                  inboundAtController.text,
                                              outboundAt:
                                                  outboundAtController.text));
                                } else {
                                  Provider.of<TransactionController>(context,
                                          listen: false)
                                      .addTransaction(
                                          trans: TransactionModel(
                                              id: uuid.v1(),
                                              type: typeController.text,
                                              itemId: widget.itemId!,
                                              quantity: quantityController.text,
                                              inboundAt:
                                                  inboundAtController.text,
                                              outboundAt:
                                                  outboundAtController.text));
                                }
                                Navigator.pop(context);
                                typeController.clear();
                                quantityController.clear();
                                inboundAtController.clear();
                                outboundAtController.clear();
                              }
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
