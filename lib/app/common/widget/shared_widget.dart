import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/app/common/style/text_style.dart';

class SharedWidget {
  //shared appbar
  static PreferredSizeWidget appBar({required String title, Widget? action}) {
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
  static void alertDialog(
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
  static Widget floatingButton(
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

  //shared SizedBox
  static Widget box([double? w, double? h]) {
    return SizedBox(
      width: w,
      height: h,
    );
  }

  //shared bottom sheet widget
  static void bottomSheet(
      {required BuildContext context, required Widget child}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => child);
  }

  //shared loading indicator
  static Widget loadingInicator() {
    return Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }

//shared textform
  static Widget textForm(
      {required String labelText,
      String? initialValue,
      bool? readOnly,
      bool? autofocus,
      TextStyle? textStyle,
      TextAlign? textAlign,
      TextEditingController? controller,
      FormFieldValidator<String>? validator,
      TextInputAction? textInputAction,
      ValueChanged<String>? onFieldSubmitted,
      ValueChanged<String>? onChanged,
      FormFieldSetter<String>? onSaved,
      TextInputType? textInputType,
      bool? obscureText,
      int? maxLength}) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      cursorHeight: 25.h,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.start,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      style: transactionDetailTitleTextStyle,
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: transactionDetailTitleTextStyle,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
        ),
      ),
    );
  }

  static Widget button(
      {required VoidCallback onPressed, required String buttonLabel}) {
    return SizedBox(
      width: double.infinity,
      height: 62.h,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        onPressed: onPressed,
        icon: SvgPicture.asset(
          "assets/icons/add_icon.svg",
          width: 20.w,
          height: 20.h,
        ),
        label: Text(
          buttonLabel,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}
