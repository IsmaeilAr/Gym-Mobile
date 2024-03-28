import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onQRTap;

  const ScanButton(
    this.onQRTap, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.sp),
        onTap: onQRTap,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          horizontal: 133.w, vertical: 12.h), // UI size 133
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/scan_QR.svg",
                            width: 60.w,
                            height: 60.w,
                          ),
                          SizedBox(
                            width: 80.w,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.homeScanQR,
                                style: TextStyle(
                                    color: lightGrey,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
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
