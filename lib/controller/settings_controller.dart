
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class SettingsController extends GetxController{

  var nameController= TextEditingController();
  var passwordController = TextEditingController();
  var newPasswordController = TextEditingController();

  var profileImagePath= "".obs;

  var profileImageLink= "";

  var isLoading = false.obs;


  changeImage({required context})async{
    try{
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;
      profileImagePath.value = img.path;
    }on PlatformException catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage()async{
    var filename= basename(profileImagePath.value);
    var destination = 'images/${auth.currentUser!.uid}/$filename';
    Reference ref= FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink= await ref.getDownloadURL();
  }

  updateProfile({required name, required password, required imageURL})async{
    print('this is the profileImageLink: $profileImageLink');
    await fireStore.collection(usersCollection).doc(auth.currentUser!.uid).set({
      "name":name,
      "profileImage": imageURL,
      "password": password
    },
      SetOptions(merge: true)
    );
  }


  updatePassword({email, password, newPassword})async{
    final credentials= EmailAuthProvider.credential(email: email, password: password);
    await auth.currentUser!.reauthenticateWithCredential(credentials).then((value)async{
      await auth.currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });
  }



}