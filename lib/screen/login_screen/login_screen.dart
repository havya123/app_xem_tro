import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/checkbox.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:app_xem_tro/route/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var showpass = true.obs;
    void isHidden() {
      showpass.value = !showpass.value;
    }

    var isLoading = false.obs;

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
                'Login',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              spaceHeight(context, height: 0.04),
              TextFieldWidget(
                hint: 'Số điện thoại',
                type: TextInputType.phone,
                errorText: "Hãy nhập số điện thoại",
                numberOfLetter: 10,
                errorPass: "Yêu cầu nhập đủ 10 chữ số điện thoại",
                minLetter: 10,
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
                  errorPass: "Nhập đủ 8 ký tự",
                ),
              ),
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
                      child: const Text(
                        'Quên mật khẩu ?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              spaceHeight(context, height: 0.02),
              Button(
                function: () async {
                  if (isLoading.value) return;
                  isLoading.value = !isLoading.value;
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pushReplacementNamed(context, Routes.homeRoute);
                },
                textButton: "Đăng nhập",
                isLoading: isLoading,
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
                        Navigator.pushNamed(context, Routes.signupRoute);
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
