import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class BackToLoginLink extends StatelessWidget {
  final VoidCallback? onPressed;
  
  const BackToLoginLink({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed ?? () {
          context.pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
              color: AppTheme.textSecondary,
            ),
            SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
            Text(
              'Retour à la connexion',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
