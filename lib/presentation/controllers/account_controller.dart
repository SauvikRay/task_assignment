import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_assignment/presentation/screens/login/login_screen.dart';

import '../../data/helper/prefe_keys.dart';

class AccountController extends GetxController{
    final _storage = GetStorage();
    String userEmail='';
    String userName='';
    String nickName='';
Future<void>getUserDetails()async{
  final userData=await _storage.read(PrefKeys.userData);
  userEmail=userData['email'];
  userName=userData['name'];
  nickName=userData['nickName'];

}

  void userLogOut(BuildContext context) {
    
    Get.dialog(
      CupertinoAlertDialog(
        title:const Text(
          "Logout",
          style : TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),
        ),
        content:const Text(
          "Do you want to logout your account?",
          style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),
        ),
        actions: [
          CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                _storage.write(PrefKeys.isLoggedIn, false);
                _storage.remove(PrefKeys.usersToken);
                _storage.remove(PrefKeys.userData);
         


                Get.offAll(() => const LoginScreen(), transition: Transition.cupertino);
              },
              child: const Text("Yes")),
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Get.back();
              },
              child: const Text("No")),
        ],
      ),
    );
  }
}