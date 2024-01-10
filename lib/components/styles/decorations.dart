import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';

class MyDecorations {

  static String myFont = 'Saira';

  static InputDecoration myInputDecoration({required String hint, Widget? icon, String? prefix, Widget? suffix,}) {
    double borderRadius = 8.sp;
    double fontSize = 15.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.h,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: lightGrey,
      filled: true,

      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.sp),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: lightGrey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.sp),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.sp),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.sp),
      ),

      labelStyle:  TextStyle(color: black, fontSize: fontSize.sp),
      hintStyle:  TextStyle(color: grey, fontSize: fontSize.sp),
      errorStyle:  TextStyle(color: red, fontSize: fontSize.sp),

      prefixIcon: icon,
      prefixText: prefix,
      suffixIcon: suffix,
    );
  }

  static InputDecoration myInputDecoration2({required String hint, Widget? icon, String? prefix, Widget? suffix,}) {
    double borderRadius = 8.r;
    double fontSize = 15.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.h,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: lightGrey,
      filled: true,

      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: lightGrey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),

      labelStyle:  TextStyle(color: black, fontSize: fontSize.r),
      hintStyle:  TextStyle(color: grey, fontSize: fontSize.sp),
      errorStyle:  TextStyle(color: red, fontSize: fontSize.sp),

      prefixIcon: icon,
      prefixText: prefix,
      suffix: suffix,
      // suffix: Text(suffix, style: mySuffixTextStyle,),
    );
  }

  static ButtonStyle myButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 10.w),
    );
  }

  static TextStyle myButtonTextStyle({required double fontSize , required FontWeight fontWeight}) {
    return TextStyle(
      color: lightGrey,
      fontFamily: myFont,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      height: 1.0, // line height in terms of multiplier
    );
  }

  static TextStyle mySuffixTextStyle = TextStyle(
    color: grey,
    fontFamily: myFont,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.0
  );

  static TextStyle programsTextStyle=TextStyle(
    color: grey,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle coachesTextStyle=TextStyle(
    color: lightGrey,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle premiumTextStyle=TextStyle(
    color: primaryColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

}


