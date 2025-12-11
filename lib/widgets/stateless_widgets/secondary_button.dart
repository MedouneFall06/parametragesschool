import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';


class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;
  final IconData? icon;
  
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = false,
    this.icon,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
          side: const BorderSide(color: AppTheme.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}