// import 'dart:async';

// import 'package:app_xem_tro/provider/google_map_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapScreen> {
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();

//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(10.781075423493526, 106.6618253751334),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Consumer<GoogleMapProvider>(builder: (context, value, child) {
//             return GoogleMap(
//               markers: {value.marker},
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               onTap: (position) {
//                 context.read<GoogleMapProvider>().setPlace(position);
//               },
//             );
//           }),
//           SafeArea(
//             child: Positioned(
//                 child: IconButton(
//                     onPressed: () {
//                       Get.back();
//                     },
//                     icon: const Icon(Icons.arrow_back_ios_new))),
//           )
//         ],
//       ),
//     );
//   }
// }
