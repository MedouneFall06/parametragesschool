import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';

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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
          ),
        ),
        if (withDivider) ...[
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 60,
            color: AppTheme.accentColor,
          ),
        ],
      ],
    );
  }
}