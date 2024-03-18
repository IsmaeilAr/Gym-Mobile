import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../components/widgets/loading_indicator.dart';
import '../../../components/widgets/search_app_bar.dart';
import '../model/program_model.dart';
import '../provider/program_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/program_card.dart';

class SearchProgramScreen extends StatelessWidget {
  const SearchProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        hint: AppLocalizations.of(context)!.searchInPrograms,
        searchFun: (value) {
          context.read<ProgramProvider>().callSearchProgram(context, value);
        },
      ),
      body: context.watch<ProgramProvider>().isLoadingSearch
          ? const LoadingIndicatorWidget()
          : Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
          horizontal: 14.w,
        ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: context
                          .watch<ProgramProvider>()
                          .searchedPrograms
                          .length,
                      itemBuilder: (context, index) {
                        ProgramModel program;
                        bool isMyProgram = true;

                        program = context
                            .watch<ProgramProvider>()
                            .searchedPrograms[index];
                        return ProgramCard(program, isMyProgram);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

}

