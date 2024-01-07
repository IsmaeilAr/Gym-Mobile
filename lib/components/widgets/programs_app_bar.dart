import 'package:flutter/material.dart';
import 'package:gym/components/styles/colors.dart';

AppBar programsAppBar({required String title, required BuildContext context, required bool search}) {
  return AppBar(
    backgroundColor: black,
    leading: IconButton(
      color: Colors.white,
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: () => Navigator.pop(context),
    ),

    title: Text(
      title,
      style: TextStyle(
        color:  Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: search
        ? [
      IconButton(
        color:  Colors.white,
        onPressed: () {},
        icon: Icon(Icons.search),
      ),
    ] : null,
  );
}