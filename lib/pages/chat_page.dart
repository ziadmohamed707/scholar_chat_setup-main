import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

import '../models/message.dart';
import '../widgets/chat_puble.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  var msg_data;

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments ;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt ,descending: true).snapshots(),
      builder: (context, snapshot) {
        List<Message> messagesList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
        }
        if (snapshot.hasData) {

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  Text('Chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email? ChatPuble(
                          message: messagesList[index],
                        ):ChatPubleSender(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          icon:Icon(Icons.send),
                          color: kPrimaryColor,
                          onPressed: (){
                            messages.add({
                              kMessage: msg_data,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            controller.clear();
                            _controller.animateTo(
                                0,
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      onChanged: (data) {
                        msg_data = data;
                      }),
                )
              ],
            ),
          );
        } else {
          return Text('Loading');
        }
      },
    );
  }
}
