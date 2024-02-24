import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/coach_image.dart';
import 'package:gym/features/profile/models/player_metrics_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';
import '../../../components/widgets/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController heightController = TextEditingController();
TextEditingController weightController = TextEditingController();
TextEditingController waistController = TextEditingController();
TextEditingController neckController = TextEditingController();

File? _currentImagePath;

class EditProfile extends StatefulWidget {
  final UserModel profileInfo;
  final PlayerMetricsModel personalMetrics;
  final bool isEdit;

  const EditProfile({
    super.key,
    required this.isEdit,
    required this.profileInfo,
    required this.personalMetrics,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {





  @override
  void initState() {
    (widget.isEdit)
        ? {
            nameController.text = widget.profileInfo.name,
            phoneController.text = widget.profileInfo.phoneNumber,
            dobController.text = widget.personalMetrics.age.toString(),
            heightController.text = widget.personalMetrics.height.toString(),
            weightController.text = widget.personalMetrics.weight.toString(),
            waistController.text =
                widget.personalMetrics.waistMeasurement.toString(),
            neckController.text = widget.personalMetrics.neck.toString()
          }
        : {
            nameController.text = widget.profileInfo.name,
            phoneController.text = widget.profileInfo.phoneNumber,
          };
    super.initState();
  }


  Future<void> _pickImage() async {
    final pickImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      setState(() {
        _currentImagePath = File(pickImage.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EditAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 15.w,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: _currentImagePath == null
                                ? CircleAvatar(
                                    radius: 90.r,
                                    backgroundImage:
                                        coachImage(widget.profileInfo),
                                  )
                                : CircleAvatar(
                                    radius: 90.r,
                                    backgroundImage: FileImage(
                                      _currentImagePath!,
                                    ),
                                  ),
                          ),
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              backgroundColor: dark,
                              radius: 21.r,
                              child:  const Icon(Icons.camera_alt, color: lightGrey),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 109.w,
                        child: TextField(
                          controller: nameController,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextStyle(
                            color: lightGrey,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(
                  h: 24,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: grey,
                      size: 15.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      AppLocalizations.of(context)!.myProfilePhoneNumber,
                      style: MyDecorations.mySuffixTextStyle,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.w),
                  child: SizedBox(
                    width: 130.w,
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: lightGrey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  child: DividerWidget(
                      title: AppLocalizations.of(context)!
                          .myProfileDividerPersonalMetrics),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text(
                    "${AppLocalizations.of(context)!.myProfileBodyFat}${widget.personalMetrics.bfp} %",
                    style: MyDecorations.profileLight500TextStyle,
                  ),
                ),
                BuildProfileTextField(
                  labelText:
                      "${AppLocalizations.of(context)!.addInfoBirthdateKey}:",
                  controller: dobController,
                ),
                BuildProfileTextField(
                  labelText:
                      AppLocalizations.of(context)!.editProfileHeightLabel,
                  controller: heightController,
                ),
                BuildProfileTextField(
                  labelText:
                      AppLocalizations.of(context)!.editProfileWeightLabel,
                  controller: weightController,
                ),
                BuildProfileTextField(
                  labelText:
                      AppLocalizations.of(context)!.editProfileWaistLabel,
                  controller: waistController,
                ),
                BuildProfileTextField(
                  labelText: AppLocalizations.of(context)!.editProfileNeckLabel,
                  controller: neckController,
                ),
              ],
            ),
          ),
        )
    );
  }
}



class EditAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final BuildContext context;
  const EditAppBar(this.context, {super.key,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        color: lightGrey,
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 24.sp,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        AppLocalizations.of(context)!.myProfileEditButton,
        style: TextStyle(
          color: lightGrey,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          color: lightGrey,
          onPressed: () {
            context.read<ProfileProvider>().callEditInfo(
                  context,
                  nameController.text,
                  phoneController.text,
                  _currentImagePath,
                );
            context.read<ProfileProvider>().callEditMetrics(
                  context,
                  dobController.text,
                  heightController.text,
                  weightController.text,
                  waistController.text,
                  neckController.text,
                );
            context.read<ProfileProvider>().getProfileInfo(context);
            context.read<ProfileProvider>().getPersonalMetrics(context);
          },
          icon: Icon(
            Icons.check,
            size: 22.sp,
          ),
        ),
      ],
    );
  }
}

class BuildProfileTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const BuildProfileTextField({super.key, required this.labelText, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 9.h),
      child: SizedBox(
        width: 109.w,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          maxLength: 10,
          decoration: InputDecoration(
            suffixStyle: MyDecorations.profileLight400TextStyle,
            labelText: labelText,
            labelStyle: MyDecorations.mySuffixTextStyle,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
          style: MyDecorations.profileLight400TextStyle,
        ),
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {

  final String title;
  const DividerWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: dark,
                thickness: 1.h,
              ),
            ),
            Text(
              title,
              style: MyDecorations.profileGreyTextStyle,
            ),
            Expanded(
              child: Divider(
                color: dark,
                thickness: 1.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

