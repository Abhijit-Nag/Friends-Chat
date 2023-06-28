import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/views/authentication/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  changeScreen(){
    Future.delayed(const Duration(milliseconds: 2000),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: const Color(0xffccffcc)
            .withOpacity(0.5),
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 150,),
            8.heightBox,
            Text('FriendsChat',
            style: GoogleFonts.firaSans(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.purple
            ),),
            Text('Chat with your friends in real-time', style: GoogleFonts.firaSans(
              fontSize: 15, color: Colors.black.withOpacity(0.5)
            ),)
          ],
        ),),
      ),
    );
  }
}
