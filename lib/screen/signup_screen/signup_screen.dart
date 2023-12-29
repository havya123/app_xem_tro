import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/button.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String verifyID = "";
    TextEditingController phoneController = TextEditingController();
    TextEditingController otpController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final phonekey = GlobalKey<FormState>();
    var isLoading = false.obs;
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
                      Form(
                        key: phonekey,
                        child: TextFieldWidget(
                          hint: 'Nhập số điện thoại',
                          type: TextInputType.phone,
                          errorText: "Hãy nhập số điện thoại",
                          numberOfLetter: 10,
                          errorPass: "Yêu cầu nhập đủ 10 chữ số điện thoại",
                          minLetter: 10,
                          controller: phoneController,
                        ),
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
                            errorPass: "Mã OTP gồm 6 số",
                            minLetter: 6,
                            controller: otpController,
                          )),
                          spaceWidth(context),
                          Expanded(
                              child: InkWell(
                            onTap: () async {
                              if (phonekey.currentState!.validate()) {
                                if (isLoading.value) {
                                  return;
                                }
                                isLoading.value = true;
                                bool existsPhoneNumber = await context
                                    .read<UserProvider>()
                                    .checkingNumberPhone(phoneController.text);
                                if (existsPhoneNumber) {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: "+84${phoneController.text}",
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {
                                      isLoading.value = false;
                                    },
                                    verificationFailed:
                                        (FirebaseAuthException e) {
                                      isLoading.value = false;
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Center(
                                                  child: Text(
                                                      'Gửi mã OTP thất bại')),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    Text(e.code.toString()),
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
                                          });
                                    },
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      isLoading.value = false;
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
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      verifyID = verificationId;
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {
                                      isLoading.value = false;
                                    },
                                  );
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
                                                  'Số điện thoại này đã được tạo'),
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
                            },
                            child: Container(
                                width: double.infinity,
                                height: getHeight(context, height: 0.075),
                                decoration: BoxDecoration(
                                    color: const Color(0xff315EE7),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Obx(
                                  () {
                                    return Center(
                                      child: isLoading.value
                                          ? const CircularProgressIndicator()
                                          : const Text(
                                              'Lấy mã OTP',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    );
                                  },
                                )),
                          ))
                        ],
                      ),
                    ],
                  )),
              spaceHeight(context),
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
                          Routes.secondSignup,
                          arguments: phoneController.text,
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
              spaceHeight(context, height: 0.015),
              TextButton(
                  onPressed: () {
                    Get.back();
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
