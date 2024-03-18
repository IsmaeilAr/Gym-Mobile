import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:intl/intl.dart';
import 'components/styles/colors.dart';
import 'components/widgets/divider.dart';
import 'components/widgets/custom_app_bar.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter_svg/svg.dart';
import 'components/widgets/net_image.dart';
import 'features/profile/models/user_model.dart';

UserModel user = UserModel(
    id: 1,
    name: 'name',
    phoneNumber: 'phoneNumber',
    birthDate: DateTime(1999),
    role: 'player',
    description: 'description',
    rate: 2,
    expiration: DateTime(1999),
    finance: 100000,
    isPaid: true,
    images: []);

class Tester extends StatefulWidget {
  const Tester({super.key});

  @override
  State<Tester> createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  int _sectionVal = 0;
  int _genreVal = 0;
  List<String> sections = ['General', 'Premium'];
  List<String> genres = ['Training', 'Nutrition'];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: "Add Program",
        search: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            children: [
              titledDivider("Type"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRadioGroup(
                    title: "Section",
                    values: sections,
                    groupValue: _sectionVal,
                    onChanged: (value) {
                      setState(() => _sectionVal = value!);
                    },
                  ),
                  _buildRadioGroup(
                    title: "Genre",
                    values: genres,
                    groupValue: _genreVal,
                    onChanged: (value) {
                      setState(() => _genreVal = value!);
                    },
                  ),
                  if (_sectionVal == 0) ...[
                    Text(
                      "Category",
                      style: sectionTextStyle(),
                    ),
                    const CategoryDropdown(),
                  ],
                ],
              ),
              titledDivider("Content"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: sectionTextStyle(),
                  ),
                  const Gap(
                    h: 8,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: MyDecorations.myInputDecoration3(
                      hint: 'Name',
                    ),
                  ),
                  const Gap(
                    h: 12,
                  ),
                  Text(
                    "Duration",
                    style: sectionTextStyle(),
                  ),
                  const Gap(
                    h: 8,
                  ),
                  Container(
                    height: 53.h,
                    decoration: MyDecorations.myBoxDecoration(),
                    padding: EdgeInsets.all(12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'days',
                          style: TextStyle(
                              color: lightGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp),
                        ),
                        const Spacer(),
                        DaysCounterWidget(),
                      ],
                    ),
                  ),
                  const Gap(
                    h: 12,
                  ),
                  Text(
                    "Program",
                    style: sectionTextStyle(),
                  ),
                  BigButton(
                    () {},
                    'assets/svg/uploadfile.svg',
                    'Upload File',
                    'Supported formats: JPEG, PNG, GIF, MP4, PDF',
                  ),
                  Text(
                    "Cover",
                    style: sectionTextStyle(),
                  ),
                  BigButton(
                    () {},
                    'assets/svg/uploadcover.svg',
                    'Upload Cover',
                    'It is optional, there is a default Cover',
                  ),
                ],
              ),
              titledDivider("Players"),
              const Gap(
                h: 4,
              ),
              Row(
                children: [
                  ListPlayers(
                    listHeight: 80,
                    listWidth: 260,
                    playersList: [
                      user,
                      user,
                      user,
                      user,
                      user,
                      user,
                      user,
                      user,
                    ],
                  ),
                  SizedBox(
                    width: 66.w,
                    height: 67.h,
                    child: InkWell(
                      onTap: () {
                        //todo navigate to select players page
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: dark,
                            radius: 24.r,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 30.r,
                                color: grey,
                              ),
                            ),
                          ),
                          const Text(
                            'Add',
                            style: TextStyle(
                                color: grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(
                h: 24,
              ),
              SizedBox(
                width: 290.w,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: MyDecorations.myButtonStyle(red),
                  child: Text(
                    'Submit',
                    style: MyDecorations.myButtonTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Gap(
                h: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row titledDivider(String title) {
    return Row(
      children: [
        myDivider(),
        SizedBox(
          width: 102.w,
          child: Center(
            child: Text(
              title,
              style: MyDecorations.calendarTextStyle,
            ),
          ),
        ),
        myDivider(),
      ],
    );
  }

  TextStyle sectionTextStyle() {
    return TextStyle(
      color: lightGrey,
      fontFamily: "Saira",
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildRadioGroup({
    required String title,
    required List<String> values,
    required int groupValue,
    required ValueChanged<int?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: sectionTextStyle(),
        ),
        ...values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          return RadioListTile(
            activeColor: grey,
            contentPadding: EdgeInsets.zero,
            value: index,
            groupValue: groupValue,
            onChanged: onChanged,
            title: Align(
              alignment: Alignment(-1.2.w, 0),
              child: Text(
                value,
                style: TextStyle(
                  color: (groupValue == index) ? grey : lightGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Saira',
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

const List<String> _listCategory = [
  'Bulking',
  'Shredding',
  'Fitness',
  'Balanced',
];

final TextEditingController _genderController = TextEditingController();

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({
    super.key,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 332.w,
      height: 80.h,
      child: CustomDropdown<String>(
        closedFillColor: black,
        expandedFillColor: black,
        closedBorder: Border.all(color: grey, width: 1),
        closedBorderRadius: BorderRadius.circular(8.r),
        expandedBorder: Border.all(color: grey, width: 1),
        expandedBorderRadius: BorderRadius.circular(8.r),
        closedSuffixIcon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: lightGrey,
        ),
        expandedSuffixIcon: const Icon(
          Icons.keyboard_arrow_up_outlined,
          color: lightGrey,
        ),
        hintBuilder: (context, hint) {
          return Text(
            hint = "Category",
            style: TextStyle(
                color: lightGrey,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          );
        },
        headerBuilder: (context, item) {
          return Text(
            item,
            style: TextStyle(
                color: lightGrey,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          );
        },
        listItemBuilder: (context, item) {
          return Text(
            item,
            style: TextStyle(
                color: lightGrey,
                fontFamily: 'Saira',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp),
          );
        },
        items: _listCategory,
        onChanged: (value) {
          setState(() {});
          _genderController.text = value;
        },
      ),
    );
  }
}

class DaysCounterWidget extends StatefulWidget {
  final int initialValue;
  final NumberFormat formatter = NumberFormat("00");
  final ValueChanged<int>? onChanged;

  DaysCounterWidget({
    super.key,
    this.initialValue = 00,
    this.onChanged,
  });

  @override
  State<DaysCounterWidget> createState() => _DaysCounterWidgetState();
}

class _DaysCounterWidgetState extends State<DaysCounterWidget> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _counter++;
      widget.onChanged?.call(_counter);
    });
  }

  void _decrement() {
    if (_counter > 0) {
      setState(() {
        _counter--;
        widget.onChanged?.call(_counter);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedNumber = widget.formatter.format(_counter);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // todo change icon to figma design
        IconButton(
          icon: Icon(
            Icons.remove,
            size: 10.r,
          ),
          onPressed: _decrement,
        ),
        Text(
          formattedNumber,
          style: TextStyle(fontSize: 12.sp, color: grey),
        ),
        IconButton(
          icon: Icon(Icons.add, size: 10.r),
          onPressed: _increment,
        ),
      ],
    );
  }
}

class BigButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imgPath;
  final String firstText;
  final String secText;

  const BigButton(
    this.onTap,
    this.imgPath,
    this.firstText,
    this.secText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 157.h,
      width: 332.w,
      margin: EdgeInsets.fromLTRB(0, 8.h, 0, 12.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.r),
        onTap: onTap,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                      child: SvgPicture.asset(
                    'assets/svg/dashed_border.svg',
                    width: 332.w,
                    height: 157.h,
                  )),
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      height: 150.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset(
                            imgPath,
                            width: 60.w,
                            height: 60.w,
                          ),
                          Text(
                            firstText,
                            style: TextStyle(
                                color: grey,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            secText,
                            style: TextStyle(
                                color: grey,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListPlayers extends StatelessWidget {
  final double listHeight, listWidth;
  final List<UserModel> playersList;

  const ListPlayers(
      {super.key,
      required this.listHeight,
      required this.listWidth,
      required this.playersList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight.h,
      width: listWidth.w,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: playersList.length,
          itemBuilder: (context, index) {
            UserModel coach = playersList[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: networkImage(coach),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            // todo remove this player from list
                          },
                          child: CircleAvatar(
                            radius: 8.r,
                            backgroundColor: red,
                            child: Center(
                                child: Icon(
                              Icons.close,
                              size: 12.r,
                              color: lightGrey,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(coach.name, style: MyDecorations.programsTextStyle),
              ],
            );
          }),
    );
  }
}
