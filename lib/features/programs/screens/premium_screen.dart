import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:provider/provider.dart';


class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgramProvider>().getPremiumProgramsList(
            context,
            "Food",
          );
      context.read<ProgramProvider>().getPremiumProgramsList(
            context,
            "Sport",
          );
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProgramProvider>().getPremiumProgramsList(
          context,
          "Food",
        );
    context.read<ProgramProvider>().getPremiumProgramsList(
          context,
          "Sport",
        );
  }

  @override
  Widget build(BuildContext context) {
    List<ProgramModel> sportList =
        context.watch<ProgramProvider>().sportProgramList;
    List<ProgramModel> nutList =
        context.watch<ProgramProvider>().nutritionProgramList;

    return Scaffold(
      appBar: ProgramsAppBar(title: "Premium", context: context, search: false),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Training",
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: Divider(
                      color: dark,
                      thickness: 1.h,
                    )),
                  ],
                ),
                sportList.isEmpty
                    ? const NoPrograms(
                        text1: "No Training Programs",
                        text2:
                            " You haven't selected a training program yet. Ask for your training program.",
                      )
                    : ListPrograms(programModel: sportList),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Text(
                      "Nutrition",
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                        child: Divider(
                      color: dark,
                      thickness: 1.h,
                    )),
                  ],
                ),
                nutList.isEmpty
                    ? const NoPrograms(
                        text1: "No Nutrition Programs",
                        text2:
                            "You haven't selected a nutrition program yet. Ask for your nutrition program.",
                      )
                    : ListPrograms(programModel: nutList),
              ],
            ),
            Expanded(child: Container()),
            const ButtonStatus(),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 156.h,
                  width: 243.w,
                  child: GestureDetector(
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset(
                        program.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Text(
                  program.name,
                  style: MyDecorations.programsTextStyle,
                ),
              ],
            );
          }),
    );
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
              style: const TextStyle(
                fontSize: 12,
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
                  context: context, builder: (context) => const AskForNewProgram());
            },
            child: Text(
              "Ask For A New Program",
              style: MyDecorations.myButtonTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )),
      );
    } else if (status == 1) {
      return Column(
        children: [
          Text(
            "You need to have a personal coach to request a premium program.",
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
                'Find coach',
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
            "Your program request is currently being processed",
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
                'Revoke request',
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
      return Container();
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
        MaterialButton(
          onPressed: () {},
          color: black,
          child: Text(
            "Cancel",
            style: MyDecorations.programsTextStyle,
          ),
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {},
          color: primaryColor,
          child: Text(
            "Send",
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: SizedBox(
        height: 160.h,
        child: Column(
          children: [
            Text(
              "Select the type of program you'd like to request from your coach:",
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
                "Training program",
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
                "Nutrition program",
                style: MyDecorations.programsTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
