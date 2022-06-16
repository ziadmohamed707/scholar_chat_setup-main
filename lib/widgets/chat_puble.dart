import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';

import '../constants.dart';

class ChatPuble extends StatelessWidget {
  const ChatPuble({Key? key , required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 300),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: EdgeInsets.only(left: 25, top: 16,bottom: 16,right: 16),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: kPrimaryColor
        ),
        child: Text(message.message ,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
class ChatPubleSender extends StatelessWidget {
  const ChatPubleSender({Key? key , required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 300),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: EdgeInsets.only(left: 25, top: 16,bottom: 16,right: 16),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: Color(0xff006D84)
        ),
        child: Text(message.message ,style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
