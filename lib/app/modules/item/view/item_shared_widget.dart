import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sary/app/common/style/text_style.dart';

class ItemSharedWidget {
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
      // style: textStyle ?? subtitleStyle,
      initialValue: initialValue,
      // cursorColor: Colors.black,
      decoration: InputDecoration(
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
        // ),

        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        filled: true,
        // fillColor: lightTheme.primaryColor,
        labelText: labelText,
        // labelStyle: label,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget button({required VoidCallback onPressed, required String buttonLabel}) {
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
