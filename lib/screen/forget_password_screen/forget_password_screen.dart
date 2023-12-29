import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String verifyID = "";

    TextEditingController phoneController = TextEditingController();
    TextEditingController otpController = TextEditingController();

    final formKey = GlobalKey<FormState>();
    final phonekey = GlobalKey<FormState>();

    Function data = Get.arguments as Function;

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
                      child: Expanded(
                        child: Text(
                          'Quên mật khẩu',
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                spaceHeight(context, height: 0.06),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        SizedBox(
                            height: getHeight(context, height: 0.09),
                            width: double.infinity,
                            child: Form(
                                key: phonekey,
                                child: TextFieldWidget(
                                  hint: 'Số điện thoại',
                                  controller: phoneController,
                                  errorText: "Hãy nhập số điện thoại",
                                  errorPass:
                                      "Yêu cầu nhập đủ 10 chữ số điện thoại",
                                ))),
                        SizedBox(
                          height: getHeight(context, height: 0.02),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  height: getHeight(context, height: 0.09),
                                  child: TextFieldWidget(
                                    hint: 'Nhập mã OTP',
                                    controller: otpController,
                                  )),
                            ),
                            spaceWidth(context, width: 0.02),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  bool existsPhoneNumber = await context
                                      .read<UserProvider>()
                                      .checkingNumberPhone(
                                          phoneController.text);
                                  if (!existsPhoneNumber) {
                                    if (phonekey.currentState!.validate()) {
                                      await FirebaseAuth.instance
                                          .verifyPhoneNumber(
                                        phoneNumber:
                                            "+84${phoneController.text}",
                                        verificationCompleted:
                                            (PhoneAuthCredential credential) {},
                                        verificationFailed:
                                            (FirebaseAuthException e) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Center(
                                                      child: Text(
                                                          'Gửi mã OTP thất bại')),
                                                  content:
                                                      const SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                            'Gửi mã OTP thất bại. Số điện thoại không hợp lệ'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        codeSent: (String verificationId,
                                            int? resendToken) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Center(
                                                      child: Text(
                                                          'Gửi mã OTP thành công')),
                                                  content:
                                                      const SingleChildScrollView(
                                                    child: ListBody(
                                                      children: <Widget>[
                                                        Text(
                                                            'Mã OTP đã được gửi vào số điện thoại của bạn'),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('OK'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                          verifyID = verificationId;
                                        },
                                        codeAutoRetrievalTimeout:
                                            (String verificationId) {},
                                      );
                                    }
                                  } else {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Center(
                                              child: Text(
                                                  'Số điện thoại không hợp lệ')),
                                          content: const SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Text(
                                                    'Số điện thoại này chưa được tạo'),
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
                                },
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
                                    style: mediumTextStyle(context,
                                        color: Colors.white),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: getHeight(context, height: 0.08),
                ),
                ButtonWidget(
                  function: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: verifyID,
                          smsCode: otpController.text,
                        );

                        // Sign in with the credential
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithCredential(credential);

                        if (userCredential.user != null) {
                          // SMS code verification is successful
                          Get.toNamed(
                            Routes.resetRoute,
                            arguments: [phoneController.text, data],
                          )!
                              .then((value) => Get.back(result: value ?? []));
                        } else {
                          // Verification failed
                        }
                      } catch (e) {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Sai mã OTP')),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Bạn đã nhập sai mã OTP. Hãy kiểm tra mã OTP và nhập lại'),
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
                    } else {
                      formKey.currentState!.validate();
                      return;
                    }
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
