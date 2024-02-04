import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/category_list.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/list_coaches.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/program_list.dart';
import 'package:gym/components/widgets/section_divider.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/coaches/screens/all_coaches_screen.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';




class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<ProgramProvider>().getProgramsList(context, "Recommended", 0); // "0" means no filter
      context.read<ProgramProvider>().getCategoriesList(context, "Sport");
      context.read<ProgramProvider>().getCategoriesList(context, "Food");
      context.read<CoachProvider>().getUsersList(context, "Coach");
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProgramProvider>().getProgramsList(context, "Recommended", 0);
    context.read<ProgramProvider>().getCategoriesList(context, "Sport");
    context.read<ProgramProvider>().getCategoriesList(context, "Food");
    context.read<CoachProvider>().getUsersList(context, "Coach");  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: RefreshIndicator(
        color: red,
        backgroundColor: dark,
        onRefresh: _refresh,
        child: Padding(
          padding:  EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Recommended",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600 ),),
                  context.watch<ProgramProvider>().isLoadingRecommendedProgram ?
                  const Gap(h: 191, w:328, child: LoadingIndicatorWidget()) :
                      ProgramList(listHeight:191,listWidth:328,imgHeight:168,imgWidth:162,
                          programList: context.watch<ProgramProvider>().recommendedProgramList), Gap(
                  h: 10.h,
                ),
        
                const SectionDivider(text: "Training",),
                  context.watch<ProgramProvider>().isLoadingCategories ?
                    const Gap(h: 180, w:333, child: LoadingIndicatorWidget()) :
                      CategoryList(listHeight:180, listWidth:333, imgHeight:156, imgWidth:243,
                          categoryList: context.watch<ProgramProvider>().sportCategoriesList),
        
                const SectionDivider(text: "Nutrition",),
                  context.watch<ProgramProvider>().isLoadingCategories ?
                  const Gap(h: 191, w:328, child: LoadingIndicatorWidget()) :
                  CategoryList(listHeight:180,listWidth:333,imgHeight:156,imgWidth:243,
                          categoryList: context.watch<ProgramProvider>().nutritionCategoriesList),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Coaches",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const AllCoachesScreen(
                                )));
                      },
                      child:Text("See All",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),) ,
                    )
                  ],
                ),
                  context.watch<CoachProvider>().isLoadingGetUsers ?
                  const Gap(h: 80, w:198, child: LoadingIndicatorWidget()) :
                      ListCoaches(listHeight:80, listWidth:198, coachesList: context.watch<CoachProvider>().coachList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






