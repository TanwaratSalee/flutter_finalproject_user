import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_finalproject/Views/chat_screen/component/sender_bubble.dart';
import 'package:flutter_finalproject/Views/collection_screen/loading_indicator.dart';
import 'package:flutter_finalproject/consts/consts.dart';
import 'package:flutter_finalproject/controllers/chats_controller.dart';
import 'package:flutter_finalproject/services/firestore_services.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,

      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(fontGreyDark).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() => controller.isLoading.value ? Center(child: loadingIndcator(),) :
            Expanded(
              child: StreamBuilder(
                stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()), 
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: loadingIndcator(),
                    );
                  } else if(snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "Send a message...".text.color(fontGreyDark).make(),
                    );
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                        var data = snapshot.data!.docs[index];
                        return Align(
                          alignment:
                          data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                          child: senderBubble(data));
                      }).toList(),
                    );
                  }
                }
              ),
              ),
            ),

            10.heightBox,

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder( 
                      borderSide: BorderSide(
                      color: fontGrey)),
                    focusedBorder: OutlineInputBorder( 
                      borderSide: BorderSide(
                      color: fontGrey)),  
                  hintText: "Type a message...",
                  ),
                )),
                IconButton(onPressed: () {
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: const Icon(Icons.send, color: primaryApp))
              ],
            ).box.height(80).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 10)).make(),
          ],
        ),
      ),
    );
  }
}