import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback? onPressed;
  
  const SkipButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {
        Navigator.pushReplacementNamed(context, '/login');
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        'Passer',
        style: TextStyle(
          color: AppTheme.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}