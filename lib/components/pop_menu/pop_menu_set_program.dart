import 'package:flutter/material.dart';
import 'package:gym/components/pop_menu/menu_item_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import '../dialog/set_programs_dialog.dart';
import '../styles/gym_icons.dart';

void onSelectSetProgram(
    BuildContext context,
    MenuItemModel item,
    ProgramModel program,
    VoidCallback doSelectProgram,
    VoidCallback doDeSelectProgram) {
  switch (item) {
    case GymIcons.select:
      showDialog(
          context: context,
          builder: (context) => SelectProgramDialog(
                doSelectProgram,
                program: program,
              ));
      break;

    case Icons.close:
      showDialog(
          context: context,
          builder: (context) => DeselectProgramDialog(
                doDeSelectProgram,
                program: program,
              ));
      break;
  }
}
