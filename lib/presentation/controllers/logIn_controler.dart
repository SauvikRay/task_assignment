import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_assignment/domain/repositories/mytask_repositoryImpl.dart';
import 'package:task_assignment/presentation/screens/bottom_navigation_bar/main_navigation_screen.dart';

import '../../app/config/app_text.dart';
import '../../data/helper/prefe_keys.dart';
import '../widgets/loader_widget.dart';
import 'dart:developer' as dev;

class LoginControler extends GetxController{
  final _repository = Get.find<MyTaskRepositoryImpl>();
final _storage=GetStorage();
  
  processLogin(TextEditingController emailController,TextEditingController passwordController) {
    String email = emailController.text.trim();
    String password = passwordController.text;

    String errorMessage = "";

    if (email.isEmpty) {
      errorMessage = AppText.emailText;
    } else if (!GetUtils.isEmail(email)) {
      errorMessage = AppText.emailFormet;
    } else if (password.isEmpty) {
      errorMessage = AppText.passwordText;
    }

    if (errorMessage.isEmpty) {
     login(email, password, (isSuccess) {
        if (isSuccess) {
          //Load profile data
          // _controller.profile(widget.isFromComment);
          Get.offAll(()=>const MainBottomNavigationBar(),transition: Transition.cupertino);
        }
      });
    } else {
      Fluttertoast.showToast(msg: errorMessage);
    }
  }



   login(String email, String password, Function(bool isSuccess) onSuccess) async {
    await showLoader();

    try {
      var signInResponse = await _repository.userLogin(email,password);
      if(signInResponse.statusCode==200){
        Get.back();


        _storage.write(PrefKeys.usersToken, signInResponse.token);
        _storage.write(PrefKeys.isLoggedIn, true);
        dev.log("usersingUpToken ${_storage.read(PrefKeys.usersToken)}");
        if (kDebugMode) {
          print("Sing in SucessFull");
        }
        // Fluttertoast.showToast(msg: signInResponse.message ?? "");
        _storage.write(PrefKeys.isLoggedIn, true);

        onSuccess(true);
      } else {
        Fluttertoast.showToast(msg: signInResponse.message ?? "Something went wrong");
        Get.back();
        onSuccess(false);
      }
    } catch (error) {
      onSuccess(false);
      Get.back();
    }
  }

  


  
}