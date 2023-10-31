import 'package:app_xem_tro/config/widget/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListServicesWidget extends StatelessWidget {
  const ListServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 2, childAspectRatio: 1 / 0.5),
      itemBuilder: (context, index) {
        return const ServiceWidget(
          detail: "bếp",
          icon: FontAwesomeIcons.kitchenSet,
        );
      },
      itemCount: 6,
    );
  }
}
