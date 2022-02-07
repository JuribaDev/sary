import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sary/app/common/colors/light_theme_color.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/modules/transaction/controller/transaction_controller.dart';
import 'package:sary/app/modules/transaction/view/transaction_shared_widget.dart';
import 'package:sary/app/routes/app_routes.dart';

class TransactionView extends StatefulWidget {
  Map<String, dynamic> item;
  TransactionView({Key? key, required this.item}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  late TextEditingController searchController;

  @override
  void initState() {
    log(widget.item.toString());
    Provider.of<TransactionController>(context, listen: false)
        .getTransactions(itemId: widget.item['id']);
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: SharedWidget.appBar(
          title: 'Transactions',
          action: IconButton(
            onPressed: () => Navigator.pushNamed(
                context, Routes.TRANSACTION_FORM,
                arguments: {"isUpdate": false, "itemId": widget.item['id']}),
            icon: SvgPicture.asset(
              "assets/icons/add_trans_icon.svg",
              width: 19.w,
              height: 19.h,
            ),
          ),
        ),
        body: SharedWidget.floatingButton(
          isOneButton: false,
          onFirstButtonPressed: () {},
          onSecondButtonPressed: () {},
          child: Column(
            children: [
              SharedWidget.box(0, 21.h),
              SizedBox(
                width: 375.w,
                height: 52.h,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: TransactionSharedWidget.customTextForm(
                          controller: searchController,
                          onChanged: (val) {},
                          onIconButtonPressed: () {})),
                  SharedWidget.box(8.w),
                  TransactionSharedWidget.circlerFilterButton(onPressed: () {})
                ]),
              ),
              SharedWidget.box(0, 21.h),
              Expanded(
                child: SizedBox(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await Provider.of<TransactionController>(context,
                              listen: false)
                          .getTransactions(itemId: widget.item['id']);
                    },
                    child: Provider.of<TransactionController>(context).isLoading
                        ? SharedWidget.loadingInicator()
                        : Provider.of<TransactionController>(context)
                                .transactions
                                .isEmpty
                            ? Center(
                                child: Text(
                                  'There are no Transactions -_- ',
                                  style: transactionDetailDatetimeTextStyle,
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    Provider.of<TransactionController>(context)
                                        .transactions
                                        .length,
                                itemBuilder: (context, i) {
                                  return GestureDetector(
                                    onTap: () => Navigator.pushNamed(
                                        context, Routes.TRANSACTION_DETAIL,
                                        arguments: {
                                          "trans": Provider.of<
                                                      TransactionController>(
                                                  context,
                                                  listen: false)
                                              .transactions[i]
                                              .toMap(),
                                          "item": widget.item
                                        }),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 14.h),
                                      child: Dismissible(
                                        key: const ValueKey('dismiss'),
                                        confirmDismiss: (dis) async {
                                          if (DismissDirection.startToEnd ==
                                              dis) {
                                            SharedWidget.alertDialog(
                                                context: context,
                                                title: 'Delete Transaction',
                                                onYesPressed: () async {
                                                  String transId = Provider.of<
                                                              TransactionController>(
                                                          context,
                                                          listen: false)
                                                      .transactions[i]
                                                      .id;
                                                  await Provider.of<
                                                              TransactionController>(
                                                          context,
                                                          listen: false)
                                                      .deleteTransaction(
                                                          itemId:
                                                              widget.item['id'],
                                                          transId: transId);
                                                  Navigator.pop(context);
                                                },
                                                hasContent: true,
                                                content:
                                                    'Are sure to delete Transaction ID: ${Provider.of<TransactionController>(context, listen: false).transactions[i].id}');
                                          } else if (DismissDirection
                                                  .endToStart ==
                                              dis) {
                                            String transId = Provider.of<
                                                        TransactionController>(
                                                    context,
                                                    listen: false)
                                                .transactions[i]
                                                .id;

                                            Navigator.pushNamed(context,
                                                Routes.TRANSACTION_FORM,
                                                arguments: {
                                                  "isUpdate": true,
                                                  "itemId": widget.item['id'],
                                                  "transId": transId
                                                });
                                          }
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.w),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.delete_outline,
                                              size: 30.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          color: lightColorScheme.primary,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30.w),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.edit_outlined,
                                              size: 30.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 375.w,
                                          height: 125.h,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24.h, horizontal: 16.w),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(16.r),
                                            ),
                                          ),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 120.w,
                                                height: 125.h,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.item['name'],
                                                      style: cardTitleTextStyle,
                                                    ),
                                                    SharedWidget.box(0, 7.h),
                                                    Text(
                                                      widget.item['sku'],
                                                      style:
                                                          cardSubtitleTextStyle,
                                                    ),
                                                    Text(
                                                      widget
                                                          .item['description'],
                                                      style:
                                                          cardSubtitleTextStyle,
                                                    ),
                                                    Expanded(
                                                        child: SharedWidget.box(
                                                            0, 7.h)),
                                                    Text(
                                                      widget.item['price'],
                                                      style: cardPriceTextStyle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 80.w,
                                                height: 125.h,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          Provider.of<TransactionController>(
                                                                          context)
                                                                      .transactions[
                                                                          i]
                                                                      .type ==
                                                                  'Inbound'
                                                              ? 'In Stock'
                                                              : 'Out Stock',
                                                          style:
                                                              cardStatusTextStyle,
                                                        ),
                                                        SharedWidget.box(12.w),
                                                        SvgPicture.asset(
                                                          Provider.of<TransactionController>(
                                                                          context)
                                                                      .transactions[
                                                                          i]
                                                                      .type ==
                                                                  'Inbound'
                                                              ? "assets/icons/next_down.svg"
                                                              : "assets/icons/next_up.svg",
                                                          width: 8.w,
                                                          height: 20.h,
                                                          color: Provider.of<TransactionController>(
                                                                          context)
                                                                      .transactions[
                                                                          i]
                                                                      .type ==
                                                                  'Inbound'
                                                              ? Colors
                                                                  .greenAccent
                                                              : Colors.red,
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      Provider.of<TransactionController>(
                                                                      context)
                                                                  .transactions[
                                                                      i]
                                                                  .type ==
                                                              "Inbound"
                                                          ? Provider.of<
                                                                      TransactionController>(
                                                                  context)
                                                              .transactions[i]
                                                              .inboundAt
                                                              .substring(0, 10)
                                                          : Provider.of<
                                                                      TransactionController>(
                                                                  context)
                                                              .transactions[i]
                                                              .outboundAt
                                                              .substring(0, 10),
                                                      style:
                                                          cardSubtitleTextStyle,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
