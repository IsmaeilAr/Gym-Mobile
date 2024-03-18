import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';
import '../provider/report_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportScreen extends StatelessWidget {
   ReportScreen({super.key});
  final TextEditingController _reportController = TextEditingController();

  void dispose() {
    _reportController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: IconButton(
          color: lightGrey,
          icon: Icon(Icons.arrow_back_ios_new,size: 24.sp,),
          onPressed: () => Navigator.pop(context), // todo UX: exit confirmation dialog
        ),
        title: Text(
          AppLocalizations.of(context)!.reportScreenTitle,
          style: TextStyle(
            color: lightGrey,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            color: lightGrey,
            icon: Icon(Icons.send,size: 18.sp,),
            onPressed: () {
              context.read<ReportProvider>().callSubmitReportApi(
                context,
                _reportController.text,
              ).then((value) => Navigator.pop(context));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: TextField(
          maxLines: null,
          style: MyDecorations.coachesTextStyle,
          decoration: InputDecoration(
            suffixStyle: MyDecorations.coachesTextStyle,
            hintText: AppLocalizations.of(context)!.reportScreenWriteHere,
            hintStyle:MyDecorations.coachesTextStyle ,
            border: InputBorder.none,
          ),
          controller: _reportController,
        ),
      ),
    );
  }
}
