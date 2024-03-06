import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:gym/features/programs/screens/program_pdf_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/dialog/cancel_button.dart';
import '../../../components/pop_menu/pop_menu_set_program.dart';
import '../../../components/widgets/menu_item_model.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key, required this.genre});

  final String genre;
  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProgramProvider>().getPremiumProgramsList(
          context,
          widget.genre,
        );
  }

  @override
  Widget build(BuildContext context) {
    String type = (widget.genre == 'sport')
        ? AppLocalizations.of(context)!.programsTraining
        : AppLocalizations.of(context)!.programsNutrition;
    String title = "${AppLocalizations.of(context)!.premium}/$type";
    List<ProgramModel> premiumList =
        context.watch<ProgramProvider>().premiumProgramList;

    return Scaffold(
      appBar: CustomAppBar(title: title, context: context, search: false),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            !context.watch<ProgramProvider>().isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      premiumList.isEmpty
                          ? (widget.genre == 'sport')
                              ? NoPrograms(
                                  text1: AppLocalizations.of(context)!
                                      .premiumNoTrainingPrograms,
                                  text2: AppLocalizations.of(context)!
                                      .premiumNoSelectedTrainingProgram,
                                )
                              : NoPrograms(
                                  text1: AppLocalizations.of(context)!
                                      .premiumNoNutritionPrograms,
                                  text2: AppLocalizations.of(context)!
                                      .premiumnoSelectedNutritionProgram,
                                )
                          : ListPrograms(programModel: premiumList),
                    ],
                  )
                : const LoadingIndicatorWidget(),
            Expanded(child: Container()),
            const ButtonStatus(), //todo cases of this button is inside
          ]),
        ),
      ),
    );
  }
}

class ListPrograms extends StatelessWidget {
  final List<ProgramModel> programModel;

  const ListPrograms({super.key, required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      width: 333.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context, index) {
            ProgramModel program = programModel[index];
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
                        child: Image.network(
                          program.imageUrl,
                          fit: BoxFit.fill,
                          errorBuilder: (context, url, error) =>
                              const Icon(Icons.error),
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
                      program.id ==
                              program
                                  .id // todo compare with my selected program
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

class NoPrograms extends StatelessWidget {
  final String text1;
  final String text2;

  const NoPrograms({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 178.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text1,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: grey)),
            const Gap(h: 8),
            Text(
              text2,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonStatus extends StatefulWidget {
  const ButtonStatus({super.key});

  @override
  State<ButtonStatus> createState() => _ButtonStatusState();
}

class _ButtonStatusState extends State<ButtonStatus> {
  int status = 0;

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      return SizedBox(
        width: 296.w,
        height: 46.h,
        child: ElevatedButton(
            style: MyDecorations.myButtonStyle(primaryColor),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const AskForNewProgram());
            },
            child: Text(
              AppLocalizations.of(context)!.premiumAskForNewProgram,
              style: MyDecorations.myButtonTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            )),
      );
    } else if (status == 1) {
      return Column(
        children: [
          Text(
            AppLocalizations.of(context)!.premiumNeedPersonalCoachForPremium,
            style: MyDecorations.premiumTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 296.w,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () {},
              style: MyDecorations.myButtonStyle(dark),
              child: Text(
                AppLocalizations.of(context)!.premiumFindCoachButton,
                style: MyDecorations.myButtonTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (status == 2) {
      return Column(
        children: [
          Text(
            AppLocalizations.of(context)!.premiumProgramRequestProcessing,
            style: MyDecorations.programsTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 296.w,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () {},
              style: MyDecorations.myButtonStyle(dark),
              child: Text(
                AppLocalizations.of(context)!.premiumRevokeRequestButton,
                style: TextStyle(
                  color: primaryColor,
                  fontFamily: "Saira",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.0, // line height in terms of multiplier
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class AskForNewProgram extends StatefulWidget {
  const AskForNewProgram({super.key});

  @override
  State<AskForNewProgram> createState() => _AskForNewProgramState();
}

class _AskForNewProgramState extends State<AskForNewProgram> {
  bool? checkTraining = false;
  bool? checkNutrition = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      actions: [
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {},
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.send,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: SizedBox(
        height: 160.h,
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.requestProgramType,
              style: MyDecorations.coachesTextStyle,
            ),
            CheckboxListTile(
              value: checkTraining,
              onChanged: (newValue) {
                setState(() {
                  checkTraining = newValue;
                });
              },
              activeColor: grey,
              checkColor: black,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                AppLocalizations.of(context)!.trainingProgram,
                style: MyDecorations.programsTextStyle,
              ),
            ),
            CheckboxListTile(
              value: checkNutrition,
              onChanged: (newValue) {
                setState(() {
                  checkNutrition = newValue;
                });
              },
              activeColor: grey,
              checkColor: black,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                AppLocalizations.of(context)!.nutritionProgram,
                style: MyDecorations.programsTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
