import 'package:flutter/material.dart';
import 'package:gym/components/widgets/menu_item_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import '../dialog/set_programs_dialog.dart';
import '../styles/gym_icons.dart';

class SetProgramsMenuItems {
  static const MenuItemModel selectProgramItem =
      MenuItemModel(text: "Select", icon: GymIcons.select);
  static const deselectProgramItem =
      MenuItemModel(text: 'Deselect', icon: Icons.close);
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
              ));
      break;
  }
}
