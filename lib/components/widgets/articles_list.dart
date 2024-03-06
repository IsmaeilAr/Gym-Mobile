import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:gym/features/articles/screens/article_screen.dart';
import 'package:provider/provider.dart';

class ArticlesList extends StatefulWidget {
  const ArticlesList({
    super.key,
    required this.isFavourite,
  });

  final bool isFavourite;

  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // bad performance here // consider enhance
      context.read<ArticleProvider>().favouriteArticleList = context
          .read<ArticleProvider>()
          .filteredArticleList
          .where((element) => element.isFavorite == true)
          .toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 9.w,
      ),
      child: context.watch<ArticleProvider>().isLoadingArticles
          ? const LoadingIndicatorWidget()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: (widget.isFavourite)
                        ? context
                            .watch<ArticleProvider>()
                            .favouriteArticleList
                            .length
                        : context
                            .watch<ArticleProvider>()
                            .filteredArticleList
                            .length,
                    itemBuilder: (context, index) {
                      ArticleModel article;
                      if (widget.isFavourite) {
                        article = context
                            .watch<ArticleProvider>()
                            .favouriteArticleList[index];
                      } else {
                        article = context
                            .watch<ArticleProvider>()
                            .filteredArticleList[index];
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 6.h,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ArticleScreen(article)));
                          },
                          child: ListTile(
                            isThreeLine: true,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r))),
                            tileColor: dark,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    article.title,
                                    style: MyDecorations.calendarTextStyle,
                                  ),
                                ),
                                IconButton(
                                  icon: article.isFavorite
                                      ? Icon(
                                          Icons.favorite,
                                          color: primaryColor,
                                          size: 20.r,
                                        )
                                      : Icon(Icons.favorite_border,
                                          color: lightGrey, size: 20.r),
                                  onPressed: () {
                                    setState(() {
                                      article.isFavorite = !article.isFavorite;
                                    });
                                    context
                                        .read<ArticleProvider>()
                                        .changeArticleFav(context, article.id,
                                            article.isFavorite);
                                  },
                                ),
                              ],
                            ),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.content,
                                  style: (MyDecorations.programsTextStyle),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
