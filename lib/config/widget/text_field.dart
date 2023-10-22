import 'package:app_xem_tro/config/extension/email_valid_extension.dart';
import 'package:email_validator/email_validator.dart';
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
      this.controller,
      this.isPass1 = false,
      this.isConfirmPass = false,
      this.removeBorder = false,
      this.hintText = "",
      super.key});
  String hint;
  Widget? icon;
  bool isPass;
  TextInputType type;
  String? errorText;
  int? numberOfLetter;
  String? errorPass;
  int? minLetter;
  TextEditingController? controller;
  bool isPass1;
  bool isConfirmPass;
  bool removeBorder;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [
        LengthLimitingTextInputFormatter(numberOfLetter),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        } else if (value.length < minLetter!) {
          return errorPass;
        } else if (type == TextInputType.emailAddress) {
          if (!controller!.text.isValidEmail()) {
            return "Sai định dạng Email";
          }
        }
        return null;
      },
      keyboardType: type,
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.black),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        suffixIcon: icon,
      ),
    );
  }
}
