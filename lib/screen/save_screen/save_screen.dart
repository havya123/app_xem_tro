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
              Consumer<FavouriteProvider>(
                builder: (context, value, child) {
                  if (value.listRoom.isEmpty) {
                    return const Center(
                      child: Text('Danh sách hiện đang trống'),
                    );
                  }
                  List<Room> listRoom = value.listRoom;
                  List<Favourite> listFavourite =
                      context.read<FavouriteProvider>().listFavourite;
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RoomItem(
                          room: listRoom[index],
                          roomId: listFavourite[index].roomId,
                          houseAddress: listFavourite[index].houseAddress,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          spaceHeight(context),
                      itemCount: listRoom.length);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
