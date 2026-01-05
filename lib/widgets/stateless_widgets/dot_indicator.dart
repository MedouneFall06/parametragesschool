import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemCount;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final double spacing;
  
  const DotIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    this.activeColor = AppTheme.primaryColor,
    this.inactiveColor = Colors.grey,
    this.size = 10,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall) / 2),
          width: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
          height: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}
