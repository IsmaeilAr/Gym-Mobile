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
import 'package:gym/features/programs/screens/program_pdf_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../profile/provider/profile_provider.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _refresh();
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProgramProvider>().getProgramsList(context, "Recommended", 0);
    context.read<ProgramProvider>().getCategoriesList(context, "sport");
    context.read<ProgramProvider>().getCategoriesList(context, "food");
    context.read<CoachProvider>().getUsersList(context, "Coach");
    context.read<ProfileProvider>().callGetStatus(context);
  }

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
                Text(
                  AppLocalizations.of(context)!.programsRecommended,
                  style: TextStyle(
                      color: lightGrey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
                context.watch<ProgramProvider>().isLoadingRecommendedProgram
                    ? const Gap(h: 191, w:328, child: LoadingIndicatorWidget()) :
                      ProgramList(listHeight:191,listWidth:328,imgHeight:168,imgWidth:162,
                          programList: context.watch<ProgramProvider>().recommendedProgramList), Gap(
                  h: 10.h,
                ),
                SectionDivider(
                  text: AppLocalizations.of(context)!.programsTraining,
                ),
                context.watch<ProgramProvider>().isLoadingCategories
                    ? const Gap(h: 180, w:333, child: LoadingIndicatorWidget()) :
                      CategoryList(listHeight:180, listWidth:333, imgHeight:156, imgWidth:243,
                        categoryList: context
                            .watch<ProgramProvider>()
                            .sportCategoriesList,
                        'sport'),
                SectionDivider(
                  text: AppLocalizations.of(context)!.programsNutrition,
                ),
                context.watch<ProgramProvider>().isLoadingCategories
                    ? const Gap(h: 191, w:328, child: LoadingIndicatorWidget()) :
                  CategoryList(listHeight:180,listWidth:333,imgHeight:156,imgWidth:243,
                        categoryList: context
                            .watch<ProgramProvider>()
                            .nutritionCategoriesList,
                        'food'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.coachProfileCoaches,
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: const AllCoachesScreen(
                                )));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.programsSeeAll,
                        style: TextStyle(
                            color: lightGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
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






