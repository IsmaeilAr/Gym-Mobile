import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/coach_image.dart';
import '../../features/profile/models/user_model.dart';
import '../styles/decorations.dart';

class ListCoaches extends StatelessWidget {

  double listHeight, listWidth;
  List<UserModel> coachesList;
  ListCoaches({super.key, required this.listHeight, required this.listWidth, required this.coachesList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight.h,
      // width: listWidth.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: coachesList.length,
          itemBuilder: (context,index){
            UserModel coach = coachesList[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: CircleAvatar(
                      radius: 24.r,
                      backgroundImage:coachImage(coach),
                      ),

                  ),
                ),
                Text(coach.name,style: MyDecorations.programsTextStyle),
              ],
            );
          }
      ),
    );
  }

}
