import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';

class AcceptCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  
  const AcceptCheckbox({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppTheme.primaryColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'J\'ai lu et j\'accepte les conditions d\'utilisation',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'En cochant cette case, vous acceptez toutes les conditions mentionnées ci-dessus.',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}