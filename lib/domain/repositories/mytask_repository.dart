

import 'package:task_assignment/data/models/signup_response.dart';

import '../../data/models/login_response.dart';

abstract class MyTaskRepository {
  
    Future<LoginResponse> userLogin(String email, String password);
    Future<SignUpResponse> userSignUp(String username, String email, String password);
}
