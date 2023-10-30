import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: getWidth(context, width: 0.3),
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListChatScreen()),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.black,
                )),
            SizedBox(
              width: getWidth(context, width: 0.15),
              height: getHeight(context, height: 0.075),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("assets/images/splash_img/splash_icon.png",
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Chủ trọ 1",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(padding(context)),
          child: const Column(
            children: [
              chatInput(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class chatInput extends StatelessWidget {
  const chatInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius(context)))),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.squarePlus),
                  iconSize: getHeight(context),
                ),
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Nhập tin nhắn...",
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        MaterialButton(
          minWidth: 0,
          onPressed: () {},
          child: const Icon(
            FontAwesomeIcons.paperPlane,
            color: Colors.blueAccent,
          ),
        )
      ],
    );
  }
}
