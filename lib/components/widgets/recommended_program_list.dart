import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/pop_menu/menu_item_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../features/programs/model/program_model.dart';
import '../../features/programs/screens/program_pdf_screen.dart';
import '../../features/programs/widgets/program_card.dart';
import '../pop_menu/pop_menu_set_program.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'net_image.dart';

class RecommendedProgramList extends StatelessWidget {
  final double listHeight, listWidth, imgHeight, imgWidth;
  final List<ProgramModel> programList;

  const RecommendedProgramList(
      {super.key,
      required this.listHeight,
      required this.listWidth,
      required this.imgHeight,
      required this.imgWidth,
      required this.programList});

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
            bool isSelected = true;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: PDFScreen(
                          programName: program.name,
                          programFileName: program.file,
                        )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 156.h,
                        width: 332.w,
                        child: Card(
                          elevation: 0,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.network(
                            program.imageUrl,
                            fit: BoxFit.fill,
                            errorBuilder: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10.w,
                          top: 0.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DownloadButton(program.name,
                                  'https://css4.pub/2015/icelandic/dictionary.pdf'),
                              // DownloadButton(program.name, program.file),
                              PopupMenuButton<MenuItemModel>(
                                itemBuilder: (context) {
                                  List<MenuItemModel> nowItems = [];
                                  isSelected
                                      ? nowItems.add(SetProgramsMenuItems
                                          .selectProgramItem)
                                      : nowItems.add(SetProgramsMenuItems
                                          .deselectProgramItem);
                                  return [
                                    ...nowItems.map(buildItem),
                                  ];
                                },
                                onSelected: (item) => onSelectSetProgram(
                                    context, item, program, () {
                                  _selectProgram(context, program.id);
                                }, () {
                                  _deselectProgram(context, program.id);
                                }),
                                color: dark,
                                iconColor: lightGrey,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 15.h),
                                  child: const Icon(
                                    Icons.more_horiz_sharp,
                                    size: 20,
                                    color: lightGrey,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Text(
                          program.name,
                          style: MyDecorations.programsTextStyle,
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        isSelected // todo get from status
                            ? Icon(
                                Icons.check_box,
                                color: grey,
                                size: 12.sp,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
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

