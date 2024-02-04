import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: (isSender ? Alignment.topRight : Alignment.topLeft),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: isSender
              ? BorderRadius.only(
            topRight: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
            bottomRight: Radius.zero,
            bottomLeft: Radius.circular(16.r),
          )
              : BorderRadius.only(
            topRight: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(16.r),
            bottomLeft: Radius.zero,
          ),
          color: (isSender ? dark : lightGrey),
        ),
        padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w),
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 14.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: isSender ? lightGrey : dark),
            ),
            Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: grey),
            ),
          ],
        ),
      ),
    );
  }
}

