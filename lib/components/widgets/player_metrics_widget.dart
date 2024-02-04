import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/models/player_metrics_model.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';

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
              "Body fat: ${widget.playerMetrics.bfp} %",
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
                    widget.playerMetrics.gender,
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
                    (widget.playerMetrics.age == 0)
                        ? "not set"
                        : widget.playerMetrics.age.toString(),
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
                    (widget.playerMetrics.height == 0)
                        ? "not set"
                        : "${widget.playerMetrics.height} cm",
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
                    (widget.playerMetrics.weight == 0)
                        ? "not set"
                        : "${widget.playerMetrics.weight} kg",
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
                    (widget.playerMetrics.waistMeasurement == 0)
                        ? "not set"
                        : "${widget.playerMetrics.waistMeasurement} cm",
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
                    (widget.playerMetrics.neck == 0)
                        ? "not set"
                        : "${widget.playerMetrics.neck} cm",
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
