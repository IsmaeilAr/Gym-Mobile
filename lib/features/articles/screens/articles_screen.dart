import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/articles_list.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    // todo try put 2 lines below into postFrameCallBack
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
        title: searching
            ? ActiveSearchBar(
                hint: "search in articles",
                runFilter: (value) {
                  runFilter(value);
                },
              )
            : const InactiveSearchBar(
                title: "Articles",
              ),
        leading: IconButton(
          color: lightGrey,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searching
                    ? customIcon = Icon(
                        Icons.cancel,
                        color: lightGrey,
                        size: 18.sp,
                      )
                    : customIcon = const Icon(
                        Icons.search,
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
            TabBar.secondary(
              controller: _tabController,
              unselectedLabelColor: grey,
              labelStyle: const TextStyle(color: primaryColor),
              indicatorColor: primaryColor,
              dividerColor: black,
              tabs: <Widget>[
                Tab(text: AppLocalizations.of(context)!.articlesAll),
                Tab(text: AppLocalizations.of(context)!.articlesFavorite),
              ],
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
      results = context.watch<ArticleProvider>().articleList;
    } else {
      results = context
          .watch<ArticleProvider>()
          .articleList
          .where((element) =>
              element.title.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    context.watch<ArticleProvider>().foundArticleList = results;
  }
}
