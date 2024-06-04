import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_colors.dart';
import 'package:task_assignment/app/config/app_constants.dart';
import 'package:task_assignment/app/config/asset_strings.dart';

import '../account/account_screen.dart';
import '../product/product_screen.dart';
import 'custom_bottom_appbar.dart';
import 'roundedcorner_circular_notch.dart';
import 'tabItem.dart';

class MainBottomNavigationBar extends StatefulWidget {
  const MainBottomNavigationBar({super.key});

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int currentIndex = 0;
  List<Widget> pages = [ProductScreen(), Home(index: 1), Home(index: 2), AccountPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), gradient:const LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [AppColors.gradient3, AppColors.gradient4])),
              child: Center(
                child: SvgPicture.asset('assets/icon/ic_search.svg'),
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: MyBottomAppBar(
            height: 60,
            notchMargin: 10,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            shape: const RoundedCircularNotchedRectangle(cornerRadius: 20.0),
            currentIndex: currentIndex,
            onTap: (index) {
              log('Value $index');
              currentIndex = index;
              setState(() {});
            },
            items: [
              TabItem(
                  icon: SvgPicture.asset( AssetStrings.icHome
               
              ),activeIcon:SvgPicture.asset(
                AssetStrings.icHome,colorFilter:const ColorFilter.mode(AppColors.gradient3,BlendMode.srcIn),
              ) ),
              TabItem(
                icon: SvgPicture.asset(
                 AssetStrings.icBox,
                ),
                activeIcon:SvgPicture.asset(
                AssetStrings.icBox,colorFilter:const ColorFilter.mode(AppColors.gradient3,BlendMode.srcIn),
              )

              ),
              TabItem(
                icon: SvgPicture.asset(
                 AssetStrings.icCart,
                ),
                 activeIcon:SvgPicture.asset(
                AssetStrings.icCart,colorFilter:const ColorFilter.mode(AppColors.gradient3,BlendMode.srcIn),
              )
              ),
              TabItem(
                  icon: SvgPicture.asset(
                AssetStrings.icMan,
                height: 25,
                width: 25,
              ),
               activeIcon:SvgPicture.asset(
                AssetStrings.icMan, height: 25,
                width: 25,colorFilter:const ColorFilter.mode(AppColors.gradient3,BlendMode.srcIn),
              )
              ),
            ]));
  }
}
