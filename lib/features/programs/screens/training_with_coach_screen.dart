import 'package:flutter/material.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/custom_app_bar.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/model/category_model.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:provider/provider.dart';
import '../../../components/widgets/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/programs_list.dart';

class TrainingWithCoachesScreen extends StatefulWidget {
  const TrainingWithCoachesScreen(this.category, {super.key});

  final TrainingCategoryModel category;
  @override
  State<TrainingWithCoachesScreen> createState() => _TrainingWithCoachesScreenState();
}

class _TrainingWithCoachesScreenState extends State<TrainingWithCoachesScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  Future<void> _refresh() async {
    context
        .read<ProgramProvider>()
        .getProgramsList(context, widget.category.type, widget.category.id)
        .then((value) => context.read<ProgramProvider>().getMyCoachPrograms(
              context,
              widget.category.type,
              context.read<ProfileProvider>().status.myCoach!.id,
            ));
    context.read<ProfileProvider>().callGetStatus(context);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _refresh();
    });
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late bool searching;
  late Icon customIcon;

  @override
  Widget build(BuildContext context) {
    String type = (widget.category.type == 'sport')
        ? AppLocalizations.of(context)!.programsTraining
        : AppLocalizations.of(context)!.programsNutrition;
    String title = "$type/${widget.category.name}";
    return Scaffold(
      appBar: CustomAppBar(title: title, context: context, search: true),
      body: Column(
        children: <Widget>[
          Container(
            color: black,
            child: TabBar.secondary(
              controller: _tabController,
              unselectedLabelColor: grey,
              labelStyle: const TextStyle(color: primaryColor),
              indicatorColor: primaryColor,
              dividerColor: black,
              tabs: <Widget>[
                Tab(text: AppLocalizations.of(context)!.programsMyCoach),
                Tab(text: AppLocalizations.of(context)!.programsAll),
              ],
            ),
          ),
          Expanded(
            child: context.watch<ProgramProvider>().isLoadingPrograms
                ? const LoadingIndicatorWidget()
                : TabBarView(
                    controller: _tabController,
              children: <Widget>[
                      RefreshIndicator(
                          onRefresh: _refresh,
                          color: red,
                          backgroundColor: dark,
                          child: ProgramsList(
                            category: widget.category,
                            isWithCoach: true,
                          )),
                      RefreshIndicator(
                          onRefresh: _refresh,
                          color: red,
                          backgroundColor: dark,
                          child: ProgramsList(
                            category: widget.category,
                            isWithCoach: false,
                          )),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
