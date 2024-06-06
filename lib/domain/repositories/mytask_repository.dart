

import '../../data/models/login_response.dart';

abstract class MyTaskRepository {
  
    Future<LoginResponse> userLogin(String email, String password);
}
