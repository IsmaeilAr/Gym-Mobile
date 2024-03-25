import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';

class PaymentStatusWidget extends StatelessWidget {
  final bool isPaid;

  const PaymentStatusWidget({super.key, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    Color paidColor = isPaid ? green : primaryColor;
    String statusText = isPaid
        ? AppLocalizations.of(context)!.myProfilePaymentStatusPaid
        : AppLocalizations.of(context)!.myProfilePaymentStatusUnpaid;

    return Row(
      children: [
        Icon(
          Icons.circle_rounded,
          color: paidColor,
          size: 8.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          statusText,
          style: TextStyle(
            color: paidColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class PayCashButton extends StatelessWidget {
  const PayCashButton({super.key});

  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.myProfilePayCashButton,
            style: TextStyle(
              color: primaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h,),
          SizedBox(
            width: 296.w,
            height: 46.h,
            child: ElevatedButton(
                style:MyDecorations.profileButtonStyle(primaryColor),
                onPressed:() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: dark,
                      content: Text(
                        AppLocalizations.of(context)!.myProfileSnackBarMessage,
                        style: MyDecorations.profileLight500TextStyle,
                      ),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.myProfilePayCashButtonText,
                  style: MyDecorations.myButtonTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

