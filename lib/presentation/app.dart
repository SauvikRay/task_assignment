import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_assignment/app/config/app_colors.dart';
import 'package:task_assignment/presentation/screens/login/login_screen.dart';

import '../app/services/navigation_services.dart';
import 'screens/bottom_navigation_bar/main_navigation_screen.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final platformBrigthness=MediaQuery.of(context).platformBrightness;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false,fontFamily: 'Roboto',brightness: Brightness.light).copyWith(
        
        
        scaffoldBackgroundColor: AppColors.scaffoldColor,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      })),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(useMaterial3: false,fontFamily: 'Roboto',brightness: Brightness.dark),
      navigatorKey: navigatorKey,
      home:AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle(
          statusBarBrightness: platformBrigthness == Brightness.dark ? Brightness.dark : Brightness.light,
        statusBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
        statusBarIconBrightness: platformBrigthness == Brightness.dark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: platformBrigthness == Brightness.dark?Brightness.light : Brightness.dark,
        systemNavigationBarColor:platformBrigthness == Brightness.dark ? Colors.black87: AppColors.scaffoldColor,
        ),
        
        child:MainBottomNavigationBar() // const LoginScreen()),
    ));
  }
}