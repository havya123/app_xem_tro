import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    RxBool showpass = true.obs;
    RxBool showpass2 = true.obs;

    void isHidden() {
      showpass.value = !showpass.value;
    }

    void isHidden2() {
      showpass2.value = !showpass2.value;
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: padding(context, padding: 0.05),
            vertical: padding(context, padding: 0.12)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Quên mật khẩu',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              spaceHeight(context, height: 0.1),
              Obx(
                () => TextFieldWidget(
                  isPass: showpass.value,
                  hint: 'Nhập mật khẩu mới',
                  icon: IconButton(
                      onPressed: () {
                        isHidden();
                      },
                      icon: Obx(
                        () => showpass.value
                            ? const Icon(FontAwesomeIcons.eyeSlash)
                            : const Icon(FontAwesomeIcons.eye),
                      )),
                ),
              ),
              spaceHeight(context, height: 0.1),
              Obx(
                () => TextFieldWidget(
                  isPass: showpass2.value,
                  hint: 'Nhập mật khẩu mới',
                  icon: IconButton(
                    onPressed: () {
                      isHidden2();
                    },
                    icon: showpass2.value
                        ? const Icon(FontAwesomeIcons.eyeSlash)
                        : const Icon(FontAwesomeIcons.eye),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, height: 0.17),
              ),
              Button(
                function: () async {
                  Get.offAllNamed(Routes.loginRoute);
                },
                textButton: "Xác nhận",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
