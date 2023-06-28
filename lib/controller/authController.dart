

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:phone_auth_firebase/views/homepage/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
class AuthController extends GetxController {
  // var phoneController= TextEditingController().obs;
  // var otpController = TextEditingController();
  // var phone = "".obs;
  // var ID= "".obs;
  //
  // // var _is_signedin= false.obs;
  //
  // sendOTP({codeCountry})async{
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '+$codeCountry${phone.value}',
  //       verificationCompleted: (phoneAuthCredentials)async{
  //         await auth.signInWithCredential(phoneAuthCredentials);
  //       },
  //       verificationFailed: (FirebaseAuthException e){
  //         print(e.toString());
  //       },
  //       codeSent: (String? verificationID, int? resendToken){
  //         ID.value= verificationID.toString();
  //       },
  //       codeAutoRetrievalTimeout: (value){
  //
  //       }
  //   );
  //   print(' this is verification ID: ${ID.value}');
  //   print('phone number is : +$codeCountry${phone.value}');
  // }
  //
  // loginMethod()async{
  //   try
  //   {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: ID.value, smsCode: otpController.text);
  //     await auth.signInWithCredential(credential);
  //     Get.offAll(()=> HomeScreen());
  //   }on FirebaseAuthException catch(e){
  //     print(e.toString());
  //   }
  // }

  var isLoading= false.obs;

  Future<UserCredential?>loginMethodWitEmail({email, password})async{
    UserCredential ? userCredential;
     userCredential= await auth.signInWithEmailAndPassword(email: email, password: password);
     return  userCredential;
  }

  Future<UserCredential?>signUpEmail({required context, required email, required password})async{
    UserCredential ? userCredential;
    try{
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    print(userCredential);
    return userCredential;
  }

  storeUserData({name, email, password, id})async{
    await fireStore.collection(usersCollection).doc(id).set({
      "name":name,
      "email":email,
      "password":password,
      "profileImage":"",
    });
  }

}