import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/coaches/screens/all_coaches_screen.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';

class FindCoachButton extends StatelessWidget {
  const FindCoachButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 296.w,
      height: 46.h,
      child: ElevatedButton(
          style: MyDecorations.profileButtonStyle(dark),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AllCoachesScreen()));
          },
          child: Text(
            AppLocalizations.of(context)!.myProfileFindCoachButton,
            style: MyDecorations.myButtonTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )),
    );
  }
}
