import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/net_image.dart';
import 'package:gym/features/chat/models/chat_model.dart';
import 'package:gym/features/chat/screens/chat_screen.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import '../styles/colors.dart';

class CoachListTile extends StatelessWidget {
  final UserModel coach;
  const CoachListTile(this.coach, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: assetImage(coach),
            maxRadius: 24.r,
          ),
        ],
      ),
      title: Text(coach.name, style: TextStyle(color: lightGrey, fontWeight: FontWeight.w500, fontSize: 12.sp),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(coach.phoneNumber, style: TextStyle(color: grey, fontWeight: FontWeight.w500, fontSize: 12.sp),),
          RatingBarIndicator(
            rating: coach.rate,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color:red,
            ),
            itemCount: 5,
            itemSize: 10.sp,
            itemPadding: EdgeInsets.only(top: 4.h),
            direction: Axis.horizontal,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(12.r),
      ),
      tileColor: dark,
      isThreeLine: true,
      onTap: (){
          ChatModel chatModel = ChatModel(sid2: UserModel(id: coach.id, name: coach.name, phoneNumber: "09", birthDate: DateTime(1997), role: "role", description: "description", rate: 2.0, expiration: DateTime(1997), finance: 10000, isPaid: true, images: []), latestMessage: LatestMessage(id: 1, content: "content", senderId: 2, receiverId: 3, createdAt: "1997"));
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: ChatScreen(
                    chatModel
                )
            ));
      },
    );
  }
}
