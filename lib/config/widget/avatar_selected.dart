import 'dart:io';

import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';

class AvatarSelected extends StatelessWidget {
  const AvatarSelected({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      child: Column(
        children: [
          spaceHeight(context),
          Consumer<UserProvider>(
            builder: (context, value, child) {
              if (value.image == null) {
                return Container(
                  width: 150,
                  height: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Image.asset("assets/images/splash_img/splash_icon.png",
                      fit: BoxFit.cover),
                );
              }

              return Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                    child:
                        Image.file(File(value.image!.path), fit: BoxFit.cover),
                  ),
                  spaceHeight(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Thoát"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await context
                              .read<UserProvider>()
                              .updateImage(
                                  context.read<UserLoginProvider>().userPhone)
                              .then((value) {
                            Get.back();
                          });
                        },
                        child: const Text("Lưu"),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
          spaceHeight(context),
          TextButton(
            onPressed: () async {
              await context.read<UserProvider>().pickImageAvatarFromGallery();
            },
            child: const Text('Lấy ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              context.read<UserProvider>().pickImageAvatarFromCamera();
            },
            child: const Text('Lấy ảnh từ camera'),
          ),
        ],
      ),
    );
  }
}
