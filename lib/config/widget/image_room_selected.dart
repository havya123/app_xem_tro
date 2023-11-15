import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageRoomSelected extends StatelessWidget {
  const ImageRoomSelected({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.3,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              await context
                  .read<HouseRegisterProvider>()
                  .pickImageRoomFromGallery();
              // await context.read<HouseRegisterProvider>().saveImage();
              Navigator.pop(context);
            },
            child: const Text('Lấy ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              context.read<HouseRegisterProvider>().pickImageRoomFromCamera();
              // context.read<UserDetailProvider>().saveImage();
              Navigator.pop(context);
            },
            child: const Text('Lấy ảnh từ camera'),
          ),
        ],
      ),
    );
  }
}
