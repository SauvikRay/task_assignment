import 'package:flutter/material.dart';
import 'package:task_assignment/app/utill/dependency_injector.dart';

import 'presentation/app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjector.int();
    // await initServices();
  runApp(const App());
}



