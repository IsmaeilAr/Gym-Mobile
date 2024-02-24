import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/features/coaches/screens/all_coaches_screen.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:provider/provider.dart';
import '../../features/coaches/provider/coach_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoCoachScreen extends StatelessWidget {
  const NoCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              // backgroundImage: AssetImage( "assets/images/profile1.png",),
              backgroundColor: grey,
              child: Icon(
                Icons.person,
                size: 20.r,
                color: lightGrey,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.myProfileNoCoachMessage,
              style: MyDecorations.profileLight500TextStyle,
            )),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 296.w,
          height: 46.h,
          child: ElevatedButton(
              style:MyDecorations.profileButtonStyle(dark),
              onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AllCoachesScreen()));
              },
              child: Text(
                AppLocalizations.of(context)!.myProfileFindCoachButton,
                style: MyDecorations.myButtonTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
      ],
    );
  }
}

class MyCoachWidget extends StatelessWidget {
  final UserModel coach;
  const MyCoachWidget(this.coach, {super.key,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Image.network(
                coach.images[0].image,
                fit: BoxFit.fill,
                height: 48.h,
                width: 48.w,
              ),
            ),
            SizedBox(width: 10.w),
            Text(coach.name, style: MyDecorations.profileLight500TextStyle),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {
            context.read<CoachProvider>().setCoach(
                context,
                coach
                    .id); // todo show confirmation dialog & ordered successfully snack-bar
          },
        )
      ],
    );
  }
}