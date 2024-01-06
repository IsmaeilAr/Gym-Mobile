import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizerExtension on Widget {
  SizedBox sizer({double? h, double? w}) {
    return SizedBox(
      height: (h ?? 50).h,
      width: (w ?? 50).w,
      child: this,
    );
  }
}
