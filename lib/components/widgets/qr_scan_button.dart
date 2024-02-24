import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/qr_code/screens/qr_view_screen.dart';
import '../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.sp),
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: const QRView(
                  )));
        },
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                      child: SvgPicture.asset(
                        "assets/svg/QR_background.svg",
                        width: 328.w,
                        height: 112.h,
                      )),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 133.w, vertical: 12.h),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/scan_QR.svg",
                            width: 60.w,
                            height: 60.w,
                          ),
                          Text(
                            AppLocalizations.of(context)!.homeScanQR,
                            style: TextStyle(
                                color: lightGrey,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
