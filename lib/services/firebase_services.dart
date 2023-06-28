import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';

class FireStoreServices{

  static getAllUsers(){
    return fireStore.collection(usersCollection).get();
  }

  static getMessages({docID}){
    return fireStore.collection(chatsCollection).doc(docID).collection(messagesCollection).orderBy('created_on', descending: false ).snapshots();
  }
}