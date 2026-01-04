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
              size: 60,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Nous sommes là pour vous aider',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Notre équipe support est disponible du lundi au vendredi, de 9h à 18h.',
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
