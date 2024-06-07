// import 'package:dio/dio.dart' as formData;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_assignment/data/models/login_response.dart';

import '../../models/signup_response.dart';
import '../core/base_remote_source.dart';
import 'mytask_remote_data_source.dart';

class MytaskRemoteDataSourceimpl extends BaseRemoteSource implements MyTaskRemoteDataSource {
  @override
  Future<LoginResponse> userLogin(String email, String password) async {
    String requestParams = 'wp-json/jwt-auth/v1/token?username=$email&password=$password';
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var dioCall = postRequest(requestParams, options: Options(headers: headers));

    try {
      var response = await callApiWithErrorParser(dioCall);

      return LoginResponse.fromJson(response.statusCode ?? 0, response.data);
    } catch (e) {
      if (kDebugMode) {
        log('Data Error : $e');
      }
      rethrow;
    }
  } 
  
  @override
  Future<SignUpResponse> userSignUp(String username, String email, String password) async {
    String requestParams = 'wp-json/wp/v2/users/register';
   final body={
  "username": username,
  "email": email,
  "password": password
};


    var dioCall = postRequest(requestParams, bodyParams: body);

    try {
      var response = await callApiWithErrorParser(dioCall);

      return SignUpResponse.fromJson(response.statusCode ?? 0, response.data);
    } catch (e) {
      if (kDebugMode) {
        log('Data Error : $e');
      }
      rethrow;
    }
  }

//End
}
