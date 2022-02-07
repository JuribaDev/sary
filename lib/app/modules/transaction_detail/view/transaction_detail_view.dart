import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/util/date_time_format.dart';
import 'package:sary/app/common/widget/shared_widget.dart';

class TransactionDetailView extends StatelessWidget {
  Map<String, dynamic> transactionDetailView;
  TransactionDetailView({Key? key, required this.transactionDetailView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.appBar(
        title: 'Transaction Details',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Container(
          width: 375.w,
          height: 485.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 375.w,
                height: 150.h,
                // padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
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
                      width: 140.w,
                      height: 80.h,
                    ),
                    SharedWidget.box(16.w),
                    SizedBox(
                      width: 120.w,
                      height: 125.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionDetailView['item']['name'],
                            style: transactionDetailTitleTextStyle,
                          ),
                          SharedWidget.box(0, 10.h),
                          Text(
                            transactionDetailView['item']['sku'],
                            style: transactionDetailSubtitleTextStyle,
                          ),
                          Text(
                            transactionDetailView['item']['description'],
                            style: transactionDetailSubtitleTextStyle,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
              SharedWidget.box(0, 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionDetailView['trans']['quantity'],
                        style: transactionDetailPriceAndQuantityTextStyle,
                      ),
                      Text(
                        'Quantity',
                        style: transactionDetailSubtitleTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionDetailView['item']['price'],
                        style: transactionDetailPriceAndQuantityTextStyle,
                      ),
                      Text(
                        'Price',
                        style: transactionDetailSubtitleTextStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        transactionDetailView['trans']['type'] == 'Inbound'
                            ? 'In Stock'
                            : 'Out Stock',
                        style: transactionDetailStatusTextStyle,
                      ),
                      SharedWidget.box(12.w),
                      SvgPicture.asset(
                        transactionDetailView['trans']['type'] == 'Inbound'
                            ? "assets/icons/next_down.svg"
                            : "assets/icons/next_up.svg",
                        width: 10.w,
                        height: 22.h,
                        color:
                            transactionDetailView['trans']['type'] == 'Inbound'
                                ? Colors.greenAccent
                                : Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
              SharedWidget.box(0, 30.h),
              Text(
                'Inbound',
                style: transactionDetailTitleTextStyle,
              ),
              SharedWidget.box(0, 15.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionDetailView['trans']['inbound_at'].toString().substring(0,10),
                        style: transactionDetailPriceAndQuantityTextStyle,
                      ),
                      Text(
                        'Date',
                        style: transactionDetailSubtitleTextStyle,
                      ),
                    ],
                  ),
                  SharedWidget.box(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       transactionDetailView['trans']['inbound_at']
                            .toString()
                            .substring(11, 17),
                        style: transactionDetailPriceAndQuantityTextStyle,
                      ),
                      Text(
                        'Time',
                        style: transactionDetailSubtitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              SharedWidget.box(0, 30.h),
              Text(
                'Outbound',
                style: transactionDetailTitleTextStyle,
              ),
              SharedWidget.box(0, 15.h),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transactionDetailView['trans']['inbound_at'].toString().substring(0,10)
                       ,
                        style: transactionDetailPriceAndQuantityTextStyle,
                      ),
                      Text(
                        'Date',
                        style: transactionDetailSubtitleTextStyle,
                      ),
                    ],
                  ),
                  SharedWidget.box(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         transactionDetailView['trans']['outbound_at']
                            .toString()
                            .substring(11, 17),
                        style: transactionDetailPriceAndQuantityTextStyle,
                      ),
                      Text(
                        'Time',
                        style: transactionDetailSubtitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
