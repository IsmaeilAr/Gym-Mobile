import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../components/styles/colors.dart';
import '../models/notification_model.dart';

class NotificationListTile extends StatefulWidget {
  final NotificationModel notification;

  const NotificationListTile(this.notification, {super.key});

  @override
  State<NotificationListTile> createState() => _NotificationListTileState();
}

class _NotificationListTileState extends State<NotificationListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: dark,
            child: SvgPicture.asset(
              'assets/svg/Logo.svg',
            ),
            maxRadius: 29.5.r,
          ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.notification.title,
            style: TextStyle(
                color: lightGrey, fontWeight: FontWeight.w500, fontSize: 12.sp),
          ),
          Text(
            DateFormat('yyyy/MM/dd').format(widget.notification.date),
            style: TextStyle(
                color: lightGrey, fontWeight: FontWeight.w500, fontSize: 12.sp),
          ),
        ],
      ),
      subtitle: Text(
        widget.notification.content,
        softWrap: true,
        style: TextStyle(
            color: grey, fontWeight: FontWeight.w500, fontSize: 12.sp),
      ),
      isThreeLine: true,
      // tileColor: Colors.transparent,
      onTap: () {
        debugPrint(widget.notification.content);
      },
    );
  }
}
