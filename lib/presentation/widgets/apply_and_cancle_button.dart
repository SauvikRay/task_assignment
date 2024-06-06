import 'package:flutter/material.dart';

class ApplyAndCancleButton extends StatelessWidget {
  const ApplyAndCancleButton({
    super.key,
    required this.onCancle,
    required this.onApply,
    this.buttonWidth = 120,
  });
  final void Function()? onCancle;
  final void Function()? onApply;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onCancle,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFD2DBE0), width: 0.65), borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          child: Container(
              alignment: Alignment.center,
              height: 60,
              width: buttonWidth,
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                'Cancle',
                style: TextStyle(color: Color(0xFF818995), fontSize: 17),
              )),
        ),
        Spacer(),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF81ABC9C),
              elevation: 0,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          child: Container(
              alignment: Alignment.center,
              height: 60,
              width: buttonWidth,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Appply',
                style: TextStyle(color: Colors.white, fontSize: 17),
              )),
        ),
      ],
    );
  }
}
