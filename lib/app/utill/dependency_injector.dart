
import 'package:get/get.dart';
import 'package:task_assignment/data/providers/remote/datasource/mytask_remote_data_sourceImpl.dart';
import 'package:task_assignment/domain/repositories/mytask_repositoryImpl.dart';

class DependencyInjector {
  static int(){
    Get.put( MytaskRemoteDataSourceimpl());
    Get.put(MyTaskRepositoryImpl());
  }
}