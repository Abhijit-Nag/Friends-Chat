import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/views/authentication/signup_screen.dart';
import 'package:phone_auth_firebase/views/homepage/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset('assets/images/login_bg.png', height: 250,)).marginOnly(top: 25),
            10.heightBox,
            Text("Let's get started..", style: GoogleFonts.firaSans(
              fontSize: 25
            ),).marginOnly(top: 10),
            10.heightBox,
            Text('Ease your work with us', style: GoogleFonts.firaSans(
              color: Colors.grey,
              fontSize: 15
            ),),
            20.heightBox,
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(15.0),
              color: Colors.purple,
              child: Text(
                'Get Started',
                style: GoogleFonts.firaSans(
                  fontSize: 21,
                  color: Colors.white
                ),
              ),
            ).onTap(() {
              auth.authStateChanges().listen((User ? user) {
                if(user == null){
                  Get.to(()=> SignUpScreen());
                }else{
                  Get.offAll(()=> HomeScreen());
                }
              });

            })
          ],
        ),
      ),
    );
  }
}
