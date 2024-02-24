import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class InactiveSearchBar extends StatelessWidget {
  const InactiveSearchBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: lightGrey,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class ActiveSearchBar extends StatefulWidget {
  const ActiveSearchBar(
      {super.key, required this.hint, required this.runFilter(value)});

  final dynamic runFilter;
  final String hint;

  @override
  State<ActiveSearchBar> createState() => _ActiveSearchBarState();
}

class _ActiveSearchBarState extends State<ActiveSearchBar> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(
        Icons.search,
        color: grey,
        size: 18.sp,
      ),
      title: TextField(
        decoration: InputDecoration(
          hintText: widget.hint,
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
        onChanged: (value) => widget.runFilter(value),
      ),
    );
  }
}
