import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/profile/models/user_model.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'net_image.dart';

class CoachTileWidget extends StatelessWidget {
  final UserModel coach;
  final bool isMyCoach;

  const CoachTileWidget(this.isMyCoach, {super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundImage: networkImage(coach),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(coach.name, style: MyDecorations.coachesTextStyle),
                    SizedBox(
                      width: 5.w,
                    ),
                    isMyCoach
                        ? Icon(
                            Icons.check_box,
                            color: lightGrey,
                            size: 12.sp,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                Text(coach.description, style: MyDecorations.programsTextStyle),
                RatingBarIndicator(
                  rating: coach.rate.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: red,
                  ),
                  itemCount: 5,
                  itemSize: 10.sp,
                  direction: Axis.horizontal,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
