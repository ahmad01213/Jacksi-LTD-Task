import 'package:flutter/material.dart';
import 'package:task_app/core/layout/palette.dart';





class CustomIconButton extends StatelessWidget {
  final Color backgroundColor;
  final double height, width;
  final void Function() onPressed;
  final Widget icon;
  const CustomIconButton({
    super.key,
    required this.backgroundColor,
    required this.height,
    required this.width,
    required this.onPressed, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
           shape: MaterialStateProperty.resolveWith((states) {
            if (!states.contains(MaterialState.pressed)) {
              return  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(width: 1, color: Palette.borderColor),
            );
            }
            return  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            );
          }),
         
        ),
        child: icon,
      ),
    );
  }
}
