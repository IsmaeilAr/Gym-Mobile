import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import '../../../components/widgets/programs_app_bar.dart';
import '../model/programs_model.dart';

List<ProgramsModel> training = [
  // ProgramsModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
  // ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
  // ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];
List<ProgramsModel> nutrition = [
  ProgramsModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
  ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
  ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];

class PremiumScreen extends StatefulWidget {
  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: programsAppBar(title: "Premium", context: context, search: false),
      body: Padding(
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
                  Expanded(child: Image.asset("assets/images/Line.png"))
                ],
              ),
              training.isEmpty
                  ? NoPrograms(
                      text1: "No Training Programs",
                      text2:
                          " You haven't selected a training program yet. Ask for your training program.",
                    )
                  : ListPrograms(programModel: training),
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
                  Expanded(child: Image.asset("assets/images/Line.png"))
                ],
              ),
              nutrition.isEmpty
                  ? NoPrograms(
                      text1: "No Nutrition Programs",
                      text2:
                          "You haven't selected a nutrition program yet. Ask for your nutrition program.",
                    )
                  : ListPrograms(programModel: nutrition),
            ],
          ),
          Expanded(child: Container()),
          ButtonStatus(),
        ]),
      ),
    );
  }
}

class ListPrograms extends StatelessWidget {
  List<ProgramsModel> programModel;

  ListPrograms({required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      width: 333.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context, index) {
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
                        programModel[index].imgUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Text(
                  programModel[index].title,
                  style: MyDecorations.programsTextStyle,
                ),
              ],
            );
          }),
    );
  }
}

class NoPrograms extends StatelessWidget {
  String text1;
  String text2;

  NoPrograms({required this.text1, required this.text2});

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
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: grey)),
            const Gap(h: 8),
            Text(
              text2,
              style: TextStyle(
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
  @override
  State<ButtonStatus> createState() => _ButtonStatusState();
}

class _ButtonStatusState extends State<ButtonStatus> {
  int status = 0;

  @override
  Widget build(BuildContext context) {
    if (status == 0)
      return ElevatedButton(
          style: MyDecorations.myButtonStyle(primaryColor),
          onPressed: () {
            showDialog(
                context: context, builder: (context) => AskForNewProgram());
          },
          child: Text(
            "Ask For A New Program",
            style: MyDecorations.myButtonTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ));
    else if (status == 1)
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
    else if (status == 2)
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
    else
      return Container();
  }
}

class AskForNewProgram extends StatefulWidget {
  const AskForNewProgram({Key? key}) : super(key: key);

  @override
  State<AskForNewProgram> createState() => _AskForNewProgramState();
}

class _AskForNewProgramState extends State<AskForNewProgram> {
  bool? checkeTraining = false;
  bool? checkeNutrition = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
     surfaceTintColor: black,
     // shadowColor: black,
      //elevation: 24.0,
      actions: [
        MaterialButton(
          onPressed: () {},
          child: Text(
            "Cancel",
            style: MyDecorations.programsTextStyle,
          ),
          color: black,
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {},
          child: Text(
            "Send",
            style: MyDecorations.coachesTextStyle,
          ),
          color: primaryColor,
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
              value: checkeTraining,
              onChanged: (newValue) {
                setState(() {
                  checkeTraining = newValue;
                });
              },
              activeColor: grey,
              checkColor: black,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Training program",
                style: MyDecorations.programsTextStyle,
              ),
              //tristate: true,
            ),
            CheckboxListTile(
              value: checkeNutrition,
              onChanged: (newValue) {
                setState(() {
                  checkeNutrition = newValue;
                });
              },
              activeColor: grey,
              checkColor: black,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Nutrition program",
                style: MyDecorations.programsTextStyle,
              ),
              //tristate: true,
            ),
          ],
        ),
      ),
    );
  }
}
