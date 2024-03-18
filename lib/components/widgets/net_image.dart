import'package:flutter/material.dart';

import 'cached_image_widget.dart';

ImageProvider networkImage(coach) {
  ImageProvider image;

  (coach.images.isNotEmpty)
      ? image = NetworkImage(
          coach.images[0].image,
        )
      : image = const AssetImage('assets/images/profile.png');

  return image;
}

CachedImageWidget cachedImage(coach) {
  CachedImageWidget image;

  image = (coach.images.isNotEmpty)
      ? CachedImageWidget(
          imageUrl: coach.images[0].image,
          boxFit: BoxFit.fill,
        )
      : const CachedImageWidget(
          imageUrl: 'assets/images/profile.png',
          boxFit: BoxFit.fill,
        );

  return image;
}