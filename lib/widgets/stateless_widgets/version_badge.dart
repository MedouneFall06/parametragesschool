import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class VersionBadge extends StatelessWidget {
  final String version;
  
  const VersionBadge({
    super.key,
    this.version = '1.0.0',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
        vertical: AppConstants.heightPercentage(context, AppConstants.spacingTiny),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(AppConstants.veryLowOpacity),
        borderRadius: BorderRadius.circular(AppConstants.extraBorderRadius),
        border: Border.all(color: Colors.white.withOpacity(AppConstants.lowOpacity)),
      ),
      child: Text(
        'Version $version',
        style: TextStyle(
          color: Colors.white,
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.smallFontSize),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
