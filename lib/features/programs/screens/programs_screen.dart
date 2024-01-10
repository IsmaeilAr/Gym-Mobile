import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import '../../coaches/screens/all_coaches_screen.dart';
import '../model/program_model.dart';

List<ProgramModel> recommended=[
  ProgramModel(title: 'Training', imgUrl: "assets/images/Rectangle 61.png"),
  ProgramModel(title: 'Nutrition', imgUrl: "assets/images/Rectangle 61.png"),
];
List<ProgramModel> training=[
  ProgramModel(title: 'Bulking', imgUrl: "assets/images/img.png"),
   ProgramModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
   ProgramModel(title: 'Cutting', imgUrl: "assets/images/img.png"),
];

List<ProgramModel> coaches=[
  ProgramModel(title: 'Eias', imgUrl: "assets/images/img1.png"),
  ProgramModel(title: 'Maya', imgUrl: "assets/images/img1.png"),
  ProgramModel(title: 'Lana', imgUrl: "assets/images/img1.png"),
];


class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.all( 16),
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
  List<ProgramModel> programModel;
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
  List<ProgramModel> programModel;
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


