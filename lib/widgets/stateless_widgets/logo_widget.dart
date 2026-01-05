import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final Color? color;
  
  const LogoWidget({
    super.key,
    this.size = 80,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
      height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(AppConstants.veryLowOpacity),
            blurRadius: AppConstants.lightShadowBlur,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.school,
          size: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.6),
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}
