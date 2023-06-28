

import 'package:get/get.dart';
import 'package:phone_auth_firebase/constants/firebase_constants.dart';

class HomeController extends GetxController{

  var username="".obs;
  var password ="".obs;
  var userImage= "".obs;
  getUser()async{
    var data=await fireStore.collection(usersCollection).doc(auth.currentUser!.uid).snapshots().first;
    username.value = data.data()?['name'];
    password.value= data.data()?['password'];
    userImage.value= data.data()?['profileImage'];
  }
}