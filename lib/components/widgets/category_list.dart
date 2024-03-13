import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../features/programs/model/category_model.dart';
import '../../features/programs/screens/premium_screen.dart';
import '../../features/programs/screens/training_with_coach_screen.dart';
import '../../features/programs/screens/training_without_coach_screen.dart';
import '../styles/decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryList extends StatelessWidget {
  final double listHeight, listWidth, imgHeight, imgWidth;
  final List<TrainingCategoryModel> categoryList;
  final String genre;

  const CategoryList(this.genre,
      {super.key,
      required this.listHeight,
      required this.listWidth,
      required this.imgHeight,
      required this.imgWidth,
      required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight.h,
      width: listWidth.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length + 1,
          itemBuilder: (context, index) {
            if (index < categoryList.length) {
              TrainingCategoryModel category = categoryList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: context.read<ProfileProvider>().status.hasCoach
                              ? TrainingWithCoachesScreen(category)
                              : TrainingWithoutCoachesScreen(category)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: imgHeight.h,
                      width: imgWidth.w,
                      child: Card(
                        elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Image.network(
                          category.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        category.name,
                        style: MyDecorations.programsTextStyle,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: imgHeight.h,
                    width: imgWidth.w,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                            child: PremiumScreen(
                              genre: genre,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Image.asset(
                          "assets/images/premium.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      AppLocalizations.of(context)!.premium,
                      style: MyDecorations.programsTextStyle,
                    ),
                  ),
                  // edit text to premium nutrition or sport
                ],
              );
            }
          }
      ),
    );
  }
}

