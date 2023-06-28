import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/authController.dart';
import 'package:phone_auth_firebase/views/homepage/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  var controller = Get.put(AuthController());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/signup_bg.png'),
                Text(
                  'Login',
                  style: GoogleFonts.firaSans(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                10.heightBox,
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)
                    ),

                    prefixIcon: const Icon(Icons.email, color: Colors.green,),
                  ),
                ).box.width(MediaQuery.of(context).size.width*0.8).make(),
                10.heightBox,
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)
                    ),

                    prefixIcon: const Icon(Icons.lock,color: Colors.purple,),
                  ),
                ).box.width(MediaQuery.of(context).size.width*0.8).make(),
                20.heightBox,
                Obx(() => Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(
                    child: controller.isLoading.value ? const CircularProgressIndicator(color: Colors.white,): Text('Login', style: GoogleFonts.firaSans(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                ).onTap(()async {
                  controller.isLoading(true);
                  try{
                    var userCredential = await controller.loginMethodWitEmail(
                        email: emailController.text,
                        password: passwordController.text);
                    if (auth.currentUser != null) {
                      VxToast.show(context, msg: "Logged in.");
                      Get.offAll(() => HomeScreen());
                    } else {
                      VxToast.show(context,
                          msg: "User does not exist! Please sign up.");
                    }
                  }catch(e){
                    VxToast.show(context, msg: e.toString());
                  }
                  controller.isLoading(false);
                })),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have account?", style: TextStyle(
                        color: Colors.black.withOpacity(0.58)
                    ),),
                    10.widthBox,
                    Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child: Text('Register', style: GoogleFonts.firaSans(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        ),),
                      ),
                    ).onTap(() {
                      //  login method call
                      Get.back();

                    })

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}