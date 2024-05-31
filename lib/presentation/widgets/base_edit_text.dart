import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
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

  BaseEditText({
    super.key,
    required this.textController,
    // ignore: avoid_init_to_null
    this.placeHolder = null,
    this.inputType = TextInputType.text,
    this.isObsecure = false,
    this.onTap,
    this.readeOnly = false,
    this.prefixIcon,
    this.suffixWidget
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
      child: CupertinoTextField(
        onTap: widget.onTap,
        controller: widget.textController,
        readOnly: widget.readeOnly,
        prefix:widget.prefixIcon !=null? Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset(widget.prefixIcon!),
        ):null,
        suffix: widget.suffixWidget,
        decoration: BoxDecoration(
          // border: Border.all(color: color979797),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3),blurRadius:3,spreadRadius: 0,offset:const Offset(0,3))],
          borderRadius:const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        placeholder: widget.placeHolder,
        style: AppTextStyles.placeHolderText,
        keyboardType: widget.inputType,
        obscureText: widget.isObsecure,
        
      ),
    );
  }
}
