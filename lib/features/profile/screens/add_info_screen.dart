import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/features/main_layout.dart';
import 'package:gym/utils/extensions/sizer.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';


const List<String> _listGender = [
  'Male',
  'Female',
];
final TextEditingController _genderController = TextEditingController();
final TextEditingController _dobController = TextEditingController();

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
                const Gap(
                  h: 44,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainLayout()),
                          (Route<dynamic> route) => false,
                    );
                  }, child: Text("skip", style: TextStyle(color: lightGrey, fontWeight: FontWeight.w600, fontSize: 16.sp),),
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
            style: TextStyle(
                color: lightGrey,
                fontSize: 30.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Saira'),
          ).sizer(h: 47, w: 128),
          const Gap(
            h: 12,
          ),
          Text(
            'Your Personal Info',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: grey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'Saira'),
          ).sizer(
            w: 252,
            h: 31,
          ),
        ],
      ),
    );
  }
}

class GenderList extends StatefulWidget {
  const GenderList({super.key});

  @override
  State<GenderList> createState() => _GenderListState();
}

class _GenderListState extends State<GenderList> {
  bool _showGender = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            style: ListTileStyle.list,
            onTap: () {
              setState(() {
                _showGender = !_showGender;
              });
            },
            title: Text(
              "_GenderController.value.toString()",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: lightGrey),
            ),
            trailing: Icon(
              _showGender
                  ? Icons.keyboard_arrow_up_outlined
                  : Icons.keyboard_arrow_down_outlined,
              color: grey,
              size: 15.sp,
            ),
          ),
          Visibility(
            visible: _showGender,
            child: ListTile(
              onTap: () {},
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: const Icon(
                  Icons.radio_button_checked_outlined,
                  color: lightGrey,
                ),
              ),
              title: Text(
                'English',
                style: TextStyle(
                    fontSize: 10.sp, fontWeight: FontWeight.w400, color: grey),
              ),
            ),
          ),
          Visibility(
            visible: _showGender,
            child: ListTile(
              onTap: () {},
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: const Icon(
                  Icons.radio_button_off_outlined,
                  color: lightGrey,
                ),
              ),
              title: Text(
                'Arabic',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: lightGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({
    super.key,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      closedFillColor: lightGrey,
      hintText: 'Select Gender',
      items: _listGender,
      initialItem: _listGender[0],
      onChanged: (value) {
        setState(() {});
        _genderController.text = value;
      },
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
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    // selectedGender = null;
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _waistController.dispose();
    _neckController.dispose();
    super.dispose();
  }

  // Date picker
  // #########################################################
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: black,
                onPrimary: red,
                // onSurface: grey,
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
        lastDate: DateTime(2016, 12));
    DatePickerEntryMode.calendarOnly;

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dobController.text = formattedDate;
      }
      );
    } else {
       showMessage("Birthdate is not selected", false);
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
            const GenderDropdown(),
            const Gap(h: 10),
            TextFormField(
              readOnly: true,
              controller: _dobController,
              decoration: MyDecorations.myInputDecoration2(
                hint: "Birthdate",
              ),
              onTap: (){
                _selectDate(context);
              },
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                hint: "Height",
                // suffix: "(cm)",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                hint: "Weight",
                // suffix: "(kg)",
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _waistController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                hint: "Waist",
                suffix: Text(
                  "(cm)",
                  style: MyDecorations.mySuffixTextStyle,
                ),
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _neckController,
              keyboardType: TextInputType.number,
              decoration: MyDecorations.myInputDecoration2(
                hint: "Neck",
                // suffix: "(cm)",
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
                  if (_formKey.currentState!.validate()) {
                    // submit personal info
                    doAddInfo(context);
                  }
                },
                style: MyDecorations.myButtonStyle(red),
                child: Text(
                  'Continue',
                  style: MyDecorations.myButtonTextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
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
      _genderController.text,
      _dobController.text,
      double.parse(_heightController.text),
      double.parse(_weightController.text),
      double.parse(_waistController.text),
      double.parse(_neckController.text),
    )
        .then((value) {
          log("#1");
      if (value) {
        log("#2");
        log("view status: $value");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainLayout()),
              (Route<dynamic> route) => false,
        );
        dispose();
      }
    });
  }
}