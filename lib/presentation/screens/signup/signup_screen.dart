import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_colors.dart';
import 'package:task_assignment/app/config/app_constants.dart';
import 'package:task_assignment/app/config/app_space.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';
import 'package:task_assignment/presentation/widgets/base_action_button.dart';
import 'package:task_assignment/presentation/widgets/base_edit_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    final platformBrigthness = MediaQuery.of(context).platformBrightness;
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SpaceHepler.verticalSpace(kTextTabBarHeight),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 122,
                      width: 122,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [BoxShadow(blurRadius: 3, spreadRadius: 0, color: AppColors.shadowColor, offset: Offset(0, 2))]),
                      child: Center(
                        child: SvgPicture.asset(
                          AssetStrings.icMan,
                          height: 32,
                          width: 25.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.gradient1, AppColors.gradient2]),
                          boxShadow: const [BoxShadow(blurRadius: 5, spreadRadius: 0, color: AppColors.shadowColor, offset: Offset(0, 3))]),
                      child: Center(
                        child: SvgPicture.asset(
                          AssetStrings.icCam,
                          height: 13,
                          width: 13,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SpaceHepler.verticalMedium,
                SpaceHepler.verticalSpace(80.00),
                Text('Sign In', style: AppTextStyles.boldTitle),
                SpaceHepler.verticalMedium,
                BaseEditText(
                  textController: _textEditingController,
                  inputType: TextInputType.emailAddress,
                  placeHolder: 'Email',
                  prefixIcon: AssetStrings.icEmail,
                ),
                SpaceHepler.verticalMedium,
                // BaseEditText(
                //   textController: _passwordController,
                //   inputType: TextInputType.text,
                //   placeHolder: 'Password',
                //   prefixIcon: AssetStrings.icLock,
                //   isObsecure: isObsecure,
                //   suffixWidget: IconButton(
                //     // splashRadius: 20,
                //     iconSize: 30,
                //     icon: SvgPicture.asset('assets/icon/ic_close_eye.svg'),
                //     onPressed: () {
                //       setState(() {
                //         isObsecure = !isObsecure;
                //       });
                //     },
                //   ),
                // ),
                SpaceHepler.verticalMedium,
                Align(alignment: Alignment.centerRight, child: Text('Forgot Password?', style: AppTextStyles.disabledText)),
                SpaceHepler.verticalMedium,
                BaseActionButton(title: 'Login', height: 60, onPress: () {}),
                SpaceHepler.verticalLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialSignupButton(
                      icon: AssetStrings.icfacebook,
                      onPressed: () {},
                    ),
                    SpaceHepler.horizontalMedium,
                    SocialSignupButton(
                      icon: AssetStrings.icGoogle,
                      svgHeight: 30.91,
                      svgWidth: 30.91,
                      onPressed: () {},
                    ),
                  ],
                ),
                SpaceHepler.verticalMedium,
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Create New Account',
                    style: AppTextStyles.createAcount,
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
