import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/gym_icons.dart';
import 'package:gym/features/articles/widgets/articles_list.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/widgets/back_button.dart';
import '../../../components/widgets/search_bar.dart';

class ArticlesScreens extends StatefulWidget {
  const ArticlesScreens({super.key});

  @override
  State<ArticlesScreens> createState() => _ArticlesScreensState();
}

class _ArticlesScreensState extends State<ArticlesScreens>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // try put 2 lines below into postFrameCallBack
    searching = false;
    customIcon = const Icon(Icons.search,color: lightGrey,);
    WidgetsBinding.instance.addPostFrameCallback((_){
      _refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    context.read<ArticleProvider>().callGetArticles(context);
  }

  late bool searching;
  late Icon customIcon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: const MyBackButton(),
        title: searching
            ? ActiveSearchBar(
                hint: AppLocalizations.of(context)!.searchInArticles,
                runFilter: (value) {
                  runFilter(value);
                },
              )
            : InactiveSearchBar(
                title: AppLocalizations.of(context)!.articles,
              ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                !searching
                    ? customIcon = Icon(
                        Icons.cancel,
                        color: lightGrey,
                        size: 18.sp,
                      )
                    : customIcon = const Icon(
                        GymIcons.search,
                        // Icons.search,
                        color: lightGrey,
                      );
                searching = !searching;
              });
            },
            icon: customIcon,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: <Widget>[
            Container(
              color: black,
              child: TabBar.secondary(
                controller: _tabController,
                unselectedLabelColor: grey,
                labelStyle: const TextStyle(color: primaryColor),
                indicatorColor: primaryColor,
                dividerColor: black,
                // overlayColor: MaterialStateProperty.all(black),
                tabs: <Widget>[
                  Tab(text: AppLocalizations.of(context)!.articlesAll),
                  Tab(text: AppLocalizations.of(context)!.articlesFavorite),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  ArticlesList(
                    isFavourite: false,
                  ),
                  ArticlesList(
                    isFavourite: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void runFilter(String input) {
    List<ArticleModel> results;
    if (input.isEmpty) {
      results = context.read<ArticleProvider>().articleList;
    } else {
      results = context
          .read<ArticleProvider>()
          .articleList
          .where((element) =>
              element.title.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    context.read<ArticleProvider>().filteredArticleList = results;
  }
}

