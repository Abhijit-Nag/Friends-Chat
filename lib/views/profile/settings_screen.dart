import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/home_controller.dart';
import 'package:phone_auth_firebase/controller/settings_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var controller = Get.put(SettingsController());
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.nameController.text = Get.find<HomeController>().username.value;
    print('username in setting screen is: ${controller.nameController.text}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        title: Text(
          'FriendsChat',
          style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w800, color: Colors.white),
        ),
        actions: [
          Text(
            'Profile Update',
            style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w800, color: Colors.white),
          ).marginOnly(right: 15)
        ],
      ),

      body: Obx(()=>ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          15.heightBox,
          (controller.profileImagePath.value.isEmpty && homeController.userImage.value.isNotEmpty)?CircleAvatar(radius: 85, backgroundImage: NetworkImage(homeController.userImage.value)):
          (controller.profileImagePath.value.isNotEmpty) ?CircleAvatar(radius:85, backgroundImage: FileImage(File(controller.profileImagePath.value))):
          const CircleAvatar(radius: 55, child: Icon(Icons.person, size: 55,)),
          IconButton(
              onPressed: () {
                print('change button clicked!!');
                controller.changeImage(context: context);
              },
              icon: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Change',
                  style: GoogleFonts.firaSans(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            height: 50,
            child: TextFormField(
              controller: controller.nameController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  hintText: 'name',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black12))),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            height: 50,
            child: TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  hintText: 'Old Password',
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black12))),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 5),
            height: 50,
            child: TextFormField(
              controller: controller.newPasswordController,
              decoration: InputDecoration(
                  hintText: 'New Password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black12)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.black12))),
            ),
          ),
          IconButton(
              onPressed: () async{
                controller.isLoading(true);
                if(controller.newPasswordController.text.trim().isNotEmpty){
                  if(controller.passwordController.text == Get.find<HomeController>().password.value){
                    if(controller.profileImagePath.value.isNotEmpty) {
                      await controller.uploadImage();
                    }
                    await controller.updatePassword(email:auth.currentUser!.email, password: controller.passwordController.text, newPassword: controller.newPasswordController.text);
                    await controller.updateProfile(name: controller.nameController.text, password: controller.newPasswordController.text, imageURL: controller.profileImageLink);
                    VxToast.show(context, msg: "Profile Updated Successfully");
                  }else{
                    VxToast.show(context, msg: "Wrong old Password");
                  }
                }else{
                  VxToast.show(context, msg: "your new password section is empty!please fill it");
                }
                controller.isLoading(false);
              },
              icon: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: controller.isLoading.value? const CircularProgressIndicator(color: Colors.white,) :Text(
                  'Save',
                  style: GoogleFonts.firaSans(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )),

          Image.asset('assets/images/signup_bg.png',),

          // ElevatedButton(onPressed: (){}, child: Text('Save'))
        ],
      )),
    );
  }
}
