// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:phone_auth_firebase/controller/authController.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class OtpScreen extends StatelessWidget {
//   const OtpScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AuthController());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         shrinkWrap: true,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset('assets/images/signup_bg.png'),
//                 Text(
//                   'Registration',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 25, fontWeight: FontWeight.w600),
//                 ),
//                 10.heightBox,
//                 Text(
//                   "Add your phone number. We'll send you a verification code",
//                   style: TextStyle(color: Colors.black.withOpacity(0.58)),
//                   textAlign: TextAlign.center,
//                 ).marginSymmetric(horizontal: 20),
//                 15.heightBox,
//
//                 TextFormField(
//                     // controller: controller.otpController,
//                     decoration: InputDecoration(
//                         hintText: "Enter OTP",
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(color: Colors.black12)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(color: Colors.black12)),
//
//
//                         // suffixIcon:
//                         // Obx(() => (controller.phone.value.length==10)?
//                         // const Icon(Icons.done):
//                         //
//                         // const Icon(Icons.error_outlined))
//
//
//                     )
//                 ),
//                 20.heightBox,
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.6,
//                   padding: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                       color: Colors.purple,
//                       borderRadius: BorderRadius.circular(50)
//                   ),
//                   child: Center(
//                     child: Text('Login', style: GoogleFonts.firaSans(
//                         color: Colors.white,
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600
//                     ),),
//                   ),
//                 ).onTap(()async {
//                   await controller.loginMethod();
//                 })
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
