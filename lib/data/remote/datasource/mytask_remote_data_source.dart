

import '../../models/login_response.dart';

abstract class MyTaskRemoteDataSource {
  //Start
Future<LoginResponse> userLogin(String email, String password);
//End
}
