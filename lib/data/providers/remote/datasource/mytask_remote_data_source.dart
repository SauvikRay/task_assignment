

import '../../../models/login_response.dart';
import '../../../models/signup_response.dart';

abstract class MyTaskRemoteDataSource {
  //Start
Future<LoginResponse> userLogin(String email, String password);
Future<SignUpResponse> userSignUp(String username, String email, String password);

//End
}
