import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:gym/features/programs/widgets/program_card.dart';
import 'package:provider/provider.dart';
import '../../../components/widgets/custom_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/programs_list.dart';

class TrainingWithoutCoachesScreen extends StatefulWidget {
  const TrainingWithoutCoachesScreen(this.category, {super.key});

  final TrainingCategoryModel category;

  @override
  State<TrainingWithoutCoachesScreen> createState() =>
      _TrainingWithoutCoachesState();
}

class _TrainingWithoutCoachesState extends State<TrainingWithoutCoachesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
    super.initState();
  }

  Future<void> _refresh() async {
    context
        .read<ProgramProvider>()
        .getProgramsList(context, widget.category.type, widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    String type = (widget.category.type == 'sport')
        ? AppLocalizations.of(context)!.programsTraining
        : AppLocalizations.of(context)!.programsNutrition;
    String title = "$type/${widget.category.name}";
    return Scaffold(
        appBar: CustomAppBar(title: title, context: context, search: true),
        body: RefreshIndicator(
          color: red,
          backgroundColor: dark,
          onRefresh: _refresh,
          child: context.watch<ProgramProvider>().isLoadingPrograms
              ? const LoadingIndicatorWidget()
              : ProgramsList(
                  category: widget.category,
                  isWithCoach: false,
                ),
        ));
  }
}
