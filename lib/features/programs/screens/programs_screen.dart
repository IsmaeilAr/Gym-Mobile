import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import '../../coaches/screens/all_coaches_screen.dart';
import '../../home/screens/main_layout.dart';
import '../model/programs_model.dart';

List<ProgramsModel> recommended=[
  ProgramsModel(title: 'Training', imgUrl: "assets/images/Rectangle 61.png"),
  ProgramsModel(title: 'Nutrition', imgUrl: "assets/images/Rectangle 61.png"),
];
List<ProgramsModel> training=[
  ProgramsModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
   ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
   ProgramsModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];

List<ProgramsModel> coaches=[
  ProgramsModel(title: 'Eias', imgUrl: "assets/images/img1.png"),
  ProgramsModel(title: 'Maya', imgUrl: "assets/images/img1.png"),
  ProgramsModel(title: 'Lana', imgUrl: "assets/images/img1.png"),
];


class ProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recommended",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600 ),),
              ListPrograms(ListHight:191,Listwidth:328,imgHight:168,imgWidth:162,programModel: recommended),
              Row(
                children: [
                  Text("Training",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10.w,),
                  Expanded(child: Image.asset("assets/images/Line.png"))
                ],
              ),
              ListPrograms(ListHight:180,Listwidth:333,imgHight:156,imgWidth:243,programModel: training),
              Row(
                children: [
                  Text("Nutrition",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10.w,),
                  Expanded(child: Image.asset("assets/images/Line.png"))
                ],
              ),
              ListPrograms(ListHight:180,Listwidth:333,imgHight:156,imgWidth:243,programModel: training),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("Coaches",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                   TextButton(
                     onPressed: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllCoachesScreen()));
                     },
                     child:Text("See All",style:TextStyle(color: lightGrey,fontSize: 16.sp,fontWeight: FontWeight.w600),) ,
                   )
                 ],
               ),
              ListCoaches(ListHight:80,Listwidth:198,programModel: coaches),
            ],
          ),
        ),
      ),
    );
  }
}



class ListPrograms extends StatelessWidget {
  double ListHight,Listwidth,imgHight,imgWidth;
  List<ProgramsModel> programModel;
  ListPrograms({required this.ListHight,required this.Listwidth,required this.imgHight,required this.imgWidth,required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ListHight.h,
      width: Listwidth.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: imgHight.h,
                  width: imgWidth.w,
                  child: GestureDetector(
                    onTap: (){},
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Image.asset(programModel[index].imgUrl,fit: BoxFit.fill,),
                    ),
                  ),
                ),
                Text(programModel[index].title,style:MyDecorations.programsTextStyle,),
              ],
            );
          }
      ),
    );
  }
}

class ListCoaches extends StatelessWidget {

  double ListHight,Listwidth;
  List<ProgramsModel> programModel;
  ListCoaches({required this.ListHight,required this.Listwidth,required this.programModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ListHight.h,
      width: Listwidth.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: programModel.length,
          itemBuilder: (context,index){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child :Image.asset( programModel[index].imgUrl,fit: BoxFit.fill,height: 48.h,width: 48.w,), ),
                  ),
                ),
                Text(programModel[index].title,style: MyDecorations.programsTextStyle),
              ],
            );
          }
      ),
    );
  }
}


