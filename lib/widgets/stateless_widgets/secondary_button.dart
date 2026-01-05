import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constant/constants.dart';


class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final IconData? icon;
  final double? iconSize;
  final double? fontSize;
  
  const SecondaryButton({
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
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: iconSize) : const SizedBox.shrink(),
        label: Text(text, style: TextStyle(fontSize: fontSize)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
          side: const BorderSide(color: AppTheme.primaryColor),
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
