import 'package:flutter/material.dart';
import 'package:gym/components/styles/colors.dart';

class ProgramsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final bool search;

  const ProgramsAppBar({super.key,
    required this.title,
    required this.context,
    required this.search,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      leading: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: search
          ? [
        IconButton(
          color: Colors.white,
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
      ]
          : null,
    );
  }
}
