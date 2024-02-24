import 'package:flutter/material.dart';
import 'package:gym/components/widgets/menu_item_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import '../dialog/set_programs_dialog.dart';

class SetProgramsMenuItems {
  static const MenuItemModel selectProgramItem =
      MenuItemModel(text: "Select Program", icon: Icons.close);
  static const deselectProgramItem =
      MenuItemModel(text: 'Deselect Program', icon: Icons.star);

  static List<MenuItemModel> getSetProgramMenuItems = [
    selectProgramItem,
    deselectProgramItem,
  ];
}

void onSelectSetProgram(
    BuildContext context,
    MenuItemModel item,
    ProgramModel program,
    VoidCallback doSelectProgram,
    VoidCallback doDeSelectProgram) {
  switch (item) {
    case SetProgramsMenuItems.selectProgramItem:
      showDialog(
          context: context,
          builder: (context) => SelectProgramDialog(
                doSelectProgram,
                program: program,
              ));
      break;

    case SetProgramsMenuItems.deselectProgramItem:
      showDialog(
          context: context,
          builder: (context) => DeselectProgramDialog(
                doDeSelectProgram,
                program: program,
              )); // todo fix
      break;
  }
}
