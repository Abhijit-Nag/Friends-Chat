import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/controller/authController.dart';
import 'package:phone_auth_firebase/views/authentication/otp_screen.dart';
import 'package:phone_auth_firebase/views/authentication/user_login_screen.dart';
import 'package:phone_auth_firebase/views/homepage/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // var phoneController= TextEditingController();
  var controller = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");
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
                Image.asset(
                  'assets/images/signup_bg.png',
                  height: 250,
                ),
                Text(
                  'Registration',
                  style: GoogleFonts.firaSans(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                10.heightBox,
                Text(
                  "Register and start chatting with your friends",
                  style: TextStyle(color: Colors.black.withOpacity(0.58)),
                  textAlign: TextAlign.center,
                ).marginSymmetric(horizontal: 20),
                15.heightBox,

                // TextFormField(
                //     controller: controller.phoneController.value,
                //     onChanged: (value){
                //       controller.phone(value);
                //     },
                //     decoration: InputDecoration(
                //         hintText: "Enter phone number",
                //         enabledBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(color: Colors.black12)),
                //         focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: const BorderSide(color: Colors.black12)),
                //         prefixIcon: InkWell(
                //           onTap: (){
                //             showCountryPicker(
                //                 countryListTheme: const CountryListThemeData(
                //                     bottomSheetHeight: 550
                //                 ),
                //                 context: context, onSelect: (value){
                //               setState(() {
                //                 selectedCountry= value;
                //               });
                //             });
                //           },
                //           child: Container(
                //               width: 100,
                //               padding: const EdgeInsets.all(8.0),
                //               child: Center(
                //                   child: Text(
                //                     '${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}',
                //                     style: GoogleFonts.firaSans(
                //                         fontSize: 18,
                //                         fontWeight: FontWeight.bold
                //                     ),
                //                   )
                //               )
                //           ),
                //         ),
                //
                //         suffixIcon:
                //         Obx(() => (controller.phone.value.length==10)?
                //         const Icon(Icons.done):
                //
                //         const Icon(Icons.error_outlined))
                //
                //
                //     )
                // ),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                  ),
                ).box.width(MediaQuery.of(context).size.width * 0.8).make(),
                10.heightBox,
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                  ),
                ).box.width(MediaQuery.of(context).size.width * 0.8).make(),
                10.heightBox,
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12)),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.purple,
                    ),
                  ),
                ).box.width(MediaQuery.of(context).size.width * 0.8).make(),
                20.heightBox,
                
                Obx(() => Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child:  controller.isLoading.value ? const CircularProgressIndicator(color: Colors.white,):Text(
                      'Sign Up',
                      style: GoogleFonts.firaSans(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ).onTap(() async {
                  // await controller.sendOTP(codeCountry: selectedCountry.phoneCode);
                  // Get.offAll(()=>OtpScreen());
                  controller.isLoading(true);
                  try {
                    var userCredential = await controller.signUpEmail(
                        context: context,
                        email: emailController.text,
                        password: passwordController.text);
                    print(userCredential!.user!.uid);
                    await controller.storeUserData(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        id: userCredential!.user!.uid);
                    controller.isLoading(false);
                    VxToast.show(context,
                        msg: "Created user account successfully in the app..");
                    Get.offAll(()=>HomeScreen());
                  } catch (e) {
                    VxToast.show(context, msg: e.toString());
                    controller.isLoading(false);
                  }
                })),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Already have account?',
                      style: TextStyle(color: Colors.black.withOpacity(0.58)),
                    ),
                    10.widthBox,
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'Login',
                          style: GoogleFonts.firaSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ).onTap(() {
                      //  login method call
                      Get.to(() => UserLoginScreen());
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
