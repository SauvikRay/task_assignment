import 'package:get/get.dart';
import 'package:task_assignment/data/remote/datasource/mytask_remote_data_source.dart';
import 'package:task_assignment/domain/repositories/mytask_repository.dart';

import '../../data/models/login_response.dart';
import '../../data/models/signup_response.dart';
import '../../data/remote/datasource/mytask_remote_data_sourceImpl.dart';

class MyTaskRepositoryImpl implements MyTaskRepository {
  final MyTaskRemoteDataSource _dataSource = Get.find<MytaskRemoteDataSourceimpl>();

@override
  Future<LoginResponse> userLogin(String email, String password) {
    return _dataSource.userLogin(email, password);
  }
  @override
  Future<SignUpResponse> userSignUp(String username, String email, String password){
    return _dataSource.userSignUp(username,email,password);
  }
}
//End
