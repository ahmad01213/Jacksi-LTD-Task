import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/texts.dart';

class TitleFieldWidget extends StatelessWidget {
  final String title;
  const TitleFieldWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Texts(
            title: title,
            textColor: Colors.black,
            fontSize: 16,
            fontFamily: AppFonts.moM),
      ],
    );
  }
}
