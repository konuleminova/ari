import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDropDown extends HookWidget {
  final List<dynamic> items;
  final Function(String value) selectedFunction;

  CustomDropDown({this.items, this.initialItemText,this.selectedFunction});

  final initialItemText;

  @override
  Widget build(BuildContext context) {
    var selectedValue = useState<String>(initialItemText);
    // TODO: implement build
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      items: items.map((value) {
        return new DropdownMenuItem<String>(
          value: value.name,
          child: new Text(value.name),
        );
      }).toList(),
      hint: Text(selectedValue.value ?? ''),
      onChanged: (value) {
        selectedValue.value = value;
        selectedFunction(selectedValue.value);

      },

    ));
  }
}
