import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constant/constants.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  
  const StatusBadge({
    super.key,
    required this.text,
    this.color = AppTheme.successColor,
    this.textColor = Colors.white,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
        vertical: AppConstants.heightPercentage(context, AppConstants.spacingTiny),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.extraBorderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.smallFontSize),
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
