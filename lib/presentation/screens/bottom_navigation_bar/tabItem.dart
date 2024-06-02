import 'package:flutter/widgets.dart';

class TabItem {
  TabItem({this.key,required this.icon, this.label, Widget? activeIcon}) : activeIcon = activeIcon ?? icon;
  final Key? key;

  final Widget icon;
  final Widget activeIcon;
  final String? label;
}