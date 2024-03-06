import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cancel_button.dart';

class RateStarsCoachDialog extends StatefulWidget {
  final UserModel coach;

  const RateStarsCoachDialog({
    super.key,
    required this.coach,
  });

  @override
  State<RateStarsCoachDialog> createState() => _RateStarsCoachDialogState();
}

class _RateStarsCoachDialogState extends State<RateStarsCoachDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      actions: [
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) => RateCoachDialog(
                      coach: widget.coach,
                    ));
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.done,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: SizedBox(
        height: 40.h,
        child: Column(
          children: [
            Text(
              "${AppLocalizations.of(context)!.coach} ${widget.coach.name}",
              style: MyDecorations.coachesTextStyle,
            ),
            RatingBar.builder(
              initialRating: widget.coach.rate,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 18.sp,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: primaryColor,
              ),
              onRatingUpdate: (rating) {
                widget.coach.rate = rating;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RateCoachDialog extends StatelessWidget {
  final UserModel coach;

  const RateCoachDialog({
    super.key,
    required this.coach,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      actions: [
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            context
                .read<ProfileProvider>()
                .setRate(context, coach.id, coach.rate)
                .then((value) => Navigator.pop(context));
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.coachProfilePopMenueRate,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "Rate ${coach.name} with ${coach.rate} stars?",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}