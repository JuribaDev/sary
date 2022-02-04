import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sary/app/common/style/text_style.dart';
import 'package:sary/app/common/widget/shared_widget.dart';
import 'package:sary/app/routes/app_routes.dart';

class ItemView extends StatelessWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.appBar(
        title: 'Items',
      ),
      body: SharedWidget.floatingButton(
        isOneButton: true,
        onFirstButtonPressed: () =>
            Navigator.pushNamed(context, Routes.TRANSACTION),
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: ()=> Navigator.of(context).pushNamed(Routes.TRANSACTION),
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
                    children: [
                      Image.asset(
                        'assets/images/beer.png',
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
                            SharedWidget.box(0, 7.h),
                            Text(
                              '91.61 SA',
                              style: cardPriceTextStyle,
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
