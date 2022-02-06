import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sary/app/common/style/text_style.dart';

class TransactionSharedWidget {
  static Widget customTextForm(
      {required TextEditingController controller,
      required ValueChanged<String> onChanged,
      required VoidCallback onIconButtonPressed}) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: IconButton(
          onPressed: onIconButtonPressed,
          icon: SvgPicture.asset(
            "assets/icons/search_icon.svg",
            width: 15.w,
            height: 15.h,
            color: const Color(0xff5f5f5f),
          ),
        ),
        hintText: 'Search',
        hintStyle: transactionSearchTextStyle,
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.8.w, color: const Color(0xffe7e7e7)),
          borderRadius: BorderRadius.all(
            Radius.circular(50.r),
          ),
        ),
      ),
    );
  }

  static Widget circlerFilterButton({required VoidCallback onPressed}) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.05),
            color: const Color(0xffe7e7e7)),
        child: CircleAvatar(
          radius: 40.r,
          backgroundColor: Colors.white,
          child: IconButton(
            onPressed: onPressed,
            icon: SvgPicture.asset(
              "assets/icons/filter_icon.svg",
              width: 15.w,
              height: 15.h,
              color: const Color(0xff5f5f5f),
            ),
          ),
        ));
  }
}
