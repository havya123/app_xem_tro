import 'dart:async';

import 'package:app_xem_tro/provider/google_map_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class FullMapScreen extends StatefulWidget {
  const FullMapScreen({super.key});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {
  final Completer<GoogleMapController> completer =
      Completer<GoogleMapController>();

  LatLng position = const LatLng(10.835247805835449, 106.62500499835035);
  Completer<GoogleMapController> controller =
      Get.arguments as Completer<GoogleMapController>;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<GoogleMapProvider>(
              builder: (context, value, child) {
                return GoogleMap(
                  mapType: MapType.normal,
                  onTap: (position) async {
                    await context
                        .read<GoogleMapProvider>()
                        .setMaker(position)
                        .then((value) async {
                      context.read<GoogleMapProvider>().goToPlace(completer);
                    });
                  },
                  markers: {value.marker},
                  initialCameraPosition:
                      CameraPosition(target: value.latLng, zoom: 24),
                  onMapCreated: (controller) {
                    completer.complete(controller);
                  },
                  // Additional GoogleMap properties and callbacks can be added here
                );
              },
            ),
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                  onPressed: () {
                    context.read<GoogleMapProvider>().goToPlace(controller);
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            Positioned(
                right: 0,
                top: 0,
                child: Row(
                  children: [
                    const Text("Lấy vị trị của bạn"),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.locationDot),
                      onPressed: () async {
                        await context
                            .read<GoogleMapProvider>()
                            .getCurrentPosition();
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
