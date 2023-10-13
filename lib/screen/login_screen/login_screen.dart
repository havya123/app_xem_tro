import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/checkbox.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:flutter/gestures.dart';
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
                        ))),
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
              Container(
                width: double.infinity,
                height: getHeight(context, height: 0.08),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Color(0xff363ff5),
                      Color(0xff6357CC),
                    ]),
                    borderRadius: BorderRadius.circular(
                        borderRadius(context, border: 0.5))),
                child: const Center(
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
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
