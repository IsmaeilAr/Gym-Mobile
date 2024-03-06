import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/coach.dart';
import 'package:gym/components/widgets/net_image.dart';
import 'package:gym/components/widgets/gap.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../components/styles/gym_icons.dart';
import '../../../components/widgets/divider.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context.read<ProfileProvider>().getProfileInfo(context);
    context.read<ProfileProvider>().getPersonalMetrics(context);
    context.read<CoachProvider>().getCoachInfo(
        context, context.read<ProfileProvider>().status.myCoach.id);
  }

  @override
  Widget build(BuildContext context) {
    PlayerMetricsModel personalMetrics =
        context.watch<ProfileProvider>().personalMetrics;
    UserModel profileInfo = context.watch<ProfileProvider>().profileInfo;
    UserModel myCoach = context.watch<CoachProvider>().coachInfo;
    bool hasPersonalMetrics =
        context.watch<ProfileProvider>().personalMetrics.id != 0;

    return (!context.watch<ProfileProvider>().isLoadingPersonalMetrics &&
            !context.watch<ProfileProvider>().isLoadingProfileInfo)
        ? RefreshIndicator(
            color: red,
            backgroundColor: dark,
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
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 90.r,
                                backgroundImage: assetImage(profileInfo),
                              ),
                            ),
                            SizedBox(
                              width: 67.w,
                              height: 35.h,
                              child: MaterialButton(
                                  color: dark,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => EditProfile(
                                                isEdit: true,
                                                profileInfo: profileInfo,
                                                personalMetrics:
                                                    personalMetrics)));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .myProfileEditButton,
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
                        const Gap(h: 8),
                        Align(
                          alignment: AlignmentDirectional.center,
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
                          child: InfoWithIconWidget(
                              icon: GymIcons.phoneFilled,
                              info: AppLocalizations.of(context)!
                                  .myProfilePhoneNumber),
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
                              InfoWithIconWidget(
                                  icon: GymIcons.fee,
                                  info: AppLocalizations.of(context)!
                                      .myProfileMonthlyFee),
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
                            '${profileInfo.finance} ${AppLocalizations.of(context)!.myProfileFinance}',
                            style: MyDecorations.profileLight400TextStyle,
                          ),
                        ),
                        profileInfo.isPaid
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 19.w),
                                child: Text(
                                  '${DateService.daysLeft(profileInfo.expiration)} ${AppLocalizations.of(context)!.myProfileDaysLeft}',
                                  style: MyDecorations.profileLight400TextStyle,
                                ),
                              )
                            : const PayCashButton(),
                        SizedBox(height: 24.h),
                        DividerWidget(
                            title: AppLocalizations.of(context)!
                                .myProfileDividerPersonalMetrics),
                        SizedBox(height: 21.h),
                        hasPersonalMetrics
                            ? PlayerMetricsWidget(personalMetrics)
                            : const AddInfoWidget(),
                        DividerWidget(
                            title: AppLocalizations.of(context)!
                                .myProfileDividerPersonalCoach),
                        SizedBox(height: 10.h),
                      ],
                    ),
                    context
                            .watch<ProfileProvider>()
                            .status
                            .hasCoach // todo critical: get coach data from coachId when backend gives coachID
                        ? MyCoachWidget(myCoach)
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
              child: myDivider(),
            ),
            Text(
              title,
              style: MyDecorations.profileGreyTextStyle,
            ),
            Expanded(child: myDivider()),
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
          AppLocalizations.of(context)!.myProfileAddInfoAddPersonalMetrics,
          style: MyDecorations.profileGrey400TextStyle,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfile(
                      isEdit: false,
                      profileInfo: UserModel(
                        id: 0,
                        name: "Player",
                        phoneNumber: "not set",
                        birthDate: DateTime(2023),
                        role: "Player",
                        description: "",
                        rate: 0,
                        expiration: DateTime.now(),
                        finance: 0,
                        isPaid: false,
                        images: [],
                      ),
                      personalMetrics: PlayerMetricsModel(
                        id: 0,
                        gender: 'not set',
                        age: 0,
                        weight: 0,
                        waistMeasurement: 0,
                        neck: 0,
                        height: 0,
                        bfp: 0,
                      ),
                    )));
          },
          child: Text(
            AppLocalizations.of(context)!.myProfileAddInfoTapToAdd,
            style: MyDecorations.profileLight500TextStyle,
          ),
        ),
      ],
    );
  }
}
