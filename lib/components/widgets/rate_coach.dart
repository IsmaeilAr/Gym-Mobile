import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/decorations.dart';



class RateCoach extends StatefulWidget {
  final String coachFirstName;
   double rate;
   RateCoach({super.key, required this.coachFirstName, required this.rate});

  @override
  State<RateCoach> createState() => _RateCoachState();
}

class _RateCoachState extends State<RateCoach> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: black,
          child: Text(
            "Cancel",
            style: MyDecorations.programsTextStyle,
          ),
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {},
          color: primaryColor,
          child: Text(
            "Done",
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: SizedBox(
        height: 40.h,
        child: Column(
          children: [
            Text(
              "Coach ${widget.coachFirstName}",
              style: MyDecorations.coachesTextStyle,
            ),
            RatingBar.builder(
              initialRating: widget.rate,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 18.sp,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: primaryColor,
              ),
              onRatingUpdate: (rating) {
                widget.rate=rating;
              },
            ),
          ],
        ),
      ),
    );
  }
}
