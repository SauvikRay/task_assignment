import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:task_assignment/app/config/app_colors.dart';
import 'package:task_assignment/app/config/app_text_styles.dart';

// ignore: must_be_immutable
class BaseEditText extends StatefulWidget {
  TextEditingController textController;
  String? placeHolder;
  TextInputType inputType;
  bool isObsecure;
  final VoidCallback? onTap;
  bool readeOnly;
  String? prefixIcon;
  Widget? suffixWidget;
  final Color? placeHolderColor;

  BaseEditText(
      {super.key,
      required this.textController,
      // ignore: avoid_init_to_null
      this.placeHolder = null,
      this.inputType = TextInputType.text,
      this.isObsecure = false,
      this.onTap,
      this.readeOnly = false,
      this.prefixIcon,
      this.suffixWidget,
      this.placeHolderColor,
      
      });

  @override
  State<BaseEditText> createState() => _BaseEditTextState();
}

class _BaseEditTextState extends State<BaseEditText> {
  @override
  Widget build(BuildContext context) {
    Brightness systemBrigthness = MediaQuery.of(context).platformBrightness;
    return SizedBox(
      height: 60.00,
      child: Material(
        shadowColor: const Color(0xff395AB8).withOpacity(0.5),
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10),
        )),
        child: CupertinoTextField(
          onTap: widget.onTap,
          controller: widget.textController,
          readOnly: widget.readeOnly,
          prefix: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SvgPicture.asset(
                    widget.prefixIcon!,
                    height: 18,
                    width: 18,
                  ),
                )
              : null,
          suffix: widget.suffixWidget,
          decoration: const BoxDecoration(
            // border: Border.all(color: color979797),
            color: Colors.white,
            // boxShadow: [BoxShadow(color: AppColors.shadowColor, blurRadius: 3, spreadRadius: 0, offset: Offset(0, 3))],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          placeholder: widget.placeHolder,
          style: AppTextStyles.placeHolderText(color:widget.placeHolderColor?? Colors.black),
          keyboardType: widget.inputType,
          obscureText: widget.isObsecure,
        ),
      ),
    );
  }
}
