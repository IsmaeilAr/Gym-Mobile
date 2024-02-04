// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gym/components/widgets/coach_availability.dart';
// import 'package:gym/features/profile/provider/profile_provider.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:provider/provider.dart';
// import '../../../components/styles/colors.dart';
// import '../../../components/styles/decorations.dart';
// import '../../articles/screens/coach_articles_screen.dart';
// import '../../chat/screens/chat_screen.dart';
// import '../models/user_model.dart';
//
//
//
// int PopupMenuCases=2; // 1_ChangeCoach  2_SetCoach  3_RevokeRequest
//
// class CoachProfileScreen extends StatefulWidget {
//   final UserModel coach;
//   const CoachProfileScreen(this.coach, {super.key});
//
//   @override
//   State<CoachProfileScreen> createState() => _CoachProfileScreenState();
// }
//
// class _CoachProfileScreenState extends State<CoachProfileScreen> with TickerProviderStateMixin {
//
//   late final TabController _tabController;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_){
//       // context.read<ProfileProvider>().get(context);
//     });
//     super.initState();
//   }
//
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           TabBar.secondary(
//             controller: _tabController,
//             unselectedLabelColor: grey,
//             labelStyle: const TextStyle(color: primaryColor),
//             indicatorColor: primaryColor,
//             dividerColor: black,
//             tabs: const <Widget>[
//               Tab(text: 'Info'),
//               Tab(text: 'Articles'),
//             ],
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: <Widget>[
//                 CoachInfoTab(widget.coach),
//                 const CoachArticlesList(), // todo parameter
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           Navigator.push(
//               context,
//               PageTransition(
//                   type: PageTransitionType.fade,
//                   child: ChatScreen(widget.coach.id)
//               ));
//         },
//         backgroundColor: dark,
//         child: Icon(
//           Icons.chat,
//           size: 20.sp,
//           color: lightGrey,
//         ),
//       ),
//     );
//   }
// }
//
// class CoachInfoTab extends StatelessWidget {
// final UserModel coach;
//   const CoachInfoTab(this.coach, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 6.h,
//         horizontal: 9.w,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CoachImage(),
//           const InfoWithIconWidget(icon: Icons.phone, info: "Phone number"),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 19.w),
//             child: Text(
//               coach.phoneNumber,
//               style: MyDecorations.profileLight400TextStyle,
//             ),
//           ),
//           Padding(
//             padding:  EdgeInsets.only(top: 12.h),
//             child: const InfoWithIconWidget(icon: Icons.error, info: "Bio"),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 19.w),
//             child: Text(
//               coach.description,
//               style: MyDecorations.profileLight400TextStyle,
//             ),
//           ),
//           Padding(
//             padding:  EdgeInsets.only(top: 12.h),
//             child: const InfoWithIconWidget(icon: Icons.alarm_rounded, info: "Availability"),
//           ),
//           CoachAvailabilityWidget()
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
// class InfoWithIconWidget extends StatelessWidget {
//   final IconData icon;
//   final String info;
//
//   const InfoWithIconWidget({super.key, required this.icon, required this.info});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: lightGrey,
//           size: 15.sp,
//         ),
//         SizedBox(width: 6.w),
//         Text(
//           info,
//           style: MyDecorations.calendarTextStyle,
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class ChangeCoach extends StatefulWidget {
//   final String name;
//   const ChangeCoach({super.key, required this.name});
//
//   @override
//   State<ChangeCoach> createState() => _ChangeCoachState();
// }
//
// class _ChangeCoachState extends State<ChangeCoach> {
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: black,
//       surfaceTintColor: black,
//       actions: [
//         MaterialButton(
//           onPressed: () {},
//           color: black,
//           child: Text(
//             "Cancel",
//             style: MyDecorations.programsTextStyle,
//           ),
//         ),
//         SizedBox(width: 5.w),
//         MaterialButton(
//           onPressed: () {},
//           color: primaryColor,
//           child: Text(
//             "Change",
//             style: MyDecorations.coachesTextStyle,
//           ),
//         ),
//       ],
//       content: Text(
//         "Are you sure you want to change your current coach to ${widget.name} as your new coach?",
//         style: MyDecorations.coachesTextStyle,
//       ),
//     );
//   }
// }
//
//
//
//
// AppBar CoachesProfileAppBar(BuildContext context){
//   return
//     AppBar(
//       backgroundColor: black,
//       leading: IconButton(
//         color: lightGrey,
//         icon: Icon(Icons.arrow_back_ios_new,size: 24.sp,),
//         onPressed: () => Navigator.pop(context),
//       ),
//
//       title: Text(
//         "Coaches",
//         style: TextStyle(
//           color:  lightGrey,
//           fontSize: 18.sp,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       actions:
//       [
//         PopupMenuCases==1? PopupMenuButton<MenuItemChangeCoach>(
//             itemBuilder: (context) => [
//               ...MenuItemsChangeCoach.getMenuItems
//                   .map(buildItemChangeCoach)
//                   .toList(),
//             ],
//             onSelected: (item) =>
//                 onSelectedChangeCoach(context, item),
//             color: dark,
//             iconColor: Colors.white,
//             icon:Icon(Icons.more_horiz_sharp,size: 20.sp,)
//         ):PopupMenuCases==2?PopupMenuButton<MenuItemSetCoach>(
//             itemBuilder: (context) => [
//               ...MenuItemsSetCoach.getMenuItems
//                   .map(buildItemSetCoach)
//                   .toList(),
//             ],
//             onSelected: (item) =>
//                 onSelectedSetCoach(context, item),
//             color: dark,
//             iconColor: Colors.white,
//             icon:Icon(Icons.more_horiz_sharp,size: 20.sp,)
//         ):PopupMenuCases==3?PopupMenuButton<MenuItemRevokeRequest>(
//             itemBuilder: (context) => [
//               ...MenuItemsRevokeRequest.getMenuItems
//                   .map(buildItemRevokeRequest)
//                   .toList(),
//             ],
//             onSelected: (item) =>
//                 onSelectedRevokeRequest(context, item),
//             color: dark,
//             iconColor: Colors.white,
//             icon:Icon(Icons.more_horiz_sharp,size: 20.sp,)
//         ):Container(),
//       ] ,
//     );
// }
//
// class CoachImage extends StatelessWidget {
//   final UserModel coach;
//   const CoachImage(this.coach, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Center(
//       child: Column(
//         children: [
//           CircleAvatar(
//               radius: 90.r,
//               child: Image.network(coach.images[0].image, fit: BoxFit.fill,)
//           ),
//           Text(coach.name,style: TextStyle(
//             color: lightGrey,
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,),),
//           RatingBarIndicator(
//             rating: coach.rate,
//             itemBuilder: (context, index) => const Icon(
//               Icons.star,
//               color:red,
//             ),
//             itemCount: 5,
//             itemSize: 10.sp,
//             direction: Axis.horizontal,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 24.h),
//             child: isSelectedCoach ?
//             ElevatedButton(
//               onPressed: () {},
//               style:
//               ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
//               ),
//               child: Text(
//                 'Selected',
//                 style: TextStyle(
//                   color: lightGrey,
//                   fontFamily: "Saira",
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   height: 1.0,
//                 ),
//               ),
//             ) :
//             ElevatedButton(
//               onPressed: () {
//
//               },
//               style:
//               ElevatedButton.styleFrom(
//                 backgroundColor: dark,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
//               ),
//               child: Text(
//                 'Set coach',
//                 style: TextStyle(
//                   color: lightGrey,
//                   fontFamily: "Saira",
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w600,
//                   height: 1.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
