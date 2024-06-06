import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_space.dart';
import 'package:task_assignment/app/config/asset_strings.dart';
import 'package:task_assignment/presentation/widgets/apply_and_cancle_button.dart';
import 'package:task_assignment/presentation/widgets/base_edit_text.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Widget prepareProfileRelatedData(List<ProfileUtilityModel> models) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 3,
        shadowColor: const Color(0xff395AB8).withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: models.length,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.black12,
              );
              //  customDivider(systemBrigthness: systemBrigthness, color: Colors.black12);
            },
            itemBuilder: (context, index) {
              ProfileUtilityModel model = models[index];

              return ExpansionTile(
                tilePadding: EdgeInsets.zero,
                onExpansionChanged: (value) {
                  log('Expansion tile change');
                },
                title: Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "${model.imageUrl}",
                        semanticsLabel: 'Profile',
                        height: 25,
                        width: 25,
                      ),
                      SpaceHepler.horizontalSpace(15),
                      (model.wishlist != 0)
                          ? RichText(
                              text: TextSpan(children: [
                                TextSpan(text: model.title, style: AppTextStyles.placeHolderText(color: Colors.black)),
                                TextSpan(text: ' (${model.wishlist})', style: AppTextStyles.placeHolderText(color: null)),
                              ]),
                            )
                          : Text(model.title, style: AppTextStyles.placeHolderText(color: Colors.black)),
                      const Spacer(),
                      // const Icon(
                      //   Icons.arrow_forward_ios_rounded,
                      //   size: 15,
                      // )
                    ],
                  ),
                ),
                childrenPadding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                children: [
                  if (index == 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: AppTextStyles.tileTitle,
                        ),
                        SpaceHepler.verticalSmall,
                        BaseEditText(
                          textController: TextEditingController(text: 'sauvik@gmail.com'),
                          inputType: TextInputType.text,
                          placeHolder: 'Email',
                        ),
                        SpaceHepler.verticalMedium,
                        Text(
                          'Full Name',
                          style: AppTextStyles.tileTitle,
                        ),
                        SpaceHepler.verticalSmall,
                        BaseEditText(
                          textController: TextEditingController(text: 'sauvik@gmail.com'),
                          inputType: TextInputType.text,
                          placeHolder: 'Email',
                        ),
                        SpaceHepler.verticalMedium,
                        Text(
                          'Street Address',
                          style: AppTextStyles.tileTitle,
                        ),
                        SpaceHepler.verticalSmall,
                        BaseEditText(
                          textController: TextEditingController(text: 'sauvik@gmail.com'),
                          inputType: TextInputType.text,
                          placeHolder: 'Email',
                        ),
                        SpaceHepler.verticalMedium,
                        Text(
                          'Apt, Suite, Bldg (optional)',
                          style: AppTextStyles.tileTitle,
                        ),
                        SpaceHepler.verticalSmall,
                        BaseEditText(
                          textController: TextEditingController(text: 'sauvik@gmail.com'),
                          inputType: TextInputType.text,
                          placeHolder: 'Email',
                        ),
                        SpaceHepler.verticalMedium,
                        Text(
                          'Zip Code',
                          style: AppTextStyles.tileTitle,
                        ),
                        SpaceHepler.verticalSmall,
                        BaseEditText(
                          textController: TextEditingController(text: 'sauvik@gmail.com'),
                          inputType: TextInputType.text,
                          placeHolder: 'Email',
                        ),
                        SpaceHepler.verticalMedium,
                        ApplyAndCancleButton(buttonWidth: 110, onCancle: () {}, onApply: () {})
                      ],
                    ),
                ],
              );
            }),
      ),
    );
  }

  _handleItemClick(ProfileElementMapper elementId, BuildContext context) {
    // Check user is logged in or not

    //eta por e comment out korte hobe ekon tuo user loggin nei tai kaj korar jonno comment kore raka

    // if (!_controller.isLoggedIn.value) {
    //   // Goto sign in page
    //   Get.to(() => const SignInScreen());
    //   return;
    // }

    switch (elementId) {
      case ProfileElementMapper.account:
        // Navigator.pushNamed(context, '/next2');
        // Goto bookmark page
        break;
      case ProfileElementMapper.password:
        break;
      case ProfileElementMapper.noptification:
        break;
      case ProfileElementMapper.wishlist:
        break;
    }
  }

  List<ProfileUtilityModel> _prepareSupportUs() {
    List<ProfileUtilityModel> dataList = [];

    dataList.add(ProfileUtilityModel("Account", AssetStrings.icMan, ProfileElementMapper.account, 0));
    dataList.add(ProfileUtilityModel("Password", AssetStrings.icLock, ProfileElementMapper.password, 0));
    dataList.add(ProfileUtilityModel("Notification", AssetStrings.icNotify, ProfileElementMapper.noptification, 0));
    dataList.add(ProfileUtilityModel("Wishlist", AssetStrings.icLove, ProfileElementMapper.wishlist, 10));
    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    // final  platformBrigthness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SpaceHepler.verticalSpace(kToolbarHeight),
            SizedBox(
                height: 130,
                width: 130,
                child: DottedBorder(
                  color: AppColors.textButton,
                  dashPattern: const [4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(100),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/person.png',
                            ),
                            fit: BoxFit.cover)),
                  ),
                )),
            SpaceHepler.verticalMedium,
            Text('Sauvik Ray', style: AppTextStyles.boldTitle),
            SpaceHepler.verticalSmall,
            Text('info@johnsmith.com', style: AppTextStyles.disableText(color: const Color(0xFF535353))),

            SpaceHepler.verticalMedium,

            prepareProfileRelatedData(_prepareSupportUs())
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/next2');
            //   },
            //   child: const Text('Next Page'),
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text('Next Page 2'),
            // ),
          ],
        ),
      ),
    );
  }
}

enum ProfileElementMapper {
  account,
  password,
  noptification,
  wishlist,
}

class ProfileUtilityModel {
  String title;
  String imageUrl;
  int? wishlist;
  ProfileElementMapper elementId;

  ProfileUtilityModel(this.title, this.imageUrl, this.elementId, this.wishlist);
}
