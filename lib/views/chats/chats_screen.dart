import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/chats_controller.dart';
import 'package:phone_auth_firebase/services/firebase_services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:velocity_x/velocity_x.dart';

class ChatsScreen extends StatefulWidget {
  String friendProfileImage;
  ChatsScreen({Key? key, required this.friendProfileImage}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      print('hello!');
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.88),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: widget.friendProfileImage.toString().isNotEmpty
            ? CircleAvatar(
                backgroundImage:
                    NetworkImage(widget.friendProfileImage.toString()),
              ).marginAll(5.0)
            : const CircleAvatar(child: Icon(Icons.person)).marginAll(5.0),
        backgroundColor: Colors.green,
        title: Text(
          Get.arguments[0].toString(),
          style: GoogleFonts.firaSans(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (controller.isLoading.value)
                    ? const CircularProgressIndicator()
                    : StreamBuilder(
                        stream: FireStoreServices.getMessages(
                            docID: controller.chatDocID.toString()),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                  'this is the error message: ${snapshot.error.toString()}'),
                            );
                          } else {
                            var data = snapshot.data!.docs;
                            bool show = false;
                            if (data.isNotEmpty) {
                              var prevDate = "";
                              return Expanded(
                                child: ListView.builder(
                                    controller: _scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      var t = data[index]['created_on'] == null
                                          ? DateTime.now()
                                          : data[index]['created_on'].toDate();
                                      if (prevDate !=
                                          intl.DateFormat.yMMMd().format(t)) {
                                        show = true;
                                      } else {
                                        show = false;
                                      }
                                      prevDate =
                                          intl.DateFormat.yMMMd().format(t);

                                      return Column(
                                        children: [
                                          show
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xffccffcc)
                                                          .withOpacity(0.38),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 5.0),
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Text(prevDate),
                                                )
                                              : Container(),
                                          Align(
                                            alignment: data[index]['uid'] ==
                                                    auth.currentUser!.uid
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 250),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin:
                                                    const EdgeInsets.all(8.0),
                                                decoration: BoxDecoration(
                                                    color: data[index]['uid'] == auth.currentUser!.uid
                                                        ? const Color(0xffccffcc)
                                                            .withOpacity(0.8)
                                                        : const Color(0xff8ab349)
                                                            .withOpacity(0.8),
                                                    borderRadius: BorderRadius.only(
                                                        bottomRight: data[index]
                                                                    ['uid'] ==
                                                                auth.currentUser!
                                                                    .uid
                                                            ? const Radius.circular(
                                                                0)
                                                            : const Radius.circular(
                                                                20),
                                                        bottomLeft: data[index]['uid'] ==
                                                                auth.currentUser!.uid
                                                            ? const Radius.circular(20)
                                                            : const Radius.circular(0),
                                                        topRight: const Radius.circular(20),
                                                        topLeft: const Radius.circular(20))),
                                                child: Column(
                                                  crossAxisAlignment: data[
                                                              index]['uid'] ==
                                                          auth.currentUser!.uid
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      data[index]['msg'],
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    8.heightBox,
                                                    SizedBox(
                                                      width: 80,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment: data[
                                                                        index]
                                                                    ['uid'] ==
                                                                auth.currentUser!
                                                                    .uid
                                                            ? MainAxisAlignment
                                                                .end
                                                            : MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            intl.DateFormat(
                                                                    "h:mma")
                                                                .format(t),
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                          data[index]['uid'] ==
                                                                  auth.currentUser!
                                                                      .uid
                                                              ? const Icon(
                                                                  Icons
                                                                      .done_all_rounded,
                                                                  color: Colors
                                                                      .purple,
                                                                  size: 18,
                                                                )
                                                              : const Icon(
                                                                  Icons.done,
                                                                  size: 0,
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              );
                            } else {
                              return const Text(
                                  'Start messaging with your friends.....');
                            }
                          }
                        }),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xffccffcc).withOpacity(0.8)),
                  child: TextFormField(
                    onTap: () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    },
                    controller: controller.msgController,
                    decoration: InputDecoration(
                        hintText: 'Type message',
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              await controller.sendMessage(
                                  context: context,
                                  message: controller.msgController.text);
                              _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeOut);
                            },
                            icon: const Icon(
                              Icons.send,
                              size: 25,
                            ))),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
