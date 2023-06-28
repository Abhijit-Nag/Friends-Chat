import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;
var currentUser= auth.currentUser;
FirebaseFirestore fireStore = FirebaseFirestore.instance;

var usersCollection= "users";
var chatsCollection ="chats";
var messagesCollection ="messages";