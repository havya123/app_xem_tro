// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {this.hint,
      this.icon,
      this.isPass = false,
      this.type = TextInputType.text,
      this.maxLength = 30,
      super.key});
  String? hint;
  Widget? icon;
  bool isPass;
  TextInputType type;
  int maxLength;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      obscureText: isPass,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.black),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          suffixIcon: icon,
          floatingLabelBehavior: FloatingLabelBehavior.always),
    );
  }
}
