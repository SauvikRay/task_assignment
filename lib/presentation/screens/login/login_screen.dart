import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_colors.dart';

import 'package:task_assignment/app/config/app_space.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';
import 'package:task_assignment/presentation/controllers/logIn_signup_controler.dart';
import 'package:task_assignment/presentation/screens/signup/signup_screen.dart';
import 'package:task_assignment/presentation/widgets/base_action_button.dart';
import 'package:task_assignment/presentation/widgets/base_edit_text.dart';

import '../../../app/config/asset_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _logInController = Get.put(LoginSignUpControler());
  final TextEditingController _emailController = TextEditingController();
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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.scaffoldColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: platformBrigthness == Brightness.dark ? Brightness.dark : Brightness.light,
              statusBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
              statusBarIconBrightness: platformBrigthness == Brightness.dark ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AssetStrings.dokanLogo, fit: BoxFit.cover),
                    SpaceHepler.verticalSpace(80.00),
                    Text('Sign In', style: AppTextStyles.boldTitle),
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
                      suffixWidget: IconButton(
                        // splashRadius: 20,
                        iconSize: 30,
                        icon: SvgPicture.asset('assets/icon/ic_close_eye.svg'),
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                      ),
                    ),
                    SpaceHepler.verticalMedium,
                    Align(alignment: Alignment.centerRight, child: Text('Forgot Password?', style: AppTextStyles.disabledText)),
                    SpaceHepler.verticalMedium,
                    BaseActionButton(
                        title: 'Login',
                        height: 60,
                        onPress: () {
                          _logInController.processLogin(_emailController, _passwordController);
                        }),
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
                          svgHeight: 28,
                          svgWidth: 28,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SpaceHepler.verticalMedium,
                    InkWell(
                      onTap: () {
                        Get.to(() => SignupScreen(), transition: Transition.rightToLeft);
                      },
                      child: Text(
                        'Create New Account',
                        style: AppTextStyles.createAccount,
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
