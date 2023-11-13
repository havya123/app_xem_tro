import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/chat_screen/chat_screen.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:app_xem_tro/config/widget/button_list_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListChatScreen extends StatefulWidget {
  const ListChatScreen({super.key});

  @override
  State<ListChatScreen> createState() => _ListChatScreenState();
}

class _ListChatScreenState extends State<ListChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: padding(context), vertical: padding(context)),
          child: Column(children: [
            spaceHeight(context),
            ListChat(
              name: 'Chủ trọ 1',
              lastMessage: "Thank for contacting me!",
              lastTime: "15:23",
              onPress: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChatScreen()),
                );
              },
              onLongPress: () {
                bottomSheet();
              },
            ),
            ListChat(
              name: 'Chủ trọ 2',
              lastMessage: "Your payment was accepted",
              lastTime: "Yesterday",
              onPress: () {},
              onLongPress: () {
                bottomSheet();
              },
            ),
            ListChat(
              name: 'Chủ trọ 3',
              lastMessage: "It was great experience!",
              lastTime: "11/10/2021",
              onPress: () {},
              onLongPress: () {
                bottomSheet();
              },
            ),
            spaceHeight(context),
          ]),
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
