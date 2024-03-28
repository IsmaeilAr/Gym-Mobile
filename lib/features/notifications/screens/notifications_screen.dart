import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/back_button.dart';
import 'package:provider/provider.dart';
import '../../../components/styles/colors.dart';
import '../../../components/widgets/icon_button.dart';
import '../../../components/widgets/loading_indicator.dart';
import '../models/notification_model.dart';
import '../provider/notification_provider.dart';
import '../widgets/notification_list_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<NotificationProvider>().getNotifications(context,);
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<NotificationProvider>().getNotifications(context,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: const MyBackButton(),
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.w600, color: lightGrey),
        ),
      ),
      body: RefreshIndicator(
        color: red,
        backgroundColor: dark,
        onRefresh: _refresh,
        child: context.watch<NotificationProvider>().isLoadingNotifications ?
        const LoadingIndicatorWidget() :
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: ListView.separated(
            itemCount: context.watch<NotificationProvider>().notificationList.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              NotificationModel notification = context.watch<NotificationProvider>().notificationList[index];
              return NotificationListTile(notification);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 11.h,);
            },
          ),
        ),
      ),
    );
  }
}
