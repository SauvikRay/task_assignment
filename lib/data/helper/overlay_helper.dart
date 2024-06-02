import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:task_assignment/app/config/app_colors.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';

RxBool isDialogOpened = false.obs;
OverlayEntry insertOverlay(BuildContext context, String message) {
  RenderBox renderBox = context.findRenderObject() as RenderBox;
  final size = renderBox.size;
  log('Size: $size'); //MediaQuery.of(context).size;
  return OverlayEntry(builder: (context) {
    return OverlayBanner(
      message: message,
    );
  });
}

class OverlayBanner extends StatefulWidget {
  const OverlayBanner({super.key, required this.message});
  final String message;

  @override
  State<OverlayBanner> createState() => _OverlayBannerState();
}

class _OverlayBannerState extends State<OverlayBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const Curve curve = Curves.easeOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _playAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        final double animationValue = curve.transform(_controller.value);
        return FractionalTranslation(
          translation: Offset(0, -(1 - animationValue)),
          child: child,
        );
      },
      animation: _controller,
      child: SingleChildScrollView(
        child: Material(
          color: AppColors.overlayBAckground ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              SvgPicture.asset('assets/icon/caution_red.svg', height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 180, maxWidth: MediaQuery.of(context).size.width),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.message, maxLines: 2, style: AppTextStyles.warningText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() async {
    // fist will show banner with forward.
    await _controller.forward();
    // wait for 3 second and then play reverse animation to hide the banner
    // Duration can be passed as parameter, banner will wait this much and then will dismiss
    await Future<void>.delayed(const Duration(seconds: 3));
    await _controller.reverse(from: 1);
    // call onDismissedCallback so OverlayWidget can remove and clear the OverlayEntry.
  }
}