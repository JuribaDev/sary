import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sary/app/common/colors/light_theme_color.dart';
import 'package:sary/app/common/native_plugn/custom_toast_message.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/modules/item/controller/item_controller.dart';
import 'package:sary/app/modules/item/view/item_form.dart';
import 'package:sary/app/modules/transaction/controller/transaction_controller.dart';
import 'package:sary/app/routes/app_routes.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  void initState() {
    Provider.of<ItemController>(context, listen: false).getItems();

    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.appBar(
        title: 'Items',
      ),
      body: SharedWidget.floatingButton(
        isOneButton: true,
        onFirstButtonPressed: () =>
            Navigator.pushNamed(context, Routes.ITEM_FORM, arguments: {
          "isUpdate": false,
        }),
        child: RefreshIndicator(
          onRefresh: () async {
            return Provider.of<ItemController>(context, listen: false)
                .getItems();
          },
          child: Provider.of<ItemController>(context).isLoading
              ? SharedWidget.loadingInicator()
              : Provider.of<ItemController>(context).items.isEmpty
                  ? Center(
                      child: Text(
                        'There are no Items -_-',
                        style: transactionDetailDatetimeTextStyle,
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          Provider.of<ItemController>(context).items.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, Routes.TRANSACTION,
                              arguments: Provider.of<ItemController>(context,
                                      listen: false)
                                  .items[i]
                                  .toMap()),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 14.h),
                            child: Dismissible(
                              key: const ValueKey('dis'),
                              confirmDismiss: (dis) async {
                                if (DismissDirection.startToEnd == dis) {
                                  SharedWidget.alertDialog(
                                      context: context,
                                      title: 'Delete Item',
                                      onYesPressed: () async {
                                        String itemId =
                                            Provider.of<ItemController>(context,
                                                    listen: false)
                                                .items[i]
                                                .id;
                                        await Provider.of<ItemController>(
                                                context,
                                                listen: false)
                                            .deleteItem(itemId: itemId);
                                        Navigator.pop(context);
                                      },
                                      hasContent: true,
                                      content:
                                          'Are sure to delete ${Provider.of<ItemController>(context, listen: false).items[i].name}');
                                } else if (DismissDirection.endToStart == dis) {
                                  String itemId = Provider.of<ItemController>(
                                          context,
                                          listen: false)
                                      .items[i]
                                      .id;

                                  Navigator.pushNamed(context, Routes.ITEM_FORM,
                                      arguments: {
                                        "isUpdate": true,
                                        "itemId": itemId
                                      });
                                }
                              },
                              background: Container(
                                color: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  children: [
                                    Image.asset(
                                      'assets/images/beer.png',
                                    ),
                                    SharedWidget.box(16.w),
                                    SizedBox(
                                      width: 120.w,
                                      height: 125.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Provider.of<ItemController>(context)
                                                .items[i]
                                                .name,
                                            style: cardTitleTextStyle,
                                          ),
                                          SharedWidget.box(0, 7.h),
                                          Text(
                                            Provider.of<ItemController>(context)
                                                .items[i]
                                                .sku,
                                            style: cardSubtitleTextStyle,
                                          ),
                                          Text(
                                            Provider.of<ItemController>(context)
                                                .items[i]
                                                .description,
                                            style: cardSubtitleTextStyle,
                                          ),
                                          SharedWidget.box(0, 7.h),
                                          Text(
                                            Provider.of<ItemController>(context)
                                                .items[i]
                                                .price
                                                .toString(),
                                            style: cardPriceTextStyle,
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
                      }),
        ),
      ),
    );
  }
}
