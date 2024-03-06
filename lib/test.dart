import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/decorations.dart';
import 'components/styles/colors.dart';
import 'components/widgets/divider.dart';
import 'components/widgets/programs_app_bar.dart';

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
  List<String> category = ['Bulking', 'Shredding'];

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
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titledDivider("Type"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Section",
                    style: sectionTextStyle(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      0,
                      1,
                    ]
                        .map(
                          (int index) => RadioListTile(
                            activeColor: grey,
                            contentPadding: EdgeInsets.zero,
                            value: index,
                            groupValue: _sectionVal,
                            onChanged: (value) {
                              setState(() => _sectionVal = value!);
                            },
                            title: Align(
                                alignment: const Alignment(-1.2, 0),
                                child: Text(
                                  sections[index],
                                  style: TextStyle(
                                      color: (_sectionVal == index)
                                          ? grey
                                          : lightGrey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Saira'),
                                )),
                          ),
                        )
                        .toList(),
                  ),
                  Text(
                    "Genre",
                    style: sectionTextStyle(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      0,
                      1,
                    ]
                        .map(
                          (int index) => RadioListTile(
                            activeColor: grey,
                            contentPadding: EdgeInsets.zero,
                            value: index,
                            groupValue: _genreVal,
                            onChanged: (value) {
                              setState(() => _genreVal = value!);
                            },
                            title: Align(
                                alignment: const Alignment(-1.2, 0),
                                child: Text(
                                  genres[index],
                                  style: TextStyle(
                                      color: (_genreVal == index)
                                          ? grey
                                          : lightGrey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Saira'),
                                )),
                          ),
                        )
                        .toList(),
                  ),
                  (_sectionVal == 1)
                      ? Text(
                          "Category",
                          style: sectionTextStyle(),
                        )
                      : SizedBox.shrink(),
                  Text(
                    "Name",
                    style: sectionTextStyle(),
                  ),
                  Text(
                    "Duration",
                    style: sectionTextStyle(),
                  ),
                  Text(
                    "Program",
                    style: sectionTextStyle(),
                  ),
                  Text(
                    "Cover",
                    style: sectionTextStyle(),
                  ),
                ],
              )
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            title,
            style: MyDecorations.calendarTextStyle,
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
}
