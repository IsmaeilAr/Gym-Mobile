import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';
import 'package:gym/features/programs/model/programs_model.dart';


List<TrainingModel> trainingModel = [
  TrainingModel(
      imageUrl: "assets/images/training.png",
      description: "PPL-4 days a week",
      isSelected: true),
  TrainingModel(
      imageUrl: "assets/images/training.png",
      description: "PPL-4 days a week",
      isSelected: false),
  TrainingModel(
      imageUrl: "assets/images/training.png",
      description: "5 days a week",
      isSelected: false),
  TrainingModel(
      imageUrl: "assets/images/training.png",
      description: "PPL-4 days a week",
      isSelected: false),
];
class TrainingScreen extends StatefulWidget {

  final String title="Bulking";

  const TrainingScreen({super.key});
  //const TrainingScreen({super.key, required this.title});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen>
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
      appBar: programsAppBar(title: "Training/${widget.title}", context: context, search: false),
      body: Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            unselectedLabelColor: grey,
            labelStyle: TextStyle(color: red),
            indicatorColor: red,
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
                Card(
                  margin: const EdgeInsets.all(16.0),
                  child: Center(child: Text(
                      ' Specifications tab')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCoachesList extends StatefulWidget {
  const MyCoachesList({super.key});

  @override
  State<MyCoachesList> createState() => _MyCoachesListState();
}

class _MyCoachesListState extends State<MyCoachesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal:9.w,
        ),
        child: ListView.builder(
          itemCount:trainingModel.length ,
            itemBuilder: (context,index){
            return  Column(
              children: [
                SizedBox(
                  height: 156.h,
                  width: 332.w,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Image.asset(trainingModel[index].imageUrl,fit: BoxFit.fill,),
                  ),
                ),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Text(
                //   trainingModel[index].description,
                // ),
              ],
            );
            }
        ),
      ),
    );
  }
}
