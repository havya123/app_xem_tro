// ignore_for_file: must_be_immutable

import 'package:app_xem_tro/config/size_config.dart';
import 'package:flutter/material.dart';

class ListChat extends StatefulWidget {
  const ListChat({
    super.key,
    required this.name,
    this.onPress,
    this.onLongPress,
    required this.lastMessage,
    required this.lastTime,
  });

  final String name;
  final String lastMessage;
  final String lastTime;
  final VoidCallback? onPress, onLongPress;

  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          spaceHeight(context, height: 0.02),
          ListTile(
            onLongPress: widget.onLongPress,
            onTap: widget.onPress,
            leading: SizedBox(
              width: getWidth(context, width: 0.1),
              height: getHeight(context, height: 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("assets/images/splash_img/splash_icon.png",
                    fit: BoxFit.cover),
              ),
            ),
            title: Text(
              widget.name,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              widget.lastMessage,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.lastTime,
                  style: const TextStyle(fontSize: 11),
                ),
                Container(
                  width: getWidth(context, width: 0.055),
                  height: getHeight(context, height: 0.0275),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.purple,
                  ),
                  child: const Text(
                    "1",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
