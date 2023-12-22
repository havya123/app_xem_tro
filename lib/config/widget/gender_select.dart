import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { male, female }

class GenderSelect extends StatefulWidget {
  GenderSelect({required this.gender, super.key});
  Function(String) gender;
  @override
  State<GenderSelect> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<GenderSelect> {
  SingingCharacter? _character;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            title: const Text('Nam'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.male,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                  widget.gender('Nam');
                });
              },
            ),
          ),
        ),
        spaceWidth(context),
        Expanded(
          child: ListTile(
            title: const Text('Nữ'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.female,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                  widget.gender('Nữ');
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
