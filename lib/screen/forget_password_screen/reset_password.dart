import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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

    TextEditingController passController = TextEditingController();
    TextEditingController confirmpassController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    bool checkConfirm() {
      if (passController.text != confirmpassController.text) {
        confirmpassController.clear();
        return false;
      }
      if (passController.text == "" && confirmpassController.text == "") {
        return true;
      }
      return true;
    }

    List dynamic = Get.arguments;
    var phoneNumber = dynamic[0];
    Function function = dynamic[1];

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
              Form(
                  key: formKey,
                  child: Column(
                    children: [
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
                          errorText: "Hãy nhập mật khẩu",
                          errorPass: "Yêu cầu ít nhất 8 ký tự",
                          minLetter: 8,
                          controller: passController,
                        ),
                      ),
                      spaceHeight(context, height: 0.05),
                      Obx(
                        () => TextFieldWidget(
                          isPass: showpass2.value,
                          hint: 'Nhập lại mật khẩu mới',
                          icon: IconButton(
                            onPressed: () {
                              isHidden2();
                            },
                            icon: showpass2.value
                                ? const Icon(FontAwesomeIcons.eyeSlash)
                                : const Icon(FontAwesomeIcons.eye),
                          ),
                          errorText: checkConfirm()
                              ? "Hãy xác nhận mật khẩu"
                              : "Mật khẩu không trùng khớp",
                          errorPass: "Yêu cầu ít nhất 8 ký tự",
                          minLetter: 8,
                          controller: confirmpassController,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: getHeight(context, height: 0.1),
              ),
              ButtonWidget(
                function: () {
                  if (checkConfirm()) {
                    if (formKey.currentState!.validate()) {
                      context.read<UserProvider>().changeNewPass(
                          phoneNumber, confirmpassController.text);
                      function();
                      Get.back(
                          result: [phoneNumber, confirmpassController.text]);
                    }
                  } else {
                    return;
                  }
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
