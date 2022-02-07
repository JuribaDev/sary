import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sary/app/common/colors/light_theme_color.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/util/date_time_format.dart';

import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/modules/transaction/controller/transaction_controller.dart';
import 'package:sary/app/modules/transaction/model/transaction_model.dart';
import 'package:sary/app/modules/transaction/view/transaction_shared_widget.dart';
import 'package:uuid/uuid.dart';

class TransactionFormView extends StatefulWidget {
  bool isUpdate = false;
  String? transId;
  String itemId;
  TransactionFormView(
      {Key? key, required this.isUpdate, this.transId, required this.itemId})
      : super(key: key);

  @override
  State<TransactionFormView> createState() => _ItemFormState();
}

class _ItemFormState extends State<TransactionFormView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? dateTime;
  int _radioValue = 1;
  var typeController = TextEditingController();
  var tranNameController = TextEditingController();
  var quantityController = TextEditingController();
  var inboundAtController = TextEditingController();
  var outboundAtController = TextEditingController();

  @override
  void initState() {
    typeController = TextEditingController(text: 'Inbound');
    tranNameController = TextEditingController();
    quantityController = TextEditingController();
    inboundAtController = TextEditingController();
    outboundAtController = TextEditingController();
    if (widget.isUpdate) {
      Provider.of<TransactionController>(context, listen: false)
          .getSingelTransaction(transId: widget.transId)
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
        tranNameController.text = transactionModel.transName;
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
    return Consumer<TransactionController>(
      builder: (context, cart, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: SharedWidget.appBar(
                title:
                    widget.isUpdate ? 'Update Transaction' : 'Add Transaction'),
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Column(
                      children: [
                        SharedWidget.box(0, 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 1; i <= 2; i++) ...[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _radioValue = i;
                                  });
                                  i == 1
                                      ? typeController.text = "Inbound"
                                      : typeController.text = "Outbound";
                                  log(i.toString() +
                                      '  == ' +
                                      typeController.text);
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffe7e7e7),
                                        width: 0.8.w),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.r),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        i == 1 ? 'Inbound' : 'Outbound',
                                        style: transactionDetailTitleTextStyle,
                                      ),
                                      Radio(
                                        activeColor: lightColorScheme.primary,
                                        value: i,
                                        groupValue: _radioValue,
                                        onChanged: (int? val) {
                                          setState(() {
                                            _radioValue = val!;
                                          });
                                          log(i.toString());

                                          i == 1
                                              ? typeController.text = "Inbound"
                                              : typeController.text =
                                                  "Outbound";
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                        SharedWidget.box(0, 10.h),
                        for (int i = 1; i <= 2; i++) ...[
                          Container(
                            child: SharedWidget.textForm(
                              onTap: () async {
                                await pickDateTime(context);
                                setState(() {
                                  if (i == 1 && dateTime != null) {
                                    inboundAtController.text =
                                        DateTimeFormat.getFullDateTime(
                                            dateTime!);
                                  } else if (i == 2 && dateTime != null) {
                                    outboundAtController.text =
                                        DateTimeFormat.getFullDateTime(
                                            dateTime!);
                                  }
                                });
                              },
                              readOnly: true,
                              controller: i == 1
                                  ? inboundAtController
                                  : outboundAtController,
                              labelText: i == 1 ? 'Inbound At' : 'Outbound At',
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return i == 1
                                      ? "Enter the Inbound At"
                                      : "Enter the Outbound At";
                                }
                              },
                              textInputAction: TextInputAction.next,
                              obscureText: false,
                            ),
                          ),
                          SharedWidget.box(0, 10.h),
                        ],
                        SharedWidget.textForm(
                          controller: tranNameController,
                          labelText: 'Transaction Name',
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Transaction Name";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            tranNameController.text = val;
                          },
                          textInputType: TextInputType.text,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 10.h),
                        SharedWidget.textForm(
                          controller: quantityController,
                          labelText: 'Quantity',
                          textInputFormatter:
                              FilteringTextInputFormatter.digitsOnly,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter the Quantity";
                            }
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {
                            quantityController.text = val;
                          },
                          textInputType: TextInputType.number,
                          obscureText: false,
                        ),
                        SharedWidget.box(0, 30.h),
                        SharedWidget.button(
                            buttonLabel: widget.isUpdate
                                ? 'Update Transaction'
                                : 'Add Transaction',
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                var uuid = const Uuid();
                                if (widget.isUpdate) {
                                  Provider.of<TransactionController>(context,
                                          listen: false)
                                      .updateTransaction(
                                          itemId: widget.itemId,
                                          transId: widget.transId!,
                                          trans: TransactionModel(
                                            id: widget.transId!,
                                            type: typeController.text,
                                            itemId: widget.itemId,
                                            quantity: quantityController.text,
                                            inboundAt: inboundAtController.text,
                                            outboundAt:
                                                outboundAtController.text,
                                            transName: tranNameController.text,
                                            createdAT: DateTime.now()
                                          ));
                                } else {
                                  Provider.of<TransactionController>(context,
                                          listen: false)
                                      .addTransaction(
                                          itemId: widget.itemId,
                                          trans: TransactionModel(
                                              id: uuid.v1(),
                                              type: typeController.text,
                                              itemId: widget.itemId,
                                              quantity: quantityController.text,
                                              inboundAt:
                                                  inboundAtController.text,
                                              outboundAt:
                                                  outboundAtController.text,
                                              transName:
                                                  tranNameController.text,
                                                  createdAT: DateTime.now(),),);
                                }
                                Navigator.pop(context);
                           
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

  Future pickDateTime(BuildContext context) async {
    final date = await TransactionSharedWidget.pickDate(context, dateTime);
    if (date == null) return;

    final time = await TransactionSharedWidget.pickTime(context, dateTime);
    if (time == null) return;

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }
}
