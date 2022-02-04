import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/app/common/style/text_style.dart';

class SharedWidget {
  //shared appbar
  static appBar({required String title, Widget? action}) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: action == null
          ? null
          : [
              Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: action,
              )
            ],
      title: Text(
        title,
        style: appbarTextStyle,
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  //shared IOS or android  alert dialog
  static alertDialog(
      {required BuildContext context,
      required String title,
      required VoidCallback onYesPressed,
      required bool hasContent,
      String? content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(title),
                content: hasContent ? Text(content!) : null,
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: const Text('Yes'),
                    isDestructiveAction: true,
                    onPressed: onYesPressed,
                  )
                ],
              )
            : AlertDialog(
                title: Text(title),
                content: hasContent ? Text(content!) : null,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: onYesPressed,
                    child: const Text('Yes'),
                  ),
                ],
              );
      },
    );
  }

  //shared floating buttons

  static floatingButton(
      {required Widget child,
      required bool isOneButton,
      required VoidCallback onFirstButtonPressed,
      VoidCallback? onSecondButtonPressed}) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        //the background of floating buttons
        child,

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: isOneButton
              ? SizedBox(
                  width: 375.w,
                  height: 62.h,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                     
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    onPressed: isOneButton ? onFirstButtonPressed : null,
                    icon: SvgPicture.asset(
                      "assets/icons/add_icon.svg",
                      width: 20.w,
                      height: 20.h,
                    ),
                    label: Text(
                      'Add Item',
                      style: buttonTextStyle,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 185.w,
                      height: 62.h,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        onPressed: !isOneButton ? onFirstButtonPressed : null,
                        icon: SvgPicture.asset(
                          "assets/icons/next_up.svg",
                          width: 8.w,
                          height: 20.h,
                        ),
                        label: Text(
                          'Send',
                          style: buttonTextStyle,
                        ),
                      ),
                    ),
                    box(5.w),
                    SizedBox(
                      width: 185.w,
                      height: 62.h,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        onPressed: !isOneButton ? onSecondButtonPressed : null,
                        icon: SvgPicture.asset(
                          "assets/icons/next_down.svg",
                          width: 8.w,
                          height: 20.h,
                        ),
                        label: Text(
                          'Receive',
                          style: buttonTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
        )
      ],
    );
  }

  static box([double? w, double? h]) {
    return SizedBox(
      width: w,
      height: h,
    );
  }
}
