import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<UserModel> coaches = [
  UserModel(
    name: "Eias Saleh",
    rate: 5,
    phoneNumber: '0987654321',
    birthDate: DateTime(2023),
    role: 'coach',
    description: "Republic Champ",
    expiration: DateTime(2023),
    finance: 0,
    isPaid: false,
    images: [ImageModel(id: 1, image: "image")], id: 1,
  ),
];
final int myCoachId = 1; // todo cache the selected coach ID after get all coaches

class AllCoachesScreen extends StatefulWidget {
  const AllCoachesScreen({super.key});
  @override
  State<AllCoachesScreen> createState() => _AllCoachesScreenState();
}

class _AllCoachesScreenState extends State<AllCoachesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProgramsAppBar(
          title: AppLocalizations.of(context)!.coaches,
          context: context,
          search: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: coaches.length,
              itemBuilder: (context, index) {
                UserModel coach = coaches[index];
                return Container(
                    height: 90.h,
                    width: 332.w,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: dark,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          child: AllCoachesWidget(coach: coach),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              size: 19.sp,
                            )),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AllCoachesWidget extends StatelessWidget {
  final UserModel coach;
  const AllCoachesWidget({super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              child: Image.asset(
                coach.images[0].image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(coach.name,
                        style: MyDecorations.coachesTextStyle),
                    SizedBox(
                      width: 5.w,
                    ),
                    coach.id == myCoachId
                        ? Icon(
                            Icons.check_box,
                            color: Colors.white,
                            size: 12.sp,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                Text(coach.description,
                    style: MyDecorations.programsTextStyle),
                RatingBarIndicator(
                  rating: coach.rate.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: red,
                  ),
                  itemCount: 5,
                  itemSize: 10.sp,
                  direction: Axis.horizontal,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
