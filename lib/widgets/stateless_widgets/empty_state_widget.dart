import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'primary_button.dart';
import '../../core/constant/constants.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  
  const EmptyStateWidget({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox,
    this.buttonText,
    this.onButtonPressed,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppConstants.widthPercentage(context, AppConstants.avatarSize * 2),
              color: AppTheme.textSecondary.withOpacity(AppConstants.veryLowOpacity),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.paddingBetweenStats)),
            Text(
              title,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.statTitleFontSize),
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                color: AppTheme.textSecondary,
              ),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              SizedBox(height: AppConstants.heightPercentage(context, AppConstants.paddingBetweenStats)),
              PrimaryButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                fullWidth: false,
                iconSize: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
