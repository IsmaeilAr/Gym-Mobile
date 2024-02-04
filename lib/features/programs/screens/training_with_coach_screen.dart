import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/pop_menu_selected.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:provider/provider.dart';



class TrainingWithCoachesScreen extends StatefulWidget {
  const TrainingWithCoachesScreen(this.category, {super.key});

  final TrainingCategoryModel category;
  @override
  State<TrainingWithCoachesScreen> createState() => _TrainingWithCoachesScreenState();
}

class _TrainingWithCoachesScreenState extends State<TrainingWithCoachesScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<ProgramProvider>().getProgramsList(context, widget.category.type, widget.category.id);
      context.read<ProgramProvider>().getMyCoachPrograms(context, widget.category.type,
        context.watch<ProfileProvider>().status.coachId,
      );
    });
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String title = "${widget.category.type}⮞${widget.category.name}";
    return Scaffold(
      appBar: ProgramsAppBar(title: title, context: context, search: true),
      body: Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            unselectedLabelColor: grey,
            labelStyle: const TextStyle(color: primaryColor),
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
                ProgramsList(category: widget.category,),
                ProgramsList(category: widget.category,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgramsList extends StatelessWidget {
  const ProgramsList({super.key, required this.category});
  final TrainingCategoryModel category;
  // final bool isCoach;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
        horizontal: 14.w,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: category.type == "Sport" ?
              context.watch<ProgramProvider>().sportProgramList.length :
              context.watch<ProgramProvider>().nutritionProgramList.length,
              itemBuilder: (context, index) {
                ProgramModel program;
                category.type == "Sport" ?
                program = context.watch<ProgramProvider>().sportProgramList[index] :
                program = context.watch<ProgramProvider>().nutritionProgramList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 156.h,
                          width: 332.w,
                          child: Image.asset(
                            program.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                            right: 0.w,
                            top: 0.h,
                            child: PopupMenuButton<MenuItemModel>(
                                itemBuilder: (context) => [
                                  ...MenuItems.getMenuItems
                                      .map(buildItem)
                                      ,
                                ],
                                onSelected: (item) =>
                                    onSelected(context, item, (){
                                      _selectProgram(context, program.id);
                                    }),
                                color: dark,
                                iconColor: Colors.white,
                                icon:Icon(Icons.more_horiz_sharp,size: 20.sp,)
                            )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          program.name,
                          style: MyDecorations.programsTextStyle,
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        program.id ==  program.id
                            ? Icon(
                          Icons.check_box,
                          color: grey,
                          size: 12.sp,
                        )
                            : const SizedBox.shrink(),
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
  void _selectProgram(BuildContext context, int programId){
    context.read<ProgramProvider>().callSetProgram(context, programId);
    // todo onRefresh
  }
}


