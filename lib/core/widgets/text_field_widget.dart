import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_app/core/layout/palette.dart';

import '../layout/app_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;

  final TextEditingController controller;
  final TextInputType type;

  final int maxLength;


  const TextFieldWidget(
      {super.key,
      required this.hint,
   
      required this.controller,
      required this.type,
    
      
       this.maxLength=0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xfffefefe),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Palette.borderColor),
       
      ),
      child: TextField(
      
        controller: controller,
        keyboardType: type,
        maxLength: maxLength == 0 ? null : maxLength,
        
        style: const TextStyle(
            fontFamily: AppFonts.moM, fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
       
          hintText: hint,
          counterText: "",
          border: InputBorder.none,
          hintStyle: const TextStyle(
              fontFamily: AppFonts.moL, fontSize: 14, ),
        ),
      ),
    );
  }
}
