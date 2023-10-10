import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  Button(
      {required this.function,
      super.key,
      this.textButton = "",
      required this.isLoading});
  VoidCallback function;
  String textButton;
  RxBool isLoading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Ink(
        child: Container(
          width: double.infinity,
          height: getHeight(context, height: 0.08),
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xff363ff5),
                Color(0xff6357CC),
              ]),
              borderRadius:
                  BorderRadius.circular(borderRadius(context, border: 0.5))),
          child: Obx(
            () => Center(
              child: !isLoading.value
                  ? Text(
                      textButton,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
