// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gym/components/styles/colors.dart';
// import 'package:gym/features/notifications/models/notification_model.dart';
//
// class NotificationListTile extends StatelessWidget {
//   final NotificationModel notification;
//   const NotificationListTile(this.notification, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           CircleAvatar(
//             backgroundImage: NetworkImage(notification.imgUrl),
//             maxRadius: 32.r,
//           ),
//
//         ],
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Text(notification.title, style: TextStyle(color: lightGrey, fontWeight: FontWeight.w500, fontSize: 12.sp),),
//           Text(notification.timestamp, style: TextStyle(color: lightGrey, fontWeight: FontWeight.w500, fontSize: 12.sp),),
//         ],
//       ),
//       subtitle: Text(notification.message, softWrap: true, style: TextStyle(color: notification.isUrgent ? red : grey, fontWeight: FontWeight.w500, fontSize: 12.sp),),
//       isThreeLine: true,
//         tileColor: Colors.transparent,
//         onTap:(){},
//     );
//   }
// }
