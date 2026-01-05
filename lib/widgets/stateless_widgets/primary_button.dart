import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constant/constants.dart';


class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.fullWidth = false,
    this.icon,
    this.iconSize,
    this.fontSize,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: iconSize) : const SizedBox.shrink(),
        label: Text(text, style: TextStyle(fontSize: fontSize)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.widthPercentage(context, AppConstants.paddingHorizontal),
            vertical: AppConstants.heightPercentage(context, AppConstants.paddingVertical),
          ),
        ),
      ),
    );
  }
}
