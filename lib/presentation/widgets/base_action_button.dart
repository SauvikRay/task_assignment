// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_colors.dart';

class BaseActionButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final Color bgColor;
  final String icon;
  final Color? textColor;
  final double? height;

  const BaseActionButton({
    super.key,
    required this.title,
    required this.onPress,
    this.bgColor = AppColors.buttonActionColor,
    this.textColor = Colors.white,
    this.icon = "",
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor, elevation: 0, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon.isNotEmpty)
                SvgPicture.asset(
                  icon,
                  semanticsLabel: 'icon',
                ),
              if (icon.isNotEmpty)
                const SizedBox(
                  width: 7.0,
                ),
              Text(
                title,
                style: TextStyle(
                    color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : textColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialSignupButton extends StatelessWidget {
  const SocialSignupButton({super.key, required this.icon, required this.onPressed, this.svgHeight, this.svgWidth});
  final String icon;
  final VoidCallback onPressed;
  final double? svgHeight;
  final double? svgWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shadowColor: AppColors.shadowColor,
            backgroundColor: Colors.white,
            elevation: 1,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.cover,
          height: svgHeight,
          width: svgWidth,
        ),
      ),
    );
  }
}
