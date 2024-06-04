import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_assignment/app/config/app_space.dart';

import '../../../app/config/app_colors.dart';

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

            SpaceHepler.verticalMedium,
            SizedBox(height: 130,width: 130,
            child:DottedBorder(
              color: AppColors.textButton,
              dashPattern:const [4],

              borderType: BorderType.RRect,

              radius: Radius.circular(100),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.red),),)
            ),
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
