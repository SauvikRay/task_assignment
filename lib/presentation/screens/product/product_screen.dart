// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_space.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';
import 'package:task_assignment/app/config/asset_strings.dart';
import 'package:task_assignment/presentation/widgets/base_action_button.dart';

import '../../../app/config/app_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<String> filterText = ['Newest', 'Oldest', 'Price low > High', 'Price high > Low', 'Best selling'];
  String? selectedRadio;
  List<String> selectString = [];

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Durations.long3, animationBehavior: AnimationBehavior.normal, reverseDuration: Durations.long3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.scaffoldColor,
        title: Text(
          'ProductScreen',
          style: AppTextStyles.appBarTitle(color: AppColors.appbarTitleColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 25,
            onPressed: () {},
            icon: Center(
              child: SvgPicture.asset(
                'assets/icon/ic_search.svg',
                colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              shadowColor: const Color(0xff395AB8).withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: IconButton(
                          splashRadius: 40.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            log('Filter pressed');
                            _bottomFilterSheet(context);
                          },
                          icon: Row(
                            children: [
                              SvgPicture.asset(
                                AssetStrings.icfilter,
                                fit: BoxFit.cover,
                                height: 16,
                                width: 15,
                              ),
                              SpaceHepler.horizontalSmall,
                              Text(
                                'Filter',
                                style: AppTextStyles.disableText(color: null),
                              )
                            ],
                          )),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 75,
                      child: IconButton(
                          splashRadius: 40.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            log('Filter pressed');
                          },
                          icon: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sort by',
                                style: AppTextStyles.disableText(color: null),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.disableTextColor,
                                size: 25,
                              )
                            ],
                          )),
                    ),
                    SpaceHepler.horizontalSmall,
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AssetStrings.icDrawer),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Product Screen'),
      ),
    );
  }

  Future<dynamic> _bottomFilterSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        transitionAnimationController: animationController,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return ConstrainedBox(
              constraints:const BoxConstraints(maxHeight: 450),
              child: Padding(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SpaceHepler.verticalMedium,
                        Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(color: const Color(0xFFFFD3DD), borderRadius: BorderRadius.circular(50)),
                        ),
                        SpaceHepler.verticalMedium,
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: filterText.length,
                          itemBuilder: (context, index) {
                            return Theme(
                              data: ThemeData(checkboxTheme: const CheckboxThemeData(side: BorderSide(color: Colors.red, width: 2))),
                              child: CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                activeColor: AppColors.checkBoxActive,
                                checkboxShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)), side: BorderSide(color: AppColors.checkBoxActive, width: 1.5)),
                                contentPadding: EdgeInsets.zero,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                title: Text(
                                  filterText[index],
                                  style: AppTextStyles.disableText(color: Colors.black),
                                ),
                                value: selectString.contains(filterText[index]),
                                onChanged: (value) {
                                  if (selectString.contains(filterText[index])) {
                                    selectString.remove(filterText[index]); // unselect
                                  } else {
                                    selectString.add(filterText[index]); // select
                                  }
                                  setState(
                                    () {}
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SpaceHepler.verticalSpace(2);
                          },
                        ),
                        SpaceHepler.verticalMedium,

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: (){
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    
                                     backgroundColor: Colors.transparent, elevation: 0, shape: const RoundedRectangleBorder(side: BorderSide(color: Color(0xFFD2DBE0),width: 0.65),borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: 140,
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Cancle',style:TextStyle(color: Color(0xFF818995),fontSize:17 ),)
                                  ),
                                ),
                                Spacer(),
                                   ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    
                                     backgroundColor:Color(0xFF81ABC9C), elevation: 0, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 60,
                                    width: 140,
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('Appply',style:TextStyle(color: Colors.white,fontSize: 17),)
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            );
          });
        }).then(
      (value) {
        // selectString.clear();
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HomePage '),
      ),
    );
  }
}

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      routes: {
        '/': (context) => NextPage(),
        '/next2': (context) => NextPage2(),
      },
      builder: (context) => NextPage(),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final platformBrigthness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
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
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/next2');
              },
              child: Text('Next Page'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Next Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage2 extends StatelessWidget {
  const NextPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final platformBrigthness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NExt 2 page',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
        backgroundColor: AppColors.scaffoldColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: platformBrigthness == Brightness.dark ? Brightness.dark : Brightness.light,
          statusBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
          statusBarIconBrightness: platformBrigthness == Brightness.dark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
        ),
      ),
      body: Center(
        child: Text('Next Page'),
      ),
    );
  }
}
