import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:app_xem_tro/config/extension.dart';

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
                        errorText: "Hãy nhập thông tin này",
                      ),
                      spaceHeight(context, height: 0.015),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ngày tháng năm sinh',
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
                        selectedMonth: 10, // optional
                        selectedYear: 1993, // optional
                        onChangedDay: (value) => print('onChangedDay: $value'),
                        onChangedMonth: (value) =>
                            print('onChangedMonth: $value'),
                        onChangedYear: (value) =>
                            print('onChangedYear: $value'),
                      ),
                      spaceHeight(context, height: 0.015),
                      TextFieldWidget(hint: 'Địa chỉ'),
                      spaceHeight(context, height: 0.015),
                      TextFieldWidget(
                          hint: 'Email',
                          type: TextInputType.emailAddress,
                          errorText: "Hãy nhập thông tin này"),
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
                          errorText: "Hãy nhập thông tin này",
                          errorPass: "Yêu cầu ít nhất 8 ký tự",
                          minLetter: 8,
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
                          errorText: "Hãy nhập thông tin này",
                          errorPass: "Yêu cầu ít nhất 8 ký tự",
                          minLetter: 8)),
                    ],
                  )),
              spaceHeight(context, height: 0.05),
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Get.offNamed(Routes.loginRoute);
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
