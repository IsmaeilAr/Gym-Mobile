import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:provider/provider.dart';
import 'article_tile_widget.dart';

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

                      return ArticleTileWidget(article);
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

