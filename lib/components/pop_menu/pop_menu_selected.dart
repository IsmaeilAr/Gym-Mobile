// import 'package:flutter/material.dart';
// import 'package:gym/components/widgets/menuItem_model.dart';
// import 'package:gym/features/profile/models/user_model.dart';
// import '../dialog/set_coach_dialog.dart';
// import '../dialog/set_programs_dialog.dart';
//
// class SelectedMenuItems {
//   static const itemSelected =
//       MenuItemModel(text: 'Select', icon: Icons.check_box);
//   static const itemDesSelected =
//       MenuItemModel(text: 'Deselect', icon: Icons.close);
//
//   static const List<MenuItemModel> getSelectedMenuItems = [
//     itemSelected,
//     itemDesSelected
//   ];
// }
//
//
// class MenuHandler {
//
//   static void onSelected(
//       BuildContext context,
//       MenuItemModel item,
//       UserModel coach,
//       VoidCallback onSelect,
//       VoidCallback onDeSelect,
//       ) {
//     switch (item) {
//       case SelectedMenuItems.itemSelected:
//         showDialog(
//           context: context,
//           builder: (context) => SelectCoachDialog(onSelect, coach: coach,),
//         );
//         break;
//
//       case SelectedMenuItems.itemDesSelected:
//         showDialog(
//           context: context,
//           builder: (context) => DeselectProgramDialog(onDeSelect, program: coach,),
//         );
//         break;
//     }
//   }
// }
