import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/loading_indicator.dart';

import '../styles/colors.dart';

class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;

  const CachedImageWidget({
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error_outline,
          color: red,
          size: 50.0,
        ),
      ),
      imageUrl: imageUrl,
      fit: boxFit,
      fadeInCurve: Curves.ease,
      fadeInDuration: const Duration(milliseconds: 1000),
    );
  }
}
