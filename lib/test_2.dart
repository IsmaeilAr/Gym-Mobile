import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<StatefulWidget> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  static const menuItems = <String>[
    'One',
    'Two',
    'Three',
    'Four',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  final List<PopupMenuItem<String>> _popUpMenuItems = menuItems
      .map(
        (String value) => PopupMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

  String _btn1SelectedVal = 'One';
  String? _btn2SelectedVal;
  late String _btn3SelectedVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: DropdownButton(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                value: _btn2SelectedVal,
                hint: const Text('Category'),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => _btn2SelectedVal = newValue);
                  }
                },
                items: _dropDownMenuItems,
              ),
            ),
            DropdownButton(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              // style: ,
              value: _btn2SelectedVal,
              hint: const Text('Category'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _btn2SelectedVal = newValue);
                }
              },
              items: _dropDownMenuItems,
            ),
          ],
        ),
      ),
    );
  }
}
