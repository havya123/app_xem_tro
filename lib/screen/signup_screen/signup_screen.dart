import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: padding(context, padding: 0.1),
            horizontal: padding(context)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: getHeight(context, height: 0.4),
                child: Image.asset(
                  'assets/images/signup_img/register_img.png',
                  fit: BoxFit.contain,
                ),
              ),
              spaceHeight(context),
              const Text(
                'Đăng ký',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hint: 'Nhập số điện thoại',
                        type: TextInputType.phone,
                        errorText: "Hãy nhập số điện thoại",
                        numberOfLetter: 10,
                        errorPass: "Yêu cầu nhập đủ 10 chữ số điện thoại",
                        minLetter: 10,
                      ),
                      spaceHeight(context, height: 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: TextFieldWidget(
                            hint: 'Nhập mã OTP',
                            type: TextInputType.number,
                            errorText: "Hãy nhập mã OTP",
                            numberOfLetter: 6,
                            errorPass: "Yêu cầu nhập đủ 6 chữ số điện thoại",
                            minLetter: 6,
                          )),
                          spaceWidth(context),
                          Expanded(
                              child: Container(
                            width: double.infinity,
                            height: getHeight(context, height: 0.075),
                            decoration: BoxDecoration(
                                color: const Color(0xff315EE7),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Lấy mã OTP',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  )),
              spaceHeight(context),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Get.toNamed(Routes.secondSignup);
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: getHeight(context, height: 0.08),
                  decoration: BoxDecoration(
                      color: const Color(0xff315EE7),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              spaceHeight(context, height: 0.015),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, Routes.loginRoute);
                  },
                  child: const Text(
                    '← Trở về đăng nhập',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
