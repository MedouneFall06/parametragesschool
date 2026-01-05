import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        child: Column(
          children: [
            Icon(
              Icons.support_agent,
              size: AppConstants.widthPercentage(context, AppConstants.avatarSize),
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.paddingVertical)),
            Text(
              'Nous sommes là pour vous aider',
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              'Notre équipe support est disponible du lundi au vendredi, de 9h à 18h.',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                height: AppConstants.textHeight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
