import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class SuccessMessageCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color color;
  
  const SuccessMessageCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.check_circle,
    this.color = AppTheme.successColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
      decoration: BoxDecoration(
        color: color.withOpacity(AppConstants.veryLowOpacity),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: color.withOpacity(AppConstants.lowOpacity)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: AppConstants.widthPercentage(context, AppConstants.avatarSize),
            color: color,
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.paddingBetweenCards)),
          Text(
            title,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.hugeFontSize),
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            message,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              height: AppConstants.textHeight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
