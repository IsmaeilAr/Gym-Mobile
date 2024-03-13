import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import 'back_button.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String hint;
  final Function(String) searchFun;
  final Icon customIcon = const Icon(Icons.cancel, color: lightGrey, size: 18);

  const SearchAppBar({
    super.key,
    required this.hint,
    required this.searchFun,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: black,
      leading: const MyBackButton(),
      title: ListTile(
        leading: Icon(
          Icons.search,
          color: grey,
          size: 18.sp,
        ),
        title: TextField(
          onChanged: (value) {
            searchFun(value);
          },
          autofocus: true,
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
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        // IconButton(
        //   onPressed: () {
        //     searchValCont.text = '';
        //   },
        //   icon: customIcon,
        // ),
      ],
    );
  }
}
