import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:gym/features/articles/screens/article_screen.dart';
import 'package:provider/provider.dart';


class ArticlesList extends StatefulWidget {
  ArticlesList({super.key, required this.isFavourite, });
  bool isFavourite;
  @override
  State<ArticlesList> createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 9.w,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: context.watch<ArticleProvider>().foundArticleList.length,
              itemBuilder: (context, index) {
                ArticleModel article;
                if (widget.isFavourite) {
                  context.read<ArticleProvider>().favouriteArticleList = context.watch<ArticleProvider>().foundArticleList
                      .where((element) =>
                  element.isFavorite == true)
                      .toList();
                  article = context.watch<ArticleProvider>().favouriteArticleList[index];
                } else {
                  article = context.watch<ArticleProvider>().foundArticleList[index];
                }

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ArticleScreen(article)));
                    },
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.r))),
                      tileColor: dark,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            article.title,
                            style: MyDecorations.calendarTextStyle,
                          ),
                          IconButton(
                            icon: article.isFavorite
                                ? Icon(
                              Icons.favorite,
                              color: primaryColor,
                              size: 14.sp,
                            )
                                : Icon(Icons.favorite_border, color: lightGrey,size: 20.sp),
                            onPressed: () {
                              setState(() {
                                article.isFavorite =
                                !article.isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                      subtitle: Text(
                        article.content,
                        style: (MyDecorations.programsTextStyle),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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