import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/config/status/status_code.dart';
import 'package:app_xem_tro/config/widget/message.dart';
import 'package:app_xem_tro/models/message.dart';
import 'package:app_xem_tro/models/roomChat.dart';
import 'package:app_xem_tro/models/users.dart';
import 'package:app_xem_tro/provider/message_provider.dart';
import 'package:app_xem_tro/provider/user_login_provider.dart';
import 'package:app_xem_tro/provider/user_provider.dart';
import 'package:app_xem_tro/screen/chat_screen/list_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> arg = Get.arguments as List<String>;
  late String senderId;
  late String receiverId;

  Future<void> fetchData() async {
    senderId = arg[0];
    receiverId = arg[1];
    await context
        .read<MessageProvider>()
        .getRoomChat(senderId, receiverId)
        .then((value) async {
      await context
          .read<MessageProvider>()
          .loadListMessage(context.read<MessageProvider>().roomChatId);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  String userChatWith() {
    if (context.read<UserLoginProvider>().userPhone == receiverId) {
      return senderId;
    }
    return receiverId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder(
                future:
                    context.read<UserProvider>().getUserDetail(userChatWith()),
                builder: (context, snashot) {
                  if (snashot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  User user = snashot.data as User;
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: const Color(0xfff6f7f8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              FontAwesomeIcons.angleLeft,
                              color: Colors.black,
                            )),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage.memoryNetwork(
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: user.avatar as String)),
                        ),
                        spaceWidth(context),
                        Text(
                          user.name,
                          style: mediumTextStyle(context, size: 0.04),
                        )
                      ],
                    ),
                  );
                }),
            Expanded(
                child: StreamBuilder(
                    stream: context
                        .read<MessageProvider>()
                        .messageController
                        .stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data?['status'] == statusCode.loading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      List<Message> messages =
                          snapshot.data?['data'] as List<Message>;
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            bool isMe = false;
                            if (messages[index].userId ==
                                context.read<UserLoginProvider>().userPhone) {
                              isMe = true;
                            }
                            return MessageWidget(
                                isMe: isMe, message: messages[index]);
                          },
                          itemCount: messages.length);
                    })),
            Consumer<MessageProvider>(builder: (context, value, child) {
              return chatInput(
                roomId: value.roomChatId,
                senderId: context.read<UserLoginProvider>().userPhone,
              );
            }),
          ],
        ),
      ),
    );
  }
}

class chatInput extends StatelessWidget {
  final String roomId, senderId;
  const chatInput({
    required this.senderId,
    required this.roomId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius(context)),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.squarePlus),
                  iconSize: getHeight(context),
                ),
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
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
        IconButton(
          onPressed: () async {
            if (textEditingController.text.isEmpty) {
              return;
            }
            await context
                .read<MessageProvider>()
                .sendMessage(
                  roomId,
                  senderId,
                  textEditingController.text,
                )
                .then(
                  (value) =>
                      context.read<MessageProvider>().loadListMessage(roomId),
                );
            FocusScope.of(context).unfocus();
            textEditingController.clear();
          },
          icon: const Icon(
            FontAwesomeIcons.paperPlane,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
