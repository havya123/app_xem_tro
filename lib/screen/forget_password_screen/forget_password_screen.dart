import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
                    const Center(
                      child: Text(
                        'Quên mật khẩu',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                spaceHeight(context, height: 0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextFieldWidget(hint: 'Số điện thoại'),
                    ),
                    spaceWidth(
                      context,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Ink(
                          child: Container(
                            height: getHeight(context, height: 0.09),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.blue),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context, height: 0.08),
                ),
                TextFieldWidget(hint: 'Nhập mã OTP'),
                SizedBox(
                  height: getHeight(context, height: 0.15),
                ),
                InkWell(
                  onTap: () {},
                  child: Ink(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffAE89FF),
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
      ),
    );
  }
}
