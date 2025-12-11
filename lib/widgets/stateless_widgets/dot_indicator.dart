import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';

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
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? activeColor : inactiveColor,
          ),
        );
      }),
    );
  }
}