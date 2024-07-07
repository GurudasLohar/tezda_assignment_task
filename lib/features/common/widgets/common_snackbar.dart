import 'package:flutter/material.dart';
import 'package:tezda_task/utils/color_utils.dart';
import 'package:tezda_task/utils/font_utils.dart';

class CommonSnackBar {
  final String message;
  final Color? bgColor;

  CommonSnackBar({
    required this.message,
    this.bgColor,
  });

  void showSnackBar(context) {
     var snackBar = SnackBar(
      content: Text(message,style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: AppFontSizes.font16,
        color: AppColors.absoluteWhiteColor,
      ),),
      backgroundColor: bgColor ?? AppColors.greenLinearColorDark,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
       margin: const EdgeInsets.all(10),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
