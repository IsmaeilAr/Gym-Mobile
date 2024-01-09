import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';

import '../../../components/widgets/programs_app_bar.dart';
import '../model/programs_model.dart';


List<ProgramsModel> training=[
  // ProgramsModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
  // ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
  // ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];
List<ProgramsModel> nutrition=[
  ProgramsModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
  ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
  ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: programsAppBar(title: "Premium", context: context, search: false),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Training",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10.w,),
                  Image.asset("assets/images/Line.png")
                ],
              ),
              training.isEmpty?NoPrograms(text1: "No Training Programs",text2:" You haven't selected a training program yet. Ask for your training program.",)
              :ListPrograms(programModel: training),
              SizedBox(height: 10.h,),
              Row(
                children: [
                  Text("Nutrition",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10.w,),
                  Image.asset("assets/images/Line.png")
                ],
              ),
              nutrition.isEmpty?NoPrograms(text1: "No Nutrition Programs",text2:"You haven't selected a nutrition program yet. Ask for your nutrition program.",)
              :ListPrograms(programModel: nutrition),

            ]
        ),
      ),
    );
  }
}

class ListPrograms extends StatelessWidget {
  List<ProgramsModel> programModel;
  ListPrograms({required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178.h,
      width: 333.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 156.h,
                  width: 243.w,
                  child: GestureDetector(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset(programModel[index].imgUrl,fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Text(programModel[index].title,style:MyDecorations.programsTextStyle,),
              ],
            );
          }
      ),
    );
  }
}

class NoPrograms extends StatelessWidget {

  String text1;
  String text2;
  NoPrograms({required this.text1,required this.text2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                text1,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: grey
                )
            ),
            const Gap(h: 8),
            Text(
              text2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
