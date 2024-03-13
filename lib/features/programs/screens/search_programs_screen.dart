import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/programs/screens/program_pdf_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../components/pop_menu/pop_menu_set_program.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';
import '../../../components/widgets/loading_indicator.dart';
import '../../../components/widgets/menu_item_model.dart';
import '../../../components/widgets/search_app_bar.dart';
import '../model/program_model.dart';
import '../provider/program_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchProgramScreen extends StatelessWidget {
  const SearchProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        hint: AppLocalizations.of(context)!.searchInPrograms,
        searchFun: (value) {
          context.read<ProgramProvider>().callSearchProgram(context, value);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.h,
          horizontal: 14.w,
        ),
        child: context.watch<ProgramProvider>().isLoadingSearch
            ? const LoadingIndicatorWidget()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: context
                          .watch<ProgramProvider>()
                          .searchedPrograms
                          .length,
                      itemBuilder: (context, index) {
                        ProgramModel program;
                        program = context
                            .watch<ProgramProvider>()
                            .searchedPrograms[index];
                        return ProgramCard(
                          program: program,
                          selectProgramCallback: _selectProgram,
                          deSelectProgramCallback: _deselectProgram,
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
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

class ProgramCard extends StatelessWidget {
  const ProgramCard(
      {super.key,
      required this.program,
      required this.selectProgramCallback,
      required this.deSelectProgramCallback});

  final ProgramModel program;
  final void Function(BuildContext, int) selectProgramCallback;
  final void Function(BuildContext, int) deSelectProgramCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // go to program file
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
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
                  right: 0.w,
                  top: 0.h,
                  child: PopupMenuButton<MenuItemModel>(
                    itemBuilder: (context) => [
                      ...SetProgramsMenuItems.getSetProgramMenuItems
                          .map(buildItem),
                    ],
                    onSelected: (item) =>
                        onSelectSetProgram(context, item, program, () {
                      selectProgramCallback(context, program.id);
                    }, () {
                      deSelectProgramCallback(context, program.id);
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
      ),
    );
  }
}
