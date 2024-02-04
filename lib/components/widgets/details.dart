import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';

class PlayerInfoWidget extends StatefulWidget {
  final double bodyFat;
  final String gender;
  final int age;
  final int height;
  final int weight;
  final int waist;
  final int neck;

  const PlayerInfoWidget(
      {super.key,
        required this.bodyFat,
        required this.gender,
        required this.age,
        required this.height,
        required this.weight,
        required this.waist,
        required this.neck});

  @override
  State<PlayerInfoWidget> createState() => _PlayerInfoWidgetState();
}

class _PlayerInfoWidgetState extends State<PlayerInfoWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Body fat: ${widget.bodyFat} %",
              style: MyDecorations.profileLight500TextStyle,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: isVisible
                  ? Row(
                children: [
                  Text(
                    "show less",
                    style: MyDecorations.programsTextStyle,
                  ),
                  Icon(
                    Icons.expand_less,
                    color: grey,
                    size: 12.sp,
                  ),
                ],
              )
                  : Row(
                children: [
                  Text(
                    "show details",
                    style: MyDecorations.programsTextStyle,
                  ),
                  Icon(
                    Icons.expand_more,
                    color: grey,
                    size: 12.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: isVisible,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Gender: ",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    widget.gender,
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Age: ",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    "${widget.age}",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Height: ",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    "${widget.height}cm",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Weight: ",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    "${widget.weight}kg",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Waist: ",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    "${widget.waist}cm",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Neck: ",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    "${widget.neck}cm",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 21.h),
      ],
    );
  }
}