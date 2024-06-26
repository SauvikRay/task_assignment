

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../../../app/services/navigation_services.dart';
import '../../../helper/overlay_helper.dart';
import '../../../helper/prefe_keys.dart';
import '../network/dio_provider.dart';
import '../network/error_handlers.dart';
import '../network/exceptions/base_exception.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  final logger = Logger();

  final storage = GetStorage();

  final dataLimit = 20;

  Future<Response<T>> getRequest<T>(String url, {Map<String, dynamic>? queryParams}) {
    var path = "${DioProvider.baseUrl}$url";
    var optionsWithoutToken = Options(headers: {});
    bool isLoggedIn = storage.read(PrefKeys.isLoggedIn) ?? false;
    var optionsWithToken = Options(headers: {'token': getUserToken()});
    return dioClient.get(path, queryParameters: queryParams, options: isLoggedIn ? optionsWithToken : optionsWithoutToken);
  }

  Future<Response<T>> postRequest<T>(String url, {Object? bodyParams,Options? options}) {
    var path = "${DioProvider.baseUrl}$url";
  
    bool isLoggedIn = storage.read(PrefKeys.isLoggedIn) ?? false;
    var optionsWithToken = Options(headers: {'token': getUserToken()});
    return dioClient.post(path, data: bodyParams, options: isLoggedIn ? optionsWithToken : options);
  }

  String getUserToken() {
    return storage.read(PrefKeys.usersToken) ?? "";
  }

  String getUserFirebaseToken() {
    return storage.read(PrefKeys.firebaseToken) ?? "";
  }

  String getDeviceType() {
    if (Platform.isAndroid) {
      return "Android";
    } else {
      return "IOS";
    }
  }

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;

      /* if (response.statusCode != HttpStatus.ok ||
          (response.data as Map<String, dynamic>)['statusCode'] !=
              HttpStatus.ok) {}*/

      return response;
    } on DioException catch (dioError) {
      Exception exception = handleDioError(dioError);
      logger.e("Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");

      if (!isDialogOpened.value) {
        isDialogOpened.value = true;
        OverlayEntry overlayEntry = insertOverlay(navigatorKey.currentContext!, exception.message);
        navigatorKey.currentState!.overlay!.insert(overlayEntry);
        Future.delayed(const Duration(seconds: 5)).then((value) {
          overlayEntry.remove();
          isDialogOpened.value = false;
        });
      }

      throw exception;
    } catch (error) {
      logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
