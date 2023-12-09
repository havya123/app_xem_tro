import 'package:app_xem_tro/config/size_config.dart';
import 'package:app_xem_tro/models/message.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({required this.isMe, required this.message, super.key});

  final bool isMe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe ? Alignment.topRight : Alignment.topLeft,
        child: Card(
          color: isMe ? const Color(0xff005ff9) : Colors.white,
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              message.message,
              style: mediumTextStyle(context,
                  fontWeight: FontWeight.w400,
                  color: isMe ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
