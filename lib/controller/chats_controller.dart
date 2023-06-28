import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatsController extends GetxController{

  @override
  void onInit()async {
    // TODO: implement onInit
    await getChatDocId();
    super.onInit();
  }

  var chatDocID= "";
  var friendName = Get.arguments[0];
  var friendID = Get.arguments[1];

  var senderName= Get.put(HomeController()).username.value;
  var msgController= TextEditingController();

  var isLoading= false.obs;

  var chats= fireStore.collection(chatsCollection);
  
  getChatDocId()async{
    isLoading(true);
    var chat= await fireStore.collection(chatsCollection).where('users', isEqualTo: { friendID:null, auth.currentUser!.uid: null}).get();
    if(chat.docs.isNotEmpty){
      print('Chat exists.');
      chatDocID= chat.docs.single.id;
      print('chatDocID is: $chatDocID');
    }else{
    //  new chat document will be created
      print('New chat instance creation started..');

       var docRef=await fireStore.collection(chatsCollection).add({
        "created_on":null,
        "friend_name": friendName,
        "sender_name":senderName,
         "fromID": auth.currentUser!.uid,
         "toID": friendID,
        "last_message": "",
        "users":{
          friendID:null,
          auth.currentUser!.uid:null
        }


      });
      chatDocID=docRef.id;
      print('New chat instance created.. $chatDocID}');
      // print('this chat creation response : $response');
    }
    isLoading(false);
    print(isLoading.value);
  }

  sendMessage({context, message})async{
    if(msgController.text.trim().isNotEmpty)
    {
      print('first time sending message: $chatDocID');
       await chats.doc(chatDocID).update({
        "created_on": FieldValue.serverTimestamp(),
        'last_message': message,
        'fromID': auth.currentUser!.uid,
        "toID": friendID
      });

       await chats
          .doc(chatDocID)
          .collection(messagesCollection)
          .add({
        "created_on": FieldValue.serverTimestamp(),
        "msg": message,
        "uid": auth.currentUser!.uid
      });
      msgController.text="";
    }
    else{
      VxToast.show(context, msg: "please type messages first then send");
    }
  }
}