import 'package:app_xem_tro/provider/house_register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageSelected extends StatelessWidget {
  const ImageSelected({super.key});

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
                  .pickImageHouseFromGallery();
              // await context.read<HouseRegisterProvider>().saveImage();
              Navigator.pop(context);
            },
            child: const Text('Lấy ảnh từ thư viện'),
          ),
          TextButton(
            onPressed: () {
              context.read<HouseRegisterProvider>().pickImageHouseFromCamera();
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
