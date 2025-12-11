import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';

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
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.school,
          size: size * 0.6,
          color: AppTheme.primaryColor,
        ),
      ),
    );
  }
}