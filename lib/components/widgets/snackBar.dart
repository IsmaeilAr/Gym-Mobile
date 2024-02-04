import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym/components/styles/colors.dart';

// showMessageWithAction(BuildContext context, String message,  bool good) {
//   ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//     backgroundColor: good ? green : red,
//          content: Text(
//       message,
//       style: TextStyle(color: lightGrey, fontSize: 14.sp),
//     ),
//   ));
// }

showMessage(String message, bool good) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 2,
    backgroundColor: good ? green : red,
    textColor: lightGrey,
    fontSize: 16.sp,
  );
}
