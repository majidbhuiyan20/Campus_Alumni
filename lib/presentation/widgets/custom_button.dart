import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constansts/app_colors.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonText,
    required this.onTap,
    this.buttonBackground,
    this.textColor,
    this.borderWidth,
    this.borderColor,
    super.key,
  });
  final String buttonText;
  final VoidCallback onTap;
  final Color? buttonBackground;
  final Color? textColor;
  final double? borderWidth;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.w),
      decoration: BoxDecoration(
        color: buttonBackground ?? AppColors.btnBackgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: textColor ?? AppColors.whiteTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}