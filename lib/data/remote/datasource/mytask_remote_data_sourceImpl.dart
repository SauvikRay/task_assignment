// import 'package:dio/dio.dart' as formData;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_assignment/data/models/login_response.dart';

import '../core/base_remote_source.dart';
import 'mytask_remote_data_source.dart';

class MytaskRemoteDataSourceimpl extends BaseRemoteSource implements MyTaskRemoteDataSource {
  @override
  Future<LoginResponse> userLogin(String email, String password) async {
    String requestParams = 'wp-json/jwt-auth/v1/token?username=$email&password=$password';
    var headers = {
  'Content-Type': 'application/x-www-form-urlencoded'
};
    var dioCall = postRequest(requestParams, options: Options(headers: headers));




    try {
      var response = await callApiWithErrorParser(dioCall);


      return LoginResponse.fromJson(response.statusCode ?? 400, response.data);
    } catch (e) {
      if (kDebugMode) {
        log('Data Error : $e');
      }
      rethrow;
    }
  }
  // //Post Login Api Integration
  // @override
  // Future<UserTopicsResponse> getUserTopics() async {
  //   var dioCall = getRequest("category-list");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     return UserTopicsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<HomeNewsResponse> getHomeNews() async {
  //   var dioCall = getRequest("home");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     return HomeNewsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<LatestNewsResponse> getLatestNews(int offset) async {
  //   final queryParams = {"limit": dataLimit, "offset": offset};
  //   var dioCall = getRequest("latest-news", queryParams: queryParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     return LatestNewsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<CategoryNewsResponse> getCategoriesNews(int categoryId, int? subCategoryId, int? childCategoryId, int offset) async {
  //   final queryParams = {"limit": dataLimit, "offset": offset, "category": categoryId, "sub_category": subCategoryId, "child_category": childCategoryId};
  //   var dioCall = getRequest("news-list", queryParams: queryParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     return CategoryNewsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SubcategoryResponse> getSubcategory(int categoryId) async {
  //   var dioCall = getRequest("subcategory-list/$categoryId");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     return SubcategoryResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<NewsDetailsResponse> getNewsDetails(String newsUrl) async {
  //   var dioCall = getRequest("news-details/$newsUrl");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);

  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     // log("${response.data}");
  //     return NewsDetailsResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<RelatedTopicsResponse> getRelatedTopicsResponse(String slug, int offset) async {
  //   final queryParams = {
  //     "slug": slug,
  //     "limit": dataLimit,
  //     "offset": offset,
  //   };
  //   var dioCall = getRequest("tag-post", queryParams: queryParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);

  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     // log("${response.data}");
  //     return RelatedTopicsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<PhotoNewsResponse> getPhotoNews() async {
  //   var dioCall = getRequest("photo-news-home");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("GetPhotoNews");
  //       }
  //     }
  //     return PhotoNewsResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<LatestPhotoResponse> getLatestPhotoNews(String categoryName, int offset) async {
  //   final queryParams = {"limit": dataLimit, "offset": offset};
  //   var dioCall = getRequest(categoryName, queryParams: queryParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("getLatestPhotoNews");
  //       }
  //     }
  //     return LatestPhotoResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<PhotoNewsDetailsResponse> getPhotoNewsDetails(String slug) async {
  //   var dioCall = getRequest("photo-news-details/$slug");

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We received getPhotoNews data");
  //       }
  //     }
  //     log("${PhotoNewsDetailsResponse.fromMap(response.data)}");
  //     return PhotoNewsDetailsResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SearchResultResponse> getSearchResult(String userValue, String newsTab, int offset) async {
  //   final queryParams = {
  //     "type": "submitted",
  //     "limit": dataLimit,
  //     "offset": offset,
  //     "search": userValue,
  //     "newsTab": newsTab,
  //   };
  //   var dioCall = getRequest("news-search", queryParams: queryParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);

  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We received SearchResult data");
  //       }
  //     }
  //     return SearchResultResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SearchAutoCompleteResponse> getSearchSuggestion(String userValue, int offset) async {
  //   final queryParams = {
  //     "type": "autocomplete",
  //     "limit": dataLimit,
  //     "offset": offset,
  //     "search": userValue,
  //     // "newsTab": newsTab,
  //   };
  //   var dioCall = getRequest("news-search", queryParams: queryParams);

  //   log("value :$dioCall");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);

  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We received SearchResult data");
  //       }
  //     }
  //     return SearchAutoCompleteResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SearchResponse> getSearchResponse(int offset) async {
  //   final queryParams = {
  //     "limit": 6,
  //     "offset": offset,
  //   };
  //   var dioCall = getRequest("news-search-suggestion?", queryParams: queryParams);

  //   // log("value :$dioCall");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);

  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We received SearchResult data");
  //       }
  //     }
  //     return SearchResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<VideoCateroryResponse> getVideoCateroryList() async {
  //   var dioCall = getRequest(
  //     "subcategory-list/87",
  //   );
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We received getVideoCateroryList");
  //       }
  //     }
  //     return VideoCateroryResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<VideoNewsResponse> getVideoNews(String category, String subCateSlug, String childSubCateSlug, int offset) async {
  //   final queryParams = {
  //     "category": category,
  //     "sub_category": subCateSlug,
  //     "child_category": childSubCateSlug,
  //     "limit": dataLimit,
  //     "offset": offset,
  //   };

  //   var dioCall = getRequest("video-category", queryParams: queryParams);

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We received video data");
  //       }
  //     }
  //     // log("${response.data}");
  //     return VideoNewsResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForYouNewsResponse> getForNews(List<dynamic> userChooseList) async {
  //   // var ids = userChooseList.toString();

  //   log('Ids ${userChooseList.join(',')}');
  //   final queryParams = {
  //     "category": userChooseList.join(','),
  //   };
  //   var dioCall = getRequest("home-for-you", queryParams: queryParams);

  //   log("dio call$dioCall");

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // log("We received For you data: ${response.data}");
  //       // log("We received For you data");
  //     }
  //     return ForYouNewsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error king : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForYouNewsResponse> getForCategoryNews(String id) async {
  //   final queryParams = {
  //     "category": id,
  //   };
  //   var dioCall = getRequest("home-for-you", queryParams: queryParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We Receive getForCategory News");
  //       }
  //     }
  //     return ForYouNewsResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SignInResponse> postLoginDetails(String email, String password) async {
  //   final requestParams = formData.FormData.fromMap({"email": email, "password": password, "device_token": getUserFirebaseToken(), "device_type": getDeviceType()});
  //   var dioCall = postRequest("sign-in", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {}
  //     return SignInResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SingUpResponse> postsingUpetails(String fName, String lName, String email, String birth, String password, String gender, String loaction) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "role_id": 6,
  //     "first_name": fName,
  //     "last_name": lName,
  //     "email": email,
  //     "dob": birth,
  //     "password": password,
  //     "gender": gender,
  //     "location": loaction,
  //     "device_token": getUserFirebaseToken(),
  //     "device_type": getDeviceType(),
  //   });

  //   var dioCall = postRequest("sign-up", bodyParams: requestParams);

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     log("${response.data}");
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("Receive value");
  //       }
  //     }
  //     log("${response.data}");
  //     return SingUpResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ProfileResponse> getProfileDetails() async {
  //   var dioCall = getRequest(
  //     "profile",
  //   );

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("profile data received");
  //       }
  //     }
  //     return ProfileResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<DeleteAccountResponse> getUserDeleteAccount() async {
  //   var dioCall = getRequest(
  //     "user-delete",
  //   );

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("Account Deleted");
  //       }
  //     }
  //     return DeleteAccountResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForgetPasswordResponse> postPasswordForgot(String email) async {
  //   final requestParams = formData.FormData.fromMap({"email": email});

  //   var dioCall = postRequest("forget-password", bodyParams: requestParams);

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("We post forgot password ");
  //       }
  //     }
  //     return ForgetPasswordResponse.fromMap(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('Data Error : $e');
  //     }
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForgetPasswordResponse> postPasswordReset(String code, String email, String uppassword) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "code": code,
  //     "email": email,
  //     "password": uppassword,
  //   });
  //   var dioCall = postRequest("reset-password-action", bodyParams: requestParams);

  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("post resetpasswordAction");
  //       }
  //     }
  //     return ForgetPasswordResponse.fromMap(response.data);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForgetPasswordResponse> profileUpdate(String fName, String lName, String cTZip) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "first_name": fName,
  //     "last_name": lName,
  //     "dob": "",
  //     "location": cTZip,
  //     "biography": "Text",
  //     "facebook_link": "",
  //     "twitter_link": "",
  //     "instagram_link": "",
  //   });
  //   var dioCall = postRequest("profile-update", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("post profileUpdate");
  //       }
  //     }
  //     return ForgetPasswordResponse.fromMap(response.data);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForgetPasswordResponse> profilePictureChange(String image) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "photo": await formData.MultipartFile.fromFile(image),
  //   });

  //   var dioCall = postRequest("profile-picture-change", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("profile update data");
  //       }
  //     }
  //     return ForgetPasswordResponse.fromMap(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<ForgetPasswordResponse> resetPassword(String oldPassword, String newPassword) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "old_password": oldPassword,
  //     "new_password": newPassword,
  //   });

  //   var dioCall = postRequest("change-password", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("reset password");
  //       }
  //     }
  //     return ForgetPasswordResponse.fromMap(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<AddCommentResponse> addComment(String postId, String comment, String parentId) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "post_id": postId,
  //     "comment": comment,
  //     "parent_id": parentId,
  //   });
  //   var dioCall = postRequest("add-comment", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("Add comment");
  //       }
  //     }
  //     return AddCommentResponse.fromMap(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<PhotoAddCommentResponse> photoAddComment(String postId, String comment, String parentId, String type) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "post_id": postId,
  //     "comment": comment,
  //     "parent_id": parentId,
  //     "type": type,
  //   });
  //   var dioCall = postRequest("add-comment", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("Add comment");
  //       }
  //     }
  //     return PhotoAddCommentResponse.fromMap(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<SocialLoginResponse> socialLogin(
  //   String provider,
  //   String uid,
  //   String firstName,
  //   String lastName,
  //   String email,
  //   String gender,
  //   String profilePhoto,
  // ) async {
  //   final requestParams = formData.FormData.fromMap({
  //     "oauth_provider": provider,
  //     "oauth_uid": uid,
  //     "first_name": firstName,
  //     "last_name": lastName,
  //     "email": email,
  //     "gender": gender,
  //     "profile_photo": profilePhoto,
  //     "device_token": getUserFirebaseToken(),
  //     "device_type": getDeviceType(),
  //   });
  //   var dioCall = postRequest("social-login", bodyParams: requestParams);
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print("Add comment");
  //       }
  //     }
  //     return SocialLoginResponse.fromMap(response.data);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // @override
  // Future<AppVersionResponse> getAppVersionResponse() async {
  //   var dioCall = getRequest("version");
  //   try {
  //     var response = await callApiWithErrorParser(dioCall);
  //     if (response.statusCode == 200) {
  //       // GetX.Get.back();
  //       // log('Login Response: ${response.data['success']}');
  //     }
  //     return AppVersionResponse.fromJson(response.data);
  //   } catch (e) {
  //     if (kDebugMode) {
  //       log('App Version Error : $e');
  //     }
  //     rethrow;
  //   }
  // }
//End
}
