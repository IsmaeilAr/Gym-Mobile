import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/dialog/cancel_order_dialog.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/custom_app_bar.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:gym/features/programs/screens/program_pdf_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/dialog/cancel_button.dart';
import '../../../components/dialog/order_program_dialog.dart';
import '../../../components/pop_menu/pop_menu_set_program.dart';
import '../../../components/widgets/find_coach_button.dart';
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
    context.read<ProgramProvider>().getPremiumStatus(context, widget.genre);
    context.read<ProfileProvider>().callGetStatus(context);
    context.read<ProgramProvider>().getPremiumProgramsList(
          context,
          widget.genre,
        );
    checkStatus();
  }

  int premiumStatus = 0;
  int coachId =
      0; // todo try to change the approach (use the value only in the button)
  int orderId =
      0; // todo try to change the approach (use the value only in the button)

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
            ButtonStatus(premiumStatus, widget.genre, coachId, orderId),
          ]),
        ),
      ),
    );
  }

  void checkStatus() {
    List statusList;
    String premiumProgramStatus;
    (context.read<ProfileProvider>().status.hasCoach)
        ? {
            coachId = context.read<ProfileProvider>().status.myCoach.id,
            statusList = context.read<ProgramProvider>().premiumStatusList,
            if (statusList.isNotEmpty)
              {
                // there is requests
                premiumProgramStatus =
                    context.read<ProgramProvider>().premiumStatusList[0].status,
                orderId =
                    context.read<ProgramProvider>().premiumStatusList[0].id,
                if (premiumProgramStatus == 'accepted')
                  {premiumStatus = 2}
                else if (premiumProgramStatus == 'waiting')
                  {premiumStatus = 3}
              }
            else
              {
                // has no requests yet
                premiumStatus = 1,
              }
          }
        : // if player doesn't have coach
        {
            premiumStatus = 0,
          };
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

class ButtonStatus extends StatelessWidget {
  const ButtonStatus(this.buttonStatus, this.genre, this.coachId, this.orderId,
      {super.key});

  final int buttonStatus;
  final String genre;
  final int coachId;
  final int orderId;

  @override
  Widget build(BuildContext context) {
    switch (buttonStatus) {
      case 0: // find coach // no coach
        {
          return Column(
            children: [
              Text(
                AppLocalizations.of(context)!
                    .premiumNeedPersonalCoachForPremium,
                style: MyDecorations.premiumTextStyle,
                textAlign: TextAlign.center,
              ),
              const Gap(
                h: 12,
              ),
              const FindCoachButton(),
            ],
          );
        }
      case 1: // ask for first program button // has coach but no programs
        {
          return SizedBox(
            width: 296.w,
            height: 46.h,
            child: ElevatedButton(
                style: MyDecorations.myButtonStyle(primaryColor),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          AskForNewProgramDialog(genre, coachId));
                },
                child: Text(
                  AppLocalizations.of(context)!.premiumAskForProgram,
                  style: MyDecorations.myButtonTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          );
        }
      case 2: // ask for new program button // has coach but no programs
        {
          return SizedBox(
            width: 296.w,
            height: 46.h,
            child: ElevatedButton(
                style: MyDecorations.myButtonStyle(primaryColor),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          AskForNewProgramDialog(genre, coachId));
                },
                child: Text(
                  AppLocalizations.of(context)!.premiumAskForNewProgram,
                  style: MyDecorations.myButtonTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          );
        }
      case 3: // revoke program request // has coach but program is still pending
        {
          return Column(
            children: [
              Text(
                AppLocalizations.of(context)!.premiumProgramRequestProcessing,
                style: MyDecorations.programsTextStyle,
                textAlign: TextAlign.center,
              ),
              const Gap(
                h: 12,
              ),
              SizedBox(
                width: 296.w,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            RevokeProgramRequestDialog(orderId));
                  },
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
        }
      default:
        {
          return const SizedBox.shrink();
        }
    }
  }
}

