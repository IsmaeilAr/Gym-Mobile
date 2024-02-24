import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:provider/provider.dart';
import '../../../components/styles/colors.dart';
import '../models/articles_model.dart';
import '../provider/article_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticleScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleScreen(this.article, {super.key, required });

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  bool isFav=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: black,
        leading: IconButton(
          color:lightGrey,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.articles,
          style: TextStyle(
            color: lightGrey,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            color:  lightGrey,
            onPressed: () {
              setState(() {
                isFav=!isFav;
              });
              context.read<ArticleProvider>().changeArticleFav(context, widget.article.id, isFav);
            },
            icon: isFav?const Icon(Icons.favorite,color: primaryColor,):const Icon(Icons.favorite_border),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          children: [
            Center(child: Text(widget.article.title,style: MyDecorations.calendarTextStyle,),),
            SizedBox(height: 12.h,),
            Text(widget.article.content,style: MyDecorations.profileLight400TextStyle,),
          ],
        ),
      ),
    );
  }
}
