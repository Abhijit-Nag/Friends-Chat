import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/home_controller.dart';
import 'package:phone_auth_firebase/services/firebase_services.dart';
import 'package:phone_auth_firebase/views/authentication/login_screen.dart';
import 'package:phone_auth_firebase/views/chats/chats_screen.dart';
import 'package:phone_auth_firebase/views/profile/profile_screen.dart';
import 'package:phone_auth_firebase/views/profile/settings_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  var homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {

    homeController.getUser();

    print('username :${homeController.username.value}');
    print('userID: ${auth.currentUser!.uid}');
    return  Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: const Color(0xffccffcc)
            .withOpacity(0.5),
        title: Text('FriendsChat', style: GoogleFonts.firaSans(
            fontWeight: FontWeight.w800,
            color: Colors.purple
        ),),
        actions: [
          IconButton(onPressed: ()async{
            Get.to(()=>ProfileScreen());
          }, icon: const CircleAvatar(child: Icon(Icons.person,), )),
          IconButton(onPressed: (){
            print(auth.currentUser!.uid);
            Get.to(()=> SettingsScreen());
          }, icon: const Icon(Icons.settings,))
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: FireStoreServices.getAllUsers(),
              builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
              if(!snapshot.hasData){
                return const Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              }
              else{
                // print(snapshot.data!.docs);
                var data= snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        print('userID 1: ${data[index].id}\n userID 2:${auth.currentUser!.uid}');
                        if(data[index].id!= auth.currentUser!.uid) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              padding: const EdgeInsets.all(15.0),
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: ListTile(
                                leading: data[index]['profileImage'].toString().isNotEmpty?
                                    CircleAvatar(radius: 25, backgroundImage: NetworkImage(data[index]['profileImage'].toString()),):
                                const CircleAvatar(
                                  radius: 25,
                                  child: Icon(Icons.person),
                                ),
                                title: Text(data[index]['name']),
                                trailing: const Icon(Icons.comment_rounded),
                              ),
                            ).onTap(() {
                              Get.to(()=>ChatsScreen(friendProfileImage: data[index]['profileImage']),
                              arguments: [
                                data[index]['name'], data[index].id
                              ]);
                            });
                          }else {
                            return Container();
                          }
                        }),
                );
              }
              }),

        ],
      ),
    );
  }
}
