import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/coach.dart';
import 'package:gym/components/widgets/coach_image.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/payment.dart';
import 'package:gym/components/widgets/player_metrics_widget.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/player_metrics_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/profile/screens/edit_profile.dart';
import 'package:gym/utils/services/left_days_calculator.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfileInfo(context);
      context.read<ProfileProvider>().getPersonalMetrics(context);
      context.read<CoachProvider>().getCoachInfo(context,
      context.read<ProfileProvider>().status.coachId);
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProfileProvider>().getProfileInfo(context);
    context.read<ProfileProvider>().getPersonalMetrics(context);
    context.read<CoachProvider>().getCoachInfo(context,
        context.read<ProfileProvider>().status.coachId);  }

  @override
  Widget build(BuildContext context) {
    PlayerMetricsModel personalMetrics = context.watch<ProfileProvider>().personalMetrics;
    UserModel profileInfo = context.watch<ProfileProvider>().profileInfo;

    bool hasPersonalMetrics = (personalMetrics.weight != 0 &&
        personalMetrics.neck != 0 &&
        personalMetrics.waistMeasurement != 0 &&
        personalMetrics.height != 0 &&
        personalMetrics.gender != "not set");

    return (!context.watch<ProfileProvider>().isLoadingPersonalMetrics &&
            !context.watch<ProfileProvider>().isLoadingProfileInfo)
        ? RefreshIndicator(
      onRefresh: _refresh,
          child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 15.w,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 90.r,
                                child: userImage(profileInfo),
                              ),
                            ),
                            SizedBox(
                              width: 67.w,
                              height: 35.h,
                              child: MaterialButton(
                                  color: dark,
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditProfile(
                                            isEdit: true,
                                            profileInfo: profileInfo,
                                            personalMetrics: personalMetrics)));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Edit",
                                        style: MyDecorations.coachesTextStyle,
                                      ),
                                      Icon(
                                        Icons.edit,
                                        color: lightGrey,
                                        size: 12.sp,
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            profileInfo.name,
                            style: TextStyle(
                              color: lightGrey,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25.h),
                          child: const InfoWithIconWidget(
                              icon: Icons.phone, info: "Phone number"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: Text(
                            profileInfo.phoneNumber,
                            style: MyDecorations.profileLight400TextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h),
                          child: Row(
                            children: [
                              const InfoWithIconWidget(
                                  icon: Icons.attach_money, info: "Monthly fee"),
                              SizedBox(
                                width: 17.w,
                              ),
                              PaymentStatusWidget(isPaid: profileInfo.isPaid),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 19.w),
                          child: Text(
                            '${profileInfo.finance} s.p',
                            style: MyDecorations.profileLight400TextStyle,
                          ),
                        ),
                        profileInfo.isPaid
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 19.w),
                                child: Text(
                                  '${DateService.daysLeft(profileInfo.expiration)} days left',
                                  style: MyDecorations.profileLight400TextStyle,
                                ),
                              )
                            : const PayCashButton(),
                        SizedBox(height: 24.h),
                        const DividerWidget(title: "Personal Metrics"),
                        SizedBox(height: 21.h),
                        hasPersonalMetrics
                            ? PlayerMetricsWidget(personalMetrics)
                            : const AddInfoWidget(),
                        const DividerWidget(title: "Personal Coach"),
                        SizedBox(height: 10.h),
                      ],
                    ),
                    context.watch<ProfileProvider>()
                        .hasCoach // todo critical: get coach data from coachId when backend gives coachID
                        ? MyCoachWidget(UserModel(id: 1,
                            name: "Rami",
                            phoneNumber: "098569875",
                            birthDate: DateTime(1997),
                            role: "Coach",
                            description: "description",
                            rate: 4.5,
                            expiration: DateTime.now(),
                            finance: 50000,
                            isPaid: false,
                            images: [
                                ImageModel(
                                    id: 1, image: "assets/images/profile.png")
                              ]))
                        : const NoCoachScreen(),
                  ],
                ),
              ),
              //  ),
            ),
        )
        : const LoadingIndicatorWidget();
  }
}

class InfoWithIconWidget extends StatelessWidget {
  final IconData icon;
  final String info;

  const InfoWithIconWidget({super.key, required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: lightGrey,
          size: 15.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          info,
          style: MyDecorations.calendarTextStyle,
        ),
      ],
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

class AddInfoWidget extends StatelessWidget {
  const AddInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add your personal metrics to get your body fat and watch your progress",
          style: MyDecorations.profileGrey400TextStyle,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfile(
                      isEdit: false,
                      profileInfo: UserModel(
                        id: 1,
                        name: "John Doe",
                        phoneNumber: "1234567890",
                        birthDate: DateTime(1990, 10, 15),
                        role: "user",
                        description:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                        rate: 4.5,
                        expiration: DateTime(2023, 12, 31),
                        finance: 1000000,
                        isPaid: true,
                        images: [
                          ImageModel(id: 1, image: "image1.jpg"),
                        ],
                      ),
                      personalMetrics: PlayerMetricsModel(
                        id: 1,
                        gender: "Male",
                        birthDate: DateTime(1990, 10, 15),
                        age: 30,
                        weight: 80,
                        waistMeasurement: 90,
                        neck: 40,
                        height: 180,
                        bfp: 18.5,
                      ),
                    )));
          },
          child: Text(
            "Tap to add +",
            style: MyDecorations.profileLight500TextStyle,
          ),
        ),
      ],
    );
  }
}
