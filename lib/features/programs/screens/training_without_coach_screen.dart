import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/menuItem_model.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:provider/provider.dart';
import '../../../components/pop_menu/pop_menu_set_program.dart';
import '../../../components/widgets/programs_app_bar.dart';

class TrainingWithoutCoachesScreen extends StatefulWidget {
  const TrainingWithoutCoachesScreen(this.category, {super.key});

  final TrainingCategoryModel category;

  @override
  State<TrainingWithoutCoachesScreen> createState() =>
      _TrainingWithoutCoachesState();
}

class _TrainingWithoutCoachesState extends State<TrainingWithoutCoachesScreen> {
  @override
  void initState() {
    // todo try put 2 lines below into postFrameCallBack
    searching = false;
    customIcon = const Icon(
      Icons.search,
      color: lightGrey,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProgramProvider>()
          .getProgramsList(context, widget.category.type, widget.category.id);
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context
        .read<ProgramProvider>()
        .getProgramsList(context, widget.category.type, widget.category.id);
  }

  late bool searching;
  late Icon customIcon;

  @override
  Widget build(BuildContext context) {
    String title = "${widget.category.type}/${widget.category.name}";
    return Scaffold(
        appBar: ProgramsAppBar(title: title, context: context, search: true),
        body: RefreshIndicator(
          color: red,
          backgroundColor: dark,
          onRefresh: _refresh,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 14.w,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount:
                    widget.category.type == "Sport" ?
                    context.watch<ProgramProvider>().sportProgramList.length :
                    context.watch<ProgramProvider>().nutritionProgramList.length,
                    itemBuilder: (context, index) {
                      ProgramModel program;
                      widget.category.type == "Sport" ?
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
                                      ...SetProgramsMenuItems
                                          .getSetProgramMenuItems
                                          .map(buildItem),
                                    ],
                                    onSelected: (item) => onSelectSetProgram(
                                        context, item, program, () {
                                      _selectProgram(context, program.id);
                                    }, () {
                                      _deselectProgram(context, program.id);
                                    }),
                                    color: dark,
                                    iconColor: Colors.white,
                                    icon: Icon(
                                      Icons.more_horiz_sharp,
                                      size: 20.sp,
                                    ),
                                  )),
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
                              program.id == program.id
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
          ),
        ));
  }

  void _selectProgram(BuildContext context, int programId) {
    context.read<ProgramProvider>().callSetProgram(context, programId);
    // todo onRefresh
  }

  void _deselectProgram(BuildContext context, int programId) {
    context.read<ProgramProvider>().callUnSetProgram(context, programId);
    // todo onRefresh
  }

// onBackPress(BuildContext context, bool searching) {
//   this.searching ? searching = !searching :
//       Navigator.of(context).pop();
//
// }
}
