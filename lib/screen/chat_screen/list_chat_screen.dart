import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/models/message.dart';
import 'package:app_xem_tro/models/roomChat.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/message_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/route/routes.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  fetchData() async {
    await context
        .read<MessageProvider>()
        .loadRoomChat(context.read<UserLoginProvider>().userPhone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: padding(context), vertical: padding(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceHeight(context),
              Text(
                "Đoạn Chat",
                style: largeTextStyle(context),
              ),
              spaceHeight(context),
              FutureBuilder(
                future: context
                    .read<MessageProvider>()
                    .loadRoomChat(context.read<UserLoginProvider>().userPhone),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data![0].isEmpty &&
                      snapshot.data![1].isEmpty &&
                      snapshot.data![2].isEmpty) {
                    return const Center(
                      child: Text(
                        "Bạn chưa có cuộc trò chuyện nào",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  print(snapshot.data);
                  List<RoomChat> roomChats = snapshot.data![1];
                  List<User> user = snapshot.data![2];

                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.chatRoute,
                              arguments: roomChats[index].participantIds);
                        },
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: FadeInImage.memoryNetwork(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: kTransparentImage,
                                image: user[index].avatar as String,
                              ),
                            ),
                            spaceWidth(context),
                            SizedBox(
                              height: 80,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user[index].name,
                                    style: mediumTextStyle(context),
                                  ),
                                  Text(roomChats[index].lastMsg),
                                  Text(roomChats[index].lastSend),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => spaceHeight(context),
                    itemCount: roomChats.length,
                  );
                },
              ),
              spaceHeight(context),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(padding(context)),
          height: getHeight(context, height: 0.42),
          child: Column(
            children: [
              ButtonListTile(
                title: 'Xóa',
                icon: FontAwesomeIcons.solidTrashCan,
                onPress: () {},
              ),
              ButtonListTile(
                title: 'Tắt',
                icon: FontAwesomeIcons.solidBellSlash,
                onPress: () {},
              ),
              ButtonListTile(
                title: 'Đánh dấu đã đọc',
                icon: FontAwesomeIcons.envelopeCircleCheck,
                onPress: () {},
              ),
              ButtonListTile(
                title: 'Chặn',
                icon: FontAwesomeIcons.ban,
                onPress: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
