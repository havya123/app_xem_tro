import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding(context, padding: 0.05),
            vertical: padding(context, padding: 0.12),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Ink(
                        child: Container(
                          height: getHeight(context, height: 0.06),
                          width: getWidth(context, width: 0.12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black)),
                          child: const Icon(
                            FontAwesomeIcons.arrowLeft,
                          ),
                        ),
                      ),
                    ),
                    spaceWidth(context, width: 0.07),
                    const Center(
                      child: Text(
                        'Quên mật khẩu',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                spaceHeight(context),
                SizedBox(
                    height: getHeight(context, height: 0.09),
                    width: double.infinity,
                    child: const TextFieldWidget(hint: 'Số điện thoại')),
                SizedBox(
                  height: getHeight(context, height: 0.06),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: getHeight(context, height: 0.09),
                          child: TextFieldWidget(hint: 'Nhập mã OTP')),
                    ),
                    spaceWidth(context, width: 0.02),
                    Expanded(
                      child: Container(
                        height: getHeight(context, height: 0.09),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              borderRadius(context, border: 0.03)),
                          gradient: const LinearGradient(colors: [
                            Color(0xff363ff5),
                            Color(0xff6357CC),
                          ]),
                        ),
                        child: Center(
                            child: Text(
                          'Lấy mã xác nhận',
                          style: mediumTextStyle(context, color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: getHeight(context, height: 0.08),
                ),
                const TextFieldWidget(hint: 'Nhập mã OTP'),
                SizedBox(
                  height: getHeight(context, height: 0.15),
                ),
                ButtonWidget(
                  function: () {
                    Get.toNamed(Routes.resetRoute);
                  },
                  textButton: "Xác nhận",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
