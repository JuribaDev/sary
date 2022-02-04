import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/util/date_time_format.dart';
import 'package:sary/app/common/widget/shared_widget.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({Key? key}) : super(key: key);

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
                            'Barbican Beer Drink',
                            style: transactionDetailTitleTextStyle,
                          ),
                          SharedWidget.box(0, 10.h),
                          Text(
                            'PRO-SA3',
                            style: transactionDetailSubtitleTextStyle,
                          ),
                          Text(
                            '320 × 6 ml',
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
                        '25',
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
                        '12.13 SR',
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
                        'Stock In',
                        style: transactionDetailStatusTextStyle,
                      ),
                      SharedWidget.box(12.w),
                      SvgPicture.asset(
                        "assets/icons/next_down.svg",
                        width: 10.w,
                        height: 22.h,
                        color: Colors.greenAccent,
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
                        DateTime.now().toString().substring(0, 10),
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
                        DateTimeFormat.getTime(DateTime.now()),
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
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateTime.now().toString().substring(0, 10),
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
                        DateTimeFormat.getTime(DateTime.now()),
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
