import'package:flutter/material.dart';

ImageProvider assetImage(coach) {
  ImageProvider image;

  (coach.images.isNotEmpty)
      ? image = NetworkImage(
          coach.images[0].image,
        )
      : image = const AssetImage('assets/images/profile.png');

  return image;
}

Image imageAsset(coach) {
  Image image;

  (coach.images.isNotEmpty)
      ? image = Image.network(
          coach.images[0].image,
        )
      : image = Image.asset(
          'assets/images/profile.png',
        );

  return image;
}