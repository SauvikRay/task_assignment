import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_colors.dart';
import 'package:task_assignment/app/config/app_constants.dart';
import 'package:task_assignment/app/config/app_space.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';
import 'package:task_assignment/presentation/widgets/base_action_button.dart';
import 'package:task_assignment/presentation/widgets/base_edit_text.dart';

import '../../../app/config/asset_strings.dart';
import '../bottom_navigation_bar/main_navigation_screen.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SpaceHepler.verticalSpace(kTextTabBarHeight + kTextTabBarHeight),
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
                          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.gradient1, AppColors.gradient2]),
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
                SpaceHepler.verticalMedium,
                BaseEditText(
                  textController: _nameController,
                  inputType: TextInputType.text,
                  placeHolder: 'Name',
                  prefixIcon: AssetStrings.icMan,
                ),
                SpaceHepler.verticalMedium,
                BaseEditText(
                  textController: _emailController,
                  inputType: TextInputType.emailAddress,
                  placeHolder: 'Email',
                  prefixIcon: AssetStrings.icEmail,
                ),
                SpaceHepler.verticalMedium,
                BaseEditText(
                  textController: _passwordController,
                  inputType: TextInputType.text,
                  placeHolder: 'Password',
                  prefixIcon: AssetStrings.icLock,
                  isObsecure: isObsecure,
                ),
                SpaceHepler.verticalMedium,
                BaseEditText(
                  textController: _confirmpasswordController,
                  inputType: TextInputType.text,
                  placeHolder: 'Confirm Password',
                  prefixIcon: AssetStrings.icLock,
                  isObsecure: isObsecure,
                ),
                SpaceHepler.verticalMedium,
                SpaceHepler.verticalMedium,
                SpaceHepler.verticalMedium,
                BaseActionButton(title: 'Sign Up', height: 60, onPress: () {Get.to(()=>MainBottomNavigationBar(),transition: Transition.rightToLeft);}),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: AppTextStyles.createAccount,
                    ),
                    TextButton(
                      onPressed: () {
                      Get.back();
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero,elevation: 0,textStyle: AppTextStyles.textButton),child:const Text('Login'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}


