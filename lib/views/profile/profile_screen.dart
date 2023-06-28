import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/home_controller.dart';
import 'package:phone_auth_firebase/views/authentication/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);
var controller= Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    controller.getUser();

    print('profile Image :${controller.userImage.value}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        title: Text('Profile', style: GoogleFonts.firaSans(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),),
      ),
      body:  Obx(() => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Color(0xffccffcc).withOpacity(0.55)
          ),
          child: Column(
            children: [
              controller.userImage.value.isEmpty? const CircleAvatar( radius: 55, child: Icon(Icons.person, size: 55,),):
              Image.network(controller.userImage.value),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('NAME :', style: GoogleFonts.firaSans(
                    fontSize: 21
                  ),),
                  20.widthBox,
                  Text(controller.username.value,style: GoogleFonts.firaSans(
                      fontSize: 21,
                    fontWeight: FontWeight.w800
                  ),),
                ],
              ),
              15.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('EMAIL :',style: GoogleFonts.firaSans(
                      fontSize: 21
                  )),
                  20.widthBox,
                  Text(auth.currentUser!.email.toString(),style: GoogleFonts.firaSans(
                      fontSize: 21,
                      fontWeight: FontWeight.w800
                  )),
                ],
              ),
              25.heightBox,
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: const Text('LOGOUT', style: TextStyle(
                    color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),),
              ).onTap(()async {
                await auth.signOut();
                VxToast.show(context, msg: "Logged out!");
                Get.offAll(()=>LoginScreen());
              })
            ],
          ),
        ),
      )),
    );
  }
}
