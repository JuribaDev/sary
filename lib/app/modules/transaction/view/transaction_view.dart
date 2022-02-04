import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/routes/app_routes.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.appBar(
        title: 'Transactions',
        action: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/add_trans_icon.svg",
            width: 19.w,
            height: 19.h,
          ),
        ),
      ),
      body: SharedWidget.floatingButton(
        isOneButton: false,
        onFirstButtonPressed: () {
          
        },
        onSecondButtonPressed: () {},
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Routes.TRANSACTION_DETAIL),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                child: Container(
                  width: 375.w,
                  height: 125.h,
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120.w,
                        height: 125.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Barbican Beer Drink',
                              style: cardTitleTextStyle,
                            ),
                            SharedWidget.box(0, 7.h),
                            Text(
                              'PRO-SA3',
                              style: cardSubtitleTextStyle,
                            ),
                            Text(
                              '320 × 6 ml',
                              style: cardSubtitleTextStyle,
                            ),
                            Expanded(child: SharedWidget.box(0, 7.h)),
                            Text(
                              '91.61 SA',
                              style: cardPriceTextStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        height: 125.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Stock In',
                                  style: cardStatusTextStyle,
                                ),
                                SharedWidget.box(12.w),
                                SvgPicture.asset(
                                  "assets/icons/next_down.svg",
                                  width: 8.w,
                                  height: 20.h,
                                  color: Colors.greenAccent,
                                ),
                              ],
                            ),
                            Text(
                              DateTime.now().toString().substring(0, 10),
                              style: cardSubtitleTextStyle,
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
