import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/features/coaches/screens/all_coaches_screen.dart';
import 'package:gym/features/programs/model/programs_model.dart';

List<ProgramsModel> recommended = [
  ProgramsModel(title: 'Training', imgUrl: "assets/images/Rectangle 61.png"),
  ProgramsModel(title: 'Nutrition', imgUrl: "assets/images/Rectangle 61.png"),
];
List<ProgramsModel> training = [
  ProgramsModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
  ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
  ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];

List<ProgramsModel> coaches = [
  ProgramsModel(title: 'Eias', imgUrl: "assets/images/img1.png"),
  ProgramsModel(title: 'Maya', imgUrl: "assets/images/img1.png"),
  ProgramsModel(title: 'Lana', imgUrl: "assets/images/img1.png"),
];

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommended",
                style: TextStyle(
                    color: lightGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              ProgramsList(
                  heightList: 191,
                  widthList: 328,
                  imgHeight: 168,
                  imgWidth: 162,
                  programModel: recommended),
              Text(
                "Training",
                style: TextStyle(
                    color: lightGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              ProgramsList(
                  heightList: 180,
                  widthList: 333,
                  imgHeight: 156,
                  imgWidth: 243,
                  programModel: training),
              Text(
                "Nutrition",
                style: TextStyle(
                    color: lightGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              ProgramsList(
                  heightList: 180,
                  widthList: 333,
                  imgHeight: 156,
                  imgWidth: 243,
                  programModel: training),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coaches",
                    style: TextStyle(
                        color: lightGrey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllCoachesScreen()));
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              CoachesList(heightList: 80, widthList: 198, programModel: coaches),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgramsList extends StatelessWidget {
  double heightList, widthList, imgHeight, imgWidth;
  List<ProgramsModel> programModel;
  ProgramsList(
      {super.key, required this.heightList,
      required this.widthList,
      required this.imgHeight,
      required this.imgWidth,
      required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightList.h,
      width: widthList.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: imgHeight.h,
                  width: imgWidth.w,
                  child: GestureDetector(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset(
                        programModel[index].imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Text(programModel[index].title,
                    style: MyDecorations.programsTextStyle),
              ],
            );
          }),
    );
  }
}

class CoachesList extends StatelessWidget {
  double heightList, widthList;
  List<ProgramsModel> programModel;
  CoachesList(
      {super.key, required this.heightList,
      required this.widthList,
      required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightList.h,
      width: widthList.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Image.asset(
                        programModel[index].imgUrl,
                        fit: BoxFit.fill,
                        height: 48.h,
                        width: 48.w,
                      ),
                    ),
                  ),
                ),
                Text(programModel[index].title,
                    style: MyDecorations.programsTextStyle),
              ],
            );
          }),
    );
  }
}
