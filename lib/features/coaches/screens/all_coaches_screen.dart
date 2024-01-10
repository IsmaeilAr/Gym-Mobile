import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';

import '../model/coach_model.dart';

List<CoachModel> coaches = [
  CoachModel(
      name: "Eias Saleh",
      description: 'Champion Of The Republic',
      imgUrl: "assets/images/img1.png",
      rate: 5,
      isSelected: true),
  CoachModel(
    name: "Eias Saleh",
    description: 'Champion Of The Republic',
    imgUrl: "assets/images/img1.png",
    rate: 3.5,
    isSelected: false,
  ),
  CoachModel(
    name: "Eias Saleh",
    description: 'Champion Of The Republic',
    imgUrl: "assets/images/img1.png",
    rate: 1.5,
    isSelected: false,
  ),
];

class AllCoachesScreen extends StatefulWidget {
  const AllCoachesScreen({super.key});

  @override
  State<AllCoachesScreen> createState() => _CoachesModelState();
}

class _CoachesModelState extends State<AllCoachesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: programsAppBar(title: "Coaches", context: context, search: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: coaches.length,
              itemBuilder: (context, index) {
                return Container(
                    height: 90.h, //81.h,
                    width: 332.w,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: dark,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AllCoachesWidget(coachesIndexes: index),
                          IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                        ],
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}


class AllCoachesWidget extends StatelessWidget {
  int coachesIndexes;
  AllCoachesWidget({super.key, required this.coachesIndexes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Image.asset(
                coaches[coachesIndexes].imgUrl,
                fit: BoxFit.fill,
              ),
              radius: 28.r,
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(coaches[coachesIndexes].name,
                        style: MyDecorations.coachesTextStyle),
                    SizedBox(
                      width:5.w,
                    ),
                    coaches[coachesIndexes].isSelected?
                    Icon(Icons.check_box,color: Colors.white,size: 12.sp,):const SizedBox.shrink(),
                  ],
                ),
                Text(coaches[coachesIndexes].description,
                    style: MyDecorations.programsTextStyle),
                RatingBarIndicator(
                  rating: coaches[coachesIndexes].rate,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color:red,
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
