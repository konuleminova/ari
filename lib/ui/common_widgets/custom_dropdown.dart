import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDropDown extends HookWidget {
  final List<dynamic> items;
  final Function(String value) selectedFunction;

  CustomDropDown({this.items, this.initialItemText, this.selectedFunction});

  final initialItemText;

  @override
  Widget build(BuildContext context) {
    var selectedValue = useState<String>(initialItemText);
    // TODO: implement build
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isDense: true,
        isExpanded: true,
        items: items.map((value) {
          return new DropdownMenuItem<String>(
              value: value.name,
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: new Text(
                  value.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ));
        }).toList(),
        hint: Container(
            padding: EdgeInsets.only(left: 16),
            child: Text(selectedValue.value ?? '')),
        onChanged: (value) {
          selectedValue.value = value;
          selectedFunction(selectedValue.value);
        },
      ),
    );
  }
}
