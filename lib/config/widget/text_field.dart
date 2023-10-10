import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {required this.hint,
      this.icon,
      this.isPass = false,
      this.type = TextInputType.text,
      super.key});
  String hint;
  Widget? icon;
  bool isPass;
  TextInputType type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: type,
      obscureText: isPass,
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
      ),
    );
  }
}
