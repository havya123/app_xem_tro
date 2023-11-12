import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/check_box.dart';

import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var showpass = true.obs;
    void isHidden() {
      showpass.value = !showpass.value;
    }

    TextEditingController phoneController = TextEditingController();
    TextEditingController passController = TextEditingController();

    void loginCheck(String phoneNumber, String password) async {
      bool checking =
          await context.read<UserLoginProvider>().login(phoneNumber, password);
      if (checking) {
        Navigator.pushReplacementNamed(context, Routes.navigationRoute);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Center(child: Text('Đăng nhập thất bại')),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Tài khoản hoặc mật khẩu không chính xác'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

    var data = Get.arguments;
    print(data[0]);
    print(data[1]);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: padding(context), vertical: padding(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: getWidth(context, width: 0.95),
                height: getHeight(context, height: 0.4),
                child: Center(
                  child: Image.asset(
                    'assets/images/login_img/home_icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              spaceHeight(context, height: 0.04),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hint: 'Số điện thoại',
                        type: TextInputType.phone,
                        errorText: "Hãy nhập số điện thoại",
                        numberOfLetter: 10,
                        errorPass: "Yêu cầu nhập đủ 10 chữ số điện thoại",
                        minLetter: 10,
                        controller: phoneController,
                      ),
                      spaceHeight(context, height: 0.02),
                      Obx(
                        () => TextFieldWidget(
                          hint: 'Mật khẩu',
                          isPass: showpass.value,
                          icon: IconButton(
                              onPressed: () {
                                isHidden();
                              },
                              icon: Obx(
                                () => Icon(
                                  showpass.value
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  color: Colors.black,
                                ),
                              )),
                          minLetter: 8,
                          errorText: "Hãy nhập mật khẩu",
                          errorPass: "Nhập đủ 8 ký tự",
                          controller: passController,
                        ),
                      ),
                    ],
                  )),
              spaceHeight(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CheckboxExample(),
                  const Expanded(
                    child: Text(
                      'Nhớ tài khoản',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.forgetRoute);
                        },
                        child: const Text(
                          'Quên mật khẩu ?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.02),
              ButtonWidget(
                function: () {
                  if (formKey.currentState!.validate()) {
                    loginCheck(phoneController.text, passController.text);
                  } else {
                    return;
                  }
                },
                textButton: "Đăng nhập",
              ),
              spaceHeight(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chưa có tài khoản ?',
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.signupRoute);
                      },
                      child: Text(
                        'Đăng ký',
                        style: TextStyle(
                            color: Colors.blue.shade800, fontSize: 17),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
