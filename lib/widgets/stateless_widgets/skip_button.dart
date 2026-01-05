import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

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
        context.goNamed('login');
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
          vertical: AppConstants.heightPercentage(context, AppConstants.spacingTiny),
        ),
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
