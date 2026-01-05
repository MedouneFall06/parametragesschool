import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool withDivider;
  
  const SectionTitle({
    super.key,
    required this.title,
    this.withDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
          ),
        ),
        if (withDivider) ...[
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Container(
            height: AppConstants.borderWidth,
            width: AppConstants.widthPercentage(context, AppConstants.spacingExtraLarge),
            color: AppTheme.accentColor,
          ),
        ],
      ],
    );
  }
}
