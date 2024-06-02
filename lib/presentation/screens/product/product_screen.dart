
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';


import '../../../app/config/app_colors.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
appBar: AppBar(
  automaticallyImplyLeading: false,
  elevation: 0,
  backgroundColor: AppColors.scaffoldColor,
  title: Text('ProductScreen',style: AppTextStyles.appBarTitle,),
  centerTitle: true,
  actions: [IconButton(
    splashRadius: 25,
onPressed: (){},
icon: Center(child:  SvgPicture.asset('assets/icon/ic_search.svg',colorFilter: ColorFilter.mode(Colors.black,BlendMode.srcIn),),),

  ),
 const Padding(padding: EdgeInsets.only(right: 20),)
  ],
),
        body: Center(child: Text('Product Screen'),),
       
        
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
