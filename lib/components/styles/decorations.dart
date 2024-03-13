import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';

class MyDecorations {

  static String myFont = 'Saira';

  static InputDecoration myInputDecoration({required String hint, Widget? icon, String? prefix, Widget? suffix,}) {
    double borderRadius = 8.r;
    double fontSize = 14;
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
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: lightGrey,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),

      labelStyle:  TextStyle(color: black, fontSize: fontSize.sp),
      hintStyle:  TextStyle(color: grey, fontSize: fontSize.sp),
      errorStyle:  TextStyle(color: red, fontSize: fontSize.sp),

      prefixIcon: icon,
      prefixText: prefix,
      suffixIcon: suffix,
    );
  }

  static InputDecoration myInputDecoration2({
    required String hint,
    Widget? icon,
    String? prefix,
    String? suffix,
  }) {
    double borderRadius = 8.r;
    double fontSize = 15.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 9.5.h,
        vertical: 14.h,
        // vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: lightGrey,
      filled: true,

      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: lightGrey,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: red,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),

      labelStyle: TextStyle(color: black, fontSize: fontSize),
      hintStyle: TextStyle(color: grey, fontSize: fontSize),
      errorStyle: TextStyle(color: red, fontSize: fontSize),

      prefixIcon: icon,
      prefixText: prefix,
      // suffix: suffix,
      suffix: Text(
        suffix ?? '',
        style: mySuffixTextStyle,
      ),
    );
  }

  static InputDecoration myInputDecoration3({
    required String hint,
  }) {
    double borderRadius = 8.r;
    double fontSize = 12.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 9.5.h,
      ),
      hintText: hint,
      fillColor: black,
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
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
      labelStyle: TextStyle(
          color: lightGrey, fontSize: fontSize.sp, fontWeight: FontWeight.w400),
      hintStyle: TextStyle(
          color: lightGrey, fontSize: fontSize.sp, fontWeight: FontWeight.w400),
      errorStyle: TextStyle(color: red, fontSize: fontSize.sp),
    );
  }

  static InputDecoration myInputDecoration4(
      {required String hint, required Widget suffix}) {
    double borderRadius = 8.r;
    double fontSize = 12.sp;
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 12.h,
      ),
      fillColor: black,
      filled: true,
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
        ),
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: grey,
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
      prefix: Text(
        hint,
        style: TextStyle(
            color: lightGrey,
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w400),
      ),
      errorStyle:  TextStyle(color: red, fontSize: fontSize.sp),
      suffix: suffix,
    );
  }

  static BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: black,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(
        color: grey,
      ),
    );
  }

  static ButtonStyle myButtonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
    );
  }

  static ButtonStyle profileButtonStyle(Color color){
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      //padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
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

  static TextStyle calendarTextStyle = TextStyle(
    color: lightGrey,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    fontFamily: myFont,
  );

  static TextStyle profileLight400TextStyle=TextStyle(
    color: lightGrey,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: myFont,
  );

  static TextStyle profileLight500TextStyle=TextStyle(
    color: lightGrey,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle profileGreyTextStyle=TextStyle(
    color: grey,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: myFont,
  );

  static TextStyle profileGrey400TextStyle=TextStyle(
    color: grey,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: myFont,
  );
}


