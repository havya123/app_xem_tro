import 'package:flutter/material.dart';

class CheckboxExample extends StatefulWidget {
  CheckboxExample({this.isChecked, super.key});
  Function(bool?)? isChecked;

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.blue,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          if (widget.isChecked != null) {
            isChecked = value!;
            widget.isChecked!(isChecked);
          } else {
            isChecked = value!;
          }
        });
      },
    );
  }
}
