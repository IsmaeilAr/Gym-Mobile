import 'package:flutter/material.dart';

import '../../../components/widgets/programs_app_bar.dart';
import '../provider/program_provider.dart';

class SearchProgramScreen extends StatelessWidget {
  const SearchProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(hint: 'Search In Programs', runFilter: () {
        doProgramSearch(BuildContext, String);
      },),
      body:,

    );
  }

  void doProgramSearch(context, value) {
    context.read<ProgramProvider>().callSearchProgram(context, value);
  }
}
