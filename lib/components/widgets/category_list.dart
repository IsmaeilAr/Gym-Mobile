import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../features/programs/model/category_model.dart';
import '../../features/programs/screens/training_with_coach_screen.dart';
import '../../features/programs/screens/training_without_coach_screen.dart';
import '../styles/decorations.dart';


class CategoryList extends StatelessWidget {
  final double listHeight, listWidth, imgHeight, imgWidth;
  final List<TrainingCategoryModel> categoryList;
  const CategoryList({super.key, required this.listHeight,required this.listWidth,required this.imgHeight,required this.imgWidth,required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight.h,
      width: listWidth.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            TrainingCategoryModel category = categoryList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: imgHeight.h,
                  width: imgWidth.w,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child:
                              context.watch<ProfileProvider>().hasCoach ?
                              TrainingWithCoachesScreen(category) :
                              TrainingWithoutCoachesScreen(category)
                          ));
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset(category.imageUrl,fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Text(category.name,style:MyDecorations.programsTextStyle,),
              ],
            );
          }
      ),
    );
  }
}

