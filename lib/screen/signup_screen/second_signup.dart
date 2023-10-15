import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:app_xem_tro/config/extension/date_dropdown.dart';

class SecondSignup extends StatelessWidget {
  const SecondSignup({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var showpass = true.obs;
    var showpass2 = true.obs;
    void isHidden() {
      showpass.value = !showpass.value;
    }

    void isHidden2() {
      showpass2.value = !showpass2.value;
    }

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmpassController = TextEditingController();

    bool checkConfirm() {
      if (passController.text != confirmpassController.text) {
        confirmpassController.clear();
        return false;
      }
      if (passController.text == "" && confirmpassController.text == "") {
        return false;
      }
      return true;
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: padding(context, padding: 0.12),
            horizontal: padding(context, padding: 0.05)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: getHeight(context, height: 0.4),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/signup_img/register_img.png',
                          fit: BoxFit.cover,
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: getWidth(context, width: 0.12),
                        height: getHeight(context, height: 0.06),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.black,
                            )),
                        child: const Icon(FontAwesomeIcons.arrowLeft),
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                'Đăng ký thông tin',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFieldWidget(
                        hint: 'Họ và tên',
                        errorText: "Hãy nhập họ và tên",
                        controller: nameController,
                      ),
                      spaceHeight(context, height: 0.015),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ngày sinh',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      spaceHeight(context, height: 0.01),
                      DropdownDatePickerVN(
                        locale: 'vi',
                        inputDecoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10))), // optional
                        isDropdownHideUnderline: true, // optional
                        isFormValidator: true, // optional
                        startYear: 1950, // optional
                        endYear: 2023, // optional
                        width: 5,
                        monthFlex: 4,
                        dayFlex: 2,
                        yearFlex: 3,
                        hintTextStyle: const TextStyle(fontSize: 15),
                        // selectedDay: 14, // optional
                        selectedMonth: 1, // optional
                        selectedDay: 1,
                        selectedYear: 2020, // optional
                        onChangedDay: (value) => print('onChangedDay: $value'),
                        onChangedMonth: (value) =>
                            print('onChangedMonth: $value'),
                        onChangedYear: (value) =>
                            print('onChangedYear: $value'),
                      ),
                      spaceHeight(context, height: 0.015),
                      TextFieldWidget(
                        hint: 'Địa chỉ',
                        controller: addressController,
                      ),
                      spaceHeight(context, height: 0.015),
                      TextFieldWidget(
                        hint: 'Email',
                        type: TextInputType.emailAddress,
                        errorText: "Hãy nhập Email",
                        controller: emailController,
                      ),
                      spaceHeight(context, height: 0.015),
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
                          errorText: "Hãy nhập mật khẩu",
                          errorPass: "Yêu cầu ít nhất 8 ký tự",
                          minLetter: 8,
                          controller: passController,
                          isPass1: true,
                        ),
                      ),
                      spaceHeight(context, height: 0.015),
                      Obx(() => TextFieldWidget(
                            hint: 'Xác nhận mật khẩu',
                            isPass: showpass2.value,
                            icon: IconButton(
                                onPressed: () {
                                  isHidden2();
                                },
                                icon: Obx(
                                  () => Icon(
                                    showpass2.value
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    color: Colors.black,
                                  ),
                                )),
                            errorText: checkConfirm()
                                ? "Hãy xác nhận mật khẩu"
                                : "Mật khẩu không trùng khớp",
                            errorPass: "Yêu cầu ít nhất 8 ký tự",
                            minLetter: 8,
                            controller: confirmpassController,
                            isPass1: true,
                            isConfirmPass: true,
                          )),
                    ],
                  )),
              spaceHeight(context, height: 0.05),
              InkWell(
                onTap: () {
                  if (checkConfirm()) {
                    if (formKey.currentState!.validate()) {
                      Get.toNamed(Routes.loginRoute);
                    }
                  } else {
                    formKey.currentState!.validate();
                    return;
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: getHeight(context, height: 0.08),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xff363ff5),
                        Color(0xff6357CC),
                      ]),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
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
