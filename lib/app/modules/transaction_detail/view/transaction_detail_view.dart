import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/routes/app_routes.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.appBar(
        title: 'Items',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Container(
          width: 375.w,
          height: 415.h,
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.r),
            ),
          ),
          child: Column(
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
                      // width: 130.w,
                      // height: 75.h,
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
              SharedWidget.box(0, 29.h),
              Row(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
