import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.value,
    required this.list,
    required this.onChanged,
    this.isExpanded = false,
    this.outlined = true,
  });

  final String value;
  final List<String> list;
  final void Function(String? p1)? onChanged;
  final bool isExpanded;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: outlined
          ? BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: isExpanded,
            isDense: true,
            value: value,
            items: list.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
