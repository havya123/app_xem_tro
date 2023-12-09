import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/config/widget/room_item.dart';
import 'package:app_xem_tro/models/favourite.dart';
import 'package:app_xem_tro/models/room.dart';
import 'package:app_xem_tro/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: padding(context, padding: 0.02),
              vertical: padding(context, padding: 0.1)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: getWidth(context, width: 0.1),
                    height: getHeight(context, height: 0.06),
                    child: const Icon(FontAwesomeIcons.angleLeft),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: padding(context, padding: 0.18)),
                    child: const Text(
                      "Danh sách yêu thích",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              StreamBuilder(
                stream: context
                    .read<FavouriteProvider>()
                    .favouriteController
                    .stream,
                builder: (context, snapshot) {
                  if (snapshot.data?['status'] == null) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: getHeight(context, height: 0.4),
                              margin: EdgeInsets.only(right: padding(context)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            );
                          },
                        ));
                  }

                  if (snapshot.data?['status'] == statusCode.loading) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              spaceHeight(context),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              height: getHeight(context, height: 0.4),
                              margin: EdgeInsets.only(right: padding(context)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            );
                          },
                        ));
                  }
                  if (snapshot.data?['data'].isEmpty) {
                    return const Center(
                      child: Text('Danh sách hiện đang trống'),
                    );
                  }
                  List<Room> listRoom = snapshot.data?['data'] as List<Room>;
                  List<Favourite> listFavourite =
                      context.read<FavouriteProvider>().listFavourite;
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RoomItem(
                          room: listRoom[index],
                          roomId: listFavourite[index].roomId,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          spaceHeight(context),
                      itemCount: listRoom.length);
                },
              )

              // Consumer<FavouriteProvider>(
              //   builder: (context, value, child) {
              //     List<Room> listRoom = value.listRoom;
              //     List<Favourite> listFavourite = value.listFavourite;
              //     if (listRoom.isEmpty) {
              //       return const Center(
              //         child: Text("Danh sách yêu thích đang trốn"),
              //       );
              //     }
              //     return ListView.separated(
              //         physics: const NeverScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         itemBuilder: (context, index) {
              //           return RoomItem(
              //             room: listRoom[index],
              //             roomId: listFavourite[index].roomId,
              //           );
              //         },
              //         separatorBuilder: (context, index) => spaceHeight(context),
              //         itemCount: listRoom.length);
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
