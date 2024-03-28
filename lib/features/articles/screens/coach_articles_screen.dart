import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/articles/models/articles_model.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/article_tile_widget.dart';

class CoachArticlesList extends StatelessWidget {
  const CoachArticlesList({
    super.key,
  });


  @override
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
              itemCount:
                  context.watch<ArticleProvider>().coachArticleList.length,
              itemBuilder: (context, index) {
                ArticleModel article =
                    context.watch<ArticleProvider>().coachArticleList[index];
                return ArticleTileWidget(article);
              },
            ),
          ),
        ],
      ),
    );
  }
}
