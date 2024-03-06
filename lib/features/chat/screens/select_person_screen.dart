import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/coach_list_tile.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../components/styles/gym_icons.dart';
import '../../coaches/screens/search_coaches_screen.dart';

class SelectPersonScreen extends StatefulWidget {
  const SelectPersonScreen({super.key});

  @override
  State<SelectPersonScreen> createState() => _SelectPersonScreenState();
}

class _SelectPersonScreenState extends State<SelectPersonScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<CoachProvider>().getUsersList(context, "Coach");
    });
    super.initState();
  }
  Future<void> _refresh() async {
    context.read<CoachProvider>().getUsersList(context, "Coach");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: BarIconButton(onPressed: () { Navigator.pop(context); }, icon: Icons.arrow_back_ios_outlined,),
        // todo localize
        title: Text(
          "Select person",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.w600, color: lightGrey),
        ),
        actions: [
          BarIconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const SearchCoachesScreen()));
            },
            icon: GymIcons.search,
          ),
        ],
      ),
      body:
      RefreshIndicator(
        color: red,
        backgroundColor: dark,
        onRefresh: _refresh,
        child: context.watch<CoachProvider>().isLoadingGetUsers ?
            const LoadingIndicatorWidget() :
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: ListView.separated(
            itemCount: context.watch<CoachProvider>().coachList.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              UserModel coach = context.watch<CoachProvider>().coachList[index];
              return CoachListTile(coach);
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 11.h,);
          },
          ),
        ),
      ),
    );
  }
}

