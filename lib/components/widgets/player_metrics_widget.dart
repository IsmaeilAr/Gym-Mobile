import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/models/player_metrics_model.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerMetricsWidget extends StatefulWidget {
  final PlayerMetricsModel playerMetrics;
  const PlayerMetricsWidget(
    this.playerMetrics, {
    super.key,
  });

  @override
  State<PlayerMetricsWidget> createState() => _PlayerMetricsWidgetState();
}

class _PlayerMetricsWidgetState extends State<PlayerMetricsWidget> {
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
              "${AppLocalizations.of(context)!.myProfileBodyFat}${widget.playerMetrics.bfp} %",
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
                          AppLocalizations.of(context)!.myProfileShowLess,
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
                          AppLocalizations.of(context)!.myProfileShowDetails,
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
                    AppLocalizations.of(context)!.myProfileGender,
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    (widget.playerMetrics.gender == 'male')
                        ? AppLocalizations.of(context)!.addInfogenderMale
                        : AppLocalizations.of(context)!.addInfogenderFemale,
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.myProfileAge,
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    (widget.playerMetrics.age == 0)
                        ? AppLocalizations.of(context)!.notSet
                        : widget.playerMetrics.age.toString(),
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.myProfileHeight,
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    (widget.playerMetrics.height == 0)
                        ? AppLocalizations.of(context)!.notSet
                        : '${widget.playerMetrics.height} ${AppLocalizations.of(context)!.myProfileCm}',
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.myProfileWeight,
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    (widget.playerMetrics.weight == 0)
                        ? AppLocalizations.of(context)!.notSet
                        : "${widget.playerMetrics.weight} ${AppLocalizations.of(context)!.myProfileKg}",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.myProfileWaist,
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    (widget.playerMetrics.waistMeasurement == 0)
                        ? AppLocalizations.of(context)!.notSet
                        : "${widget.playerMetrics.waistMeasurement} ${AppLocalizations.of(context)!.myProfileCm}",
                    style: MyDecorations.profileGrey400TextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.myProfileNeck,
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                  Text(
                    (widget.playerMetrics.neck == 0)
                        ? AppLocalizations.of(context)!.notSet
                        : "${widget.playerMetrics.neck} ${AppLocalizations.of(context)!.myProfileCm}",
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
