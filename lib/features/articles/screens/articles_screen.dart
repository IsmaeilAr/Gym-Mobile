import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/articles_list.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:provider/provider.dart';


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
    searching = false;
    customIcon = const Icon(Icons.search,color: lightGrey,);
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<ArticleProvider>().callGetArticles(context);
    });
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
      List<ArticleModel> articles = context.watch<ArticleProvider>().articleList; // todo check this list
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: searching ? const ActiveSearchBar() : const InactiveSearchBar(),
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
                searching ?
                  customIcon =  Icon(Icons.cancel,color: lightGrey,size: 18.sp,)
                : customIcon = const Icon(Icons.search,color: lightGrey,);
                  searching = !searching;
              });
            },
            icon: customIcon,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          TabBar.secondary(
            controller: _tabController,
            unselectedLabelColor: grey,
            labelStyle: const TextStyle(color: primaryColor),
            indicatorColor: primaryColor,
            dividerColor: black,
            tabs: const <Widget>[
              Tab(text: 'All'),
              Tab(text: 'Favorite'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ArticlesList(isFavourite: false,),
                ArticlesList(isFavourite: true,),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

class InactiveSearchBar extends StatelessWidget {
  const InactiveSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Articles',
      style: TextStyle(
        color: lightGrey,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ActiveSearchBar extends StatefulWidget {
  const ActiveSearchBar({super.key});

  @override
  State<ActiveSearchBar> createState() => _ActiveSearchBarState();
}

class _ActiveSearchBarState extends State<ActiveSearchBar> {
  void runFilter(String input) {
    List<ArticleModel> results;
    if (input.isEmpty) {
      results = context.watch<ArticleProvider>().articleList;
    } else {
      results = context.watch<ArticleProvider>().articleList
          .where((element) =>
          element.title.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
    context.watch<ArticleProvider>().foundArticleList = results;

  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.search,
        color: grey,
        size: 18.sp,
      ),
      title: TextField(
        decoration: InputDecoration(
          hintText: 'search in articles',
          hintStyle: TextStyle(
            color: grey,
            fontSize: 16.sp,
            fontStyle: FontStyle.italic,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: lightGrey,
        ),
        onChanged: (value) => runFilter(value),
      ),
    );
  }
}



