import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/models/chat_users.dart';
import 'package:scholar_chat/models/messages_model.dart';
import 'package:scholar_chat/shared/components/component.dart';
import 'package:scholar_chat/shared/components/constant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessageCollection);
  var messageController = TextEditingController();
  var scrollController = ScrollController();
  static String id = 'HomeScreen';
  ChatUsers? chatUsers;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context,snapshot)
      {
        if(snapshot.hasData)
        {
          List<MessagesModel> messagesList=[];
          for(int i =0; i<snapshot.data!.docs.length;i++){
            messagesList.add(MessagesModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png', height: 40,),
                  const SizedBox(width: 10,),
                  const Text('Chat'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email?
                      customMessage(message: messagesList[index]):customMessageForFriend(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      suffixIcon:IconButton(
                        onPressed: (){
                          messages.add({
                            kMessage:messageController.text,
                            kCreatedAt: DateTime.now(),
                            'id' : email,
                          });
                          messageController.clear();
                          scrollController.animateTo(
                             0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: const Icon(Icons.send),
                        color: kPrimaryColor,
                      ),
                      hintText: 'Send Message',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
