import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class OnboardingSlide extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  
  const OnboardingSlide({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 2),
            height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 2),
            decoration: BoxDecoration(
              color: color.withOpacity(AppConstants.veryLowOpacity),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: AppConstants.widthPercentage(context, AppConstants.iconSize * 2),
                color: color,
              ),
            ),
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.paddingBetweenStats)),
          Text(
            title,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            description,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
              color: AppTheme.textSecondary,
              height: AppConstants.textHeight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
