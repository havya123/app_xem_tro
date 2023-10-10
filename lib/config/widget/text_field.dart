import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {required this.hint,
      this.icon,
      this.isPass = false,
      this.type = TextInputType.text,
      this.errorText,
      this.numberOfLetter,
      this.errorPass,
      this.minLetter = 0,
      super.key});
  String hint;
  Widget? icon;
  bool isPass;
  TextInputType type;
  String? errorText;
  int? numberOfLetter;
  String? errorPass;
  int? minLetter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(numberOfLetter),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        } else if (value.length < minLetter!) {
          return errorPass;
        }
        return null;
      },
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
      ),
    );
  }
}
