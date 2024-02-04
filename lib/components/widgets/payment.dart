import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';

class PaymentStatusWidget extends StatelessWidget {
  final bool isPaid;

  const PaymentStatusWidget({super.key, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    Color circleColor = isPaid ? Colors.green : primaryColor;
    Color textColor = isPaid ? Colors.green : primaryColor;
    String statusText = isPaid ? "paid" : "unpaid";

    return Row(
      children: [
        Icon(
          Icons.circle_rounded,
          color: circleColor,
          size: 8.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          statusText,
          style: TextStyle(
            color: textColor,
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
          Text("please, pay your membership fee",style: TextStyle(color: primaryColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,),),
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
                      content: Expanded(child: Text("This service is currently not available",style: MyDecorations.profileLight500TextStyle,)),
                    ),
                  );
                },
                child: Text(
                  "Pay cash",
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

