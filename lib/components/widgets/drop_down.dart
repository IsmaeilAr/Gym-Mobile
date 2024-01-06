import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';

const List<String> _listGender = [
  'Male',
  'Female',
];

class GenderDropdown extends StatefulWidget {
   const GenderDropdown({super.key,});

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      closedFillColor: lightGrey,
      hintText: 'Select Gender',
      items: _listGender,
      initialItem: _listGender[0],
      onChanged: (value) {
        setState(() {
        });
        context.read<ProfileProvider>().gender = value;
      },
    );
  }
}