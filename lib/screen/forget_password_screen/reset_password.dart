import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: getHeight(context, height: 0.06),
                    width: getWidth(context, width: 0.12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black)),
                    child: const Icon(
                      FontAwesomeIcons.arrowLeft,
                    ),
                  ),
                  spaceWidth(context, width: 0.07),
                  Text(
                    'Quên mật khẩu',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
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
                            ? Icon(FontAwesomeIcons.eyeSlash)
                            : Icon(FontAwesomeIcons.eye),
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
                        ? Icon(FontAwesomeIcons.eyeSlash)
                        : Icon(FontAwesomeIcons.eye),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context, height: 0.2),
              ),
              InkWell(
                onTap: () {},
                child: Ink(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffAE89FF),
                    ),
                    height: getHeight(context, height: 0.08),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
