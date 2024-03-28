import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/features/articles/screens/article_screen.dart';
import 'package:provider/provider.dart';
import '../models/articles_model.dart';
import '../provider/article_provider.dart';

class ArticleTileWidget extends StatelessWidget {
  final ArticleModel article;

  const ArticleTileWidget(
    this.article, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ArticleScreen(article)));
        },
        child: ListTile(
          isThreeLine: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r))),
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
              FavoriteIconButton(
                isFavorite: article.isFavorite,
                onPressed: (isFavorite) {
                  context
                      .read<ArticleProvider>()
                      .changeArticleFav(context, article.id, isFavorite);
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
                style: MyDecorations.programsTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteIconButton extends StatefulWidget {
  final bool isFavorite;
  final Function(bool) onPressed;

  const FavoriteIconButton(
      {super.key, required this.isFavorite, required this.onPressed});

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isFavorite
          ? Icon(
              Icons.favorite,
              color: red, // Assuming you want red color for favorite
              size: 20.r,
            )
          : Icon(Icons.favorite_border, color: lightGrey, size: 20.r),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        widget.onPressed(_isFavorite);
      },
    );
  }
}
