import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/drop_down_selected.dart';
import 'package:gym/features/programs/screens/training_with_coache_screen.dart';
import '../../../components/widgets/programs_app_bar.dart';


class NutritionWithoutCoachesScreen extends StatefulWidget {
  final String title = "Bulking";

  //const TrainingScreen({super.key, required this.title});
  @override
  State<NutritionWithoutCoachesScreen> createState() =>
      _TrainingWithoutCoachesState();
}

class _TrainingWithoutCoachesState extends State<NutritionWithoutCoachesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: programsAppBar(
            title: "Nutrition/${widget.title}", context: context, search: false),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6.h,
            horizontal: 9.w,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: trainingModel.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 156.h,
                              width: 332.w,
                              child: Image.asset(
                                trainingModel[index].imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                                right: 0.w,
                                top: 0.h,
                                child: PopupMenuButton<MenuItem>(
                                  itemBuilder: (context) => [
                                    ...MenuItems.getMenuItems
                                        .map(buildItem)
                                        .toList(),
                                  ],
                                  onSelected: (item) =>
                                      onSelected(context, item),
                                  color: dark,
                                  iconColor: Colors.white,
                                  icon:Icon(Icons.more_horiz_sharp)
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              trainingModel[index].description,
                              style: MyDecorations.programsTextStyle,
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            trainingModel[index].isSelected
                                ? Icon(
                              Icons.check_box,
                              color: grey,
                              size: 12.sp,
                            )
                                : SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

