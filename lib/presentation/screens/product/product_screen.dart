import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:svg_flutter/svg.dart';

import '../../../app/config/app_colors.dart';
import 'customTabbar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int currentIndex = 0;
  List<Widget> pages = [Home(index: 0), Home(index: 1), Home(index: 2), AccountPage()];
  @override
  Widget build(BuildContext context) {
        final platformBrigthness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
    //  appBar: AppBar(
    //         elevation: 0,
    //         backgroundColor: AppColors.scaffoldColor,
    //         systemOverlayStyle: SystemUiOverlayStyle(
    //           statusBarBrightness: platformBrigthness == Brightness.dark ? Brightness.dark : Brightness.light,
    //           statusBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
    //           statusBarIconBrightness: platformBrigthness == Brightness.dark ? Brightness.light : Brightness.dark,
    //           systemNavigationBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
    //         ),
    //       ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomCupertinoTabBar(
        shape: const CircularNotchedRectanglePath(),
        height: 60,
        notchMargin: 8,
        currentIndex: currentIndex,
        onTap: (index) {
          log('Current Index $index');
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icon/ic_home.svg', colorFilter: ColorFilter.mode(currentIndex == 0 ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray, BlendMode.srcIn))),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icon/ic_box.svg', colorFilter: ColorFilter.mode(currentIndex == 1 ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray, BlendMode.srcIn))),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icon/ic_cart.svg', colorFilter: ColorFilter.mode(currentIndex == 2 ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray, BlendMode.srcIn))),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icon/ic_man.svg', colorFilter: ColorFilter.mode(currentIndex == 3 ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray, BlendMode.srcIn))),
        ],
      ),
    );
  }
}

class CircularNotchedRectanglePath extends NotchedShape {
  /// Creates a [CircularNotchedRectangle].
  ///
  /// The same object can be used to create multiple shapes.
  const CircularNotchedRectanglePath();

  // final ShapeBorder host;

  /// Creates a [Path] that describes a rectangle with a smooth circular notch.
  ///
  /// `host` is the bounding box for the returned shape. Conceptually this is
  /// the rectangle to which the notch will be applied.
  ///
  /// `guest` is the bounding box of a circle that the notch accommodates. All
  /// points in the circle bounded by `guest` will be outside of the returned
  /// path.
  ///
  /// The notch is curve that smoothly connects the host's top edge and
  /// the guest circle.
  // TODO(amirh): add an example diagram here.
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;
    log('Guest Width:${guest.width}');
    log('Notch Radius:$notchRadius');

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
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
        '/':(context)=>NextPage(),
        '/next2':(context)=>NextPage2(),
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
    return    Scaffold(
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
        body:Center(
          child: Column(children: [
          
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context,'/next2');
            },
            child: Text('Next Page'),
            ),
            
            ElevatedButton(onPressed: () {
              
            },
            child: Text('Next Page 2'),
            ),
          ],),
        ) ,
      );
  }
}class NextPage2 extends StatelessWidget {
  const NextPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final platformBrigthness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
   appBar:     AppBar(
    title: Text('NExt 2 page' ,style: TextStyle(color: Colors.black),),
            elevation: 2,
            backgroundColor: AppColors.scaffoldColor,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: platformBrigthness == Brightness.dark ? Brightness.dark : Brightness.light,
              statusBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
              statusBarIconBrightness: platformBrigthness == Brightness.dark ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: platformBrigthness == Brightness.dark ? Colors.black : AppColors.scaffoldColor,
            ),
          ),
      body: Center(child: Text('Next Page'),),);
  }
}