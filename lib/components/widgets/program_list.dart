import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/menuItem_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:provider/provider.dart';
import '../../features/programs/model/program_model.dart';
import '../pop_menu/pop_menu_set_program.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';

class ProgramList extends StatelessWidget {
  final double listHeight, listWidth, imgHeight, imgWidth;
  final List<ProgramModel> programList;
  const ProgramList({super.key, required this.listHeight,required this.listWidth,required this.imgHeight,required this.imgWidth,required this.programList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight.h,
      width: listWidth.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programList.length,
          itemBuilder: (context, index) {
            ProgramModel program = programList[index];
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
                            ...SetProgramsMenuItems.getSetProgramMenuItems
                                .map(buildItem),
                          ],
                          onSelected: (item) =>
                              onSelectSetProgram(context, item, program, () {
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
              ],
            );
          }),
    );
  }

  void _selectProgram(BuildContext context, int programId) {
    context.read<ProgramProvider>().callSetProgram(context, programId);
    // todo onRefresh
  }

  void _deselectProgram(BuildContext context, int programId) {
    context.read<ProgramProvider>().callUnSetProgram(context, programId);
    // todo onRefresh
  }
}

