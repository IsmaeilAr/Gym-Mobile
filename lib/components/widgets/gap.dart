import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  final double? h;
  final double? w;
  final Widget? child ;
  const Gap({super.key, this.h, this.w, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h?.h ?? 0,
      width: w?.w ?? 0,
      child: child,
    );
  }
}
