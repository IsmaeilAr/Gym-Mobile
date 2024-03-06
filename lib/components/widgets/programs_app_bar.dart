import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/features/coaches/screens/search_coaches_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/programs/screens/search_programs_screen.dart';
import 'back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;
  final bool search;

  const CustomAppBar({
    super.key,
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
      leading: const MyBackButton(),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: const SearchProgramScreen()));
                },
                icon: const Icon(Icons.search),
              ),
            ]
          : null,
    );
  }
}

class UsersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;

  const UsersAppBar({
    super.key,
    required this.title,
    required this.context,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      leading: const MyBackButton(),
      title: Text(
        title,
        style: const TextStyle(
          color: lightGrey,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          color: lightGrey,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const SearchCoachesScreen()));
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String hint;
  final Function(String) runFilter;
  final Icon customIcon = const Icon(Icons.cancel, color: lightGrey, size: 18);
  final TextEditingController searchController = TextEditingController();

  SearchAppBar({
    super.key,
    required this.hint,
    required this.runFilter,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      leading: const MyBackButton(),
      title: ListTile(
        leading: Icon(
          Icons.search,
          color: grey,
          size: 18.sp,
        ),
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: grey,
              fontSize: 16.sp,
              fontStyle: FontStyle.italic,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: lightGrey,
          ),
          onChanged: (value) => runFilter(value),
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            searchController.text = '';
          },
          icon: customIcon,
        )
      ],
    );
  }
}
