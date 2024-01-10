import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/drop_down.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/utils/extensions/sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../provider/profile_provider.dart';

class AddInfoScreen extends StatelessWidget {
  const AddInfoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Gap(h: 108,),
                const Logo().sizer(h: 55, w: 116),
                const Gap(h: 60,),
                const TopText(),
                const Gap(h: 64,),
                const RegInfoForm(),
                const Gap(h: 50,),
              ],
            ),
          ),
        ),
        // persistentFooterButtons:
      ),
    );
  }
}


BoxDecoration backgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          'assets/images/background-login.png',
        ),
        fit: BoxFit.cover,
      ),
    );
  }


class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/Logo.svg',
      semanticsLabel: 'Gym Logo',
      // height: 100,
      // width: 70,
    );
  }
}

class TopText extends StatelessWidget {
  const TopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Insert',
            textAlign: TextAlign.center,
            style: TextStyle(color: lightGrey, fontSize: 30.sp, fontWeight: FontWeight.w500, fontFamily: 'Saira'),
          ).sizer(h: 47, w: 128),
          const Gap(
            h: 12,
          ),
          Text(
            'Your Personal Info',
            textAlign: TextAlign.center,
            style: TextStyle(color: grey, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Saira'),
          ).sizer(
            w: 252,
            h: 31,
          ),
        ],
      ),
    );
  }
}

class RegInfoForm extends StatefulWidget {
  const RegInfoForm({super.key});

  @override
  State<RegInfoForm> createState() => _RegInfoFormState();
}

class _RegInfoFormState extends State<RegInfoForm> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _GenderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();


  String? selectedGender;

  @override
  void dispose() {
    selectedGender = null;
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _neckController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // const CustomDropdownMenu(),
            const GenderDropdown(),

            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                  hint: "Height",
                  // suffix: "(cm)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your height';
                }
                return null;
              },
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                  hint: "Weight",
                  // suffix: "(kg)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your weight';
                }
                return null;
              },
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _waistController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                  hint: "Waist",
                  suffix: Text("(cm)", style: MyDecorations.mySuffixTextStyle,),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your waist size';
                }
                return null;
              },
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _neckController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                  hint: "Neck",
                  // suffix: "(cm)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your neck size';
                }
                return null;
              },
            ),
            const Gap(h: 10,),
            SizedBox(
              width: 267.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // submit personal info
                    doAddInfo(context);
                    // dispose
                    // dispose();
                  }
                },
                style: MyDecorations.myButtonStyle(red),
                child: Text(
                  'Continue',
                  style: MyDecorations.myButtonTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
                    ],
        ),
      ),
    );
  }
  void doAddInfo(BuildContext context) {
    context
        .read<ProfileProvider>()
        .callAddInfoApi(
      context,
      context.read<ProfileProvider>().gender,
      double.parse(_heightController.text),
      double.parse(_weightController.text),
      double.parse(_waistController.text),
      double.parse(_neckController.text),
    )
        .then((value) {
      if (value) {
        log("view status: $value");
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: const AddInfoScreen()));
        dispose();
      }
    });
  }
}

