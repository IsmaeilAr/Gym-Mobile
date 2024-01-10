import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';

import '../../../components/widgets/drop_down_selected.dart';
import '../../../components/widgets/programs_app_bar.dart';
import '../model/programs_model.dart';



List<TrainingModel> nutritionModel = [
  TrainingModel(
      imageUrl: "assets/images/nutrition.png",
      description: "PPL-4 days a week",
      isSelected: true),
  TrainingModel(
      imageUrl: "assets/images/nutrition.png",
      description: "PPL-4 days a week",
      isSelected: false),
  TrainingModel(
      imageUrl: "assets/images/nutrition.png",
      description: "5 days a week",
      isSelected: false),
];
class NutritionWithCoachScreen extends StatefulWidget {

  final String title="Bulking";
  //const TrainingScreen({super.key, required this.title});

  @override
  State<NutritionWithCoachScreen> createState() => _NutritionWithCoachScreenState();
}

class _NutritionWithCoachScreenState extends State<NutritionWithCoachScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: programsAppBar(title: "Nutrition/${widget.title}", context: context, search: false),
      body: Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            unselectedLabelColor: grey,
            labelStyle: TextStyle(color: primaryColor),
            indicatorColor: primaryColor,
            dividerColor: black,
            tabs: const <Widget>[
              Tab(text: 'My coach'),
              Tab(text: 'All'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                MyCoachesList(),
                MyCoachesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MyCoachesList extends StatefulWidget {
  const MyCoachesList({Key? key}) : super(key: key);

  @override
  State<MyCoachesList> createState() => _MyCoachesListState();
}


class _MyCoachesListState extends State<MyCoachesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
        horizontal: 9.w,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: nutritionModel.length,
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
                            nutritionModel[index].imageUrl,
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
                          nutritionModel[index].description,
                          style: MyDecorations.programsTextStyle,
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        nutritionModel[index].isSelected
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
    );
  }
}

