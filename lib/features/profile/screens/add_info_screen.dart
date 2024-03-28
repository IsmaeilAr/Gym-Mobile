import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/main_layout/main_layout.dart';
import 'package:gym/utils/extensions/double_or_null.dart';
import 'package:gym/utils/extensions/sizer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddInfoScreen extends StatelessWidget {
  AddInfoScreen({super.key});

  bool isClear = false;
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isClear,
      onPopInvoked: (didPop) {
        _onPop();
      },
      child: Container(
        decoration: backgroundDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            height: 800.h,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Gap(
                      h: 44,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainLayout()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.addInfoSkipKey,
                              style: TextStyle(
                                  color: lightGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            Gap(
                              w: 5.w,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: lightGrey,
                              size: 18.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(
                      h: 39,
                    ),
                    const Logo().sizer(h: 55, w: 116),
                    const Gap(
                      h: 60,
                    ),
                    const TopText(),
                    const Gap(
                      h: 64,
                    ),
                    const RegInfoForm(),
                    const Gap(
                      h: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // persistentFooterButtons:
        ),
      ),
    );
  }

  Future<void> _onPop() async {
    DateTime now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      showMessage('press again to exit', true);
      isClear = false;
    }
    isClear = true;
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
          SizedBox(
            width: 128.w,
            height: 47.h,
            child: Text(
              AppLocalizations.of(context)!.addInfoInsertKey,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: lightGrey,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Saira'),
            ),
          ),
          const Gap(
            h: 12,
          ),
          SizedBox(
            width: 220.w,
            height: 25.h,
            child: Text(
              AppLocalizations.of(context)!.addInfoYourPersonalInfoKey,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Saira'),
            ),
          ),
        ],
      ),
    );
  }
}

// const List<String> _listGender = [
//   'Male',
//   'Female',
// ];

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;
  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 332.w,
      height: 80.h,
      child: CustomDropdown<String>(
        closedFillColor: lightGrey,
        expandedFillColor: lightGrey,
        closedSuffixIcon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: grey,
        ),
        expandedSuffixIcon: const Icon(
          Icons.keyboard_arrow_up_outlined,
          color: grey,
        ),
        hintBuilder: (context, hint) {
          return Text(
            hint = AppLocalizations.of(context)!.myProfileGender,
            style: TextStyle(
                color: grey,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w400,
                fontSize: 15.sp),
          );
        },
        headerBuilder: (context, item) {
          return Text(
            item,
            style: TextStyle(
                color: grey,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w400,
                fontSize: 15.sp),
          );
        },
        listItemBuilder: (context, item) {
          return Text(
            item,
            style: TextStyle(
                color: grey,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w400,
                fontSize: 14.sp),
          );
        },
        items: [
          AppLocalizations.of(context)!.addInfogenderMale,
          AppLocalizations.of(context)!.addInfogenderFemale,
        ],
        onChanged: (value) {
          setState(() {});
          widget.controller.text = value;
        },
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
  late final GlobalKey _formKey;
  late final TextEditingController _genderController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _waistController;
  late final TextEditingController _neckController;
  late final TextEditingController _dobController;

  String? selectedGender;

  @override
  void dispose() {
    _genderController.dispose();
    _dobController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _neckController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _genderController = TextEditingController();
    _dobController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _waistController = TextEditingController();
    _neckController = TextEditingController();
    super.initState();
  }

  // Date picker
  // #########################################################
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              // specify the color you want for the calendar
              onPrimary: Colors
                  .red, // specify the color you want for the selected date
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime(2000),
      firstDate: DateTime(1940, 1),
      lastDate: DateTime(2016, 12),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dobController.text = formattedDate;
      });
    } else {
      showMessage("Birthdate is not selected", false); //todo localize
    }
  }

  // #########################################################

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GenderDropdown(
              controller: _genderController,
            ),
            TextFormField(
              readOnly: true,
              controller: _dobController,
              decoration: MyDecorations.myInputDecoration2(
                hint: AppLocalizations.of(context)!.addInfoBirthdateKey,
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: MyDecorations.myInputDecoration2(
                hint: AppLocalizations.of(context)!.addInfoHeightKey,
                suffix: "(${AppLocalizations.of(context)!.myProfileCm})",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: MyDecorations.myInputDecoration2(
                hint: AppLocalizations.of(context)!.addInfoWeightKey,
                suffix: "(${AppLocalizations.of(context)!.myProfileKg})",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _waistController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: MyDecorations.myInputDecoration2(
                hint: AppLocalizations.of(context)!.addInfoWaistKey,
                suffix: "(${AppLocalizations.of(context)!.myProfileCm})",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _neckController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: MyDecorations.myInputDecoration2(
                hint: AppLocalizations.of(context)!.addInfoNeckKey,
                suffix: "(${AppLocalizations.of(context)!.myProfileCm})",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(
              h: 10,
            ),
            SizedBox(
              width: 267.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_genderController.text.isNotEmpty) {
                    // submit personal info
                    doAddInfo(context);
                  } else {
                    showMessage(
                        AppLocalizations.of(context)!.pleaseSelectGenderKey,
                        false);
                  }
                },
                style: MyDecorations.myButtonStyle(red),
                child: Text(
                  AppLocalizations.of(context)!.addInfoContinueButtonKey,
                  style: MyDecorations.myButtonTextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doAddInfo(BuildContext context) {
    String englishGender = ensureEnglish(_genderController.text);
    context
        .read<ProfileProvider>()
        .callAddInfoApi(
          context,
          englishGender,
          _dobController.text,
          _heightController.text.parseToDoubleOrNull(),
          _weightController.text.parseToDoubleOrNull(),
          _waistController.text.parseToDoubleOrNull(),
          _neckController.text.parseToDoubleOrNull(),
        )
        .then((value) {
      if (value) {
        log("view status: $value");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainLayout()),
          (Route<dynamic> route) => false,
        );
        dispose();
      }
    });
  }

  String ensureEnglish(String text) {
    String thisGender;
    if (text == 'male' || text == 'female') {
      thisGender = text;
    } else if (text == 'أنثى') {
      thisGender = 'female';
    } else {
      thisGender = 'male';
    }
    return thisGender;
  }
}
