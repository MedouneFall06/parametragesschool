import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'primary_button.dart';

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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: MediaQuery.of(context).size.width * 0.15,
              color: AppTheme.textSecondary.withOpacity(0.5),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.025,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.02,
                color: AppTheme.textSecondary,
              ),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              PrimaryButton(
                text: buttonText!,
                onPressed: onButtonPressed!,
                fullWidth: false,
                iconSize: MediaQuery.of(context).size.width * 0.025,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
