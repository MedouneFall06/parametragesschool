import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';

class AppNameWidget extends StatelessWidget {
  final Color? color;
  final double fontSize;
  
  const AppNameWidget({
    super.key,
    this.color,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Paramétrages',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: color ?? Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          TextSpan(
            text: 'School',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
              color: color ?? AppTheme.accentColor,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}