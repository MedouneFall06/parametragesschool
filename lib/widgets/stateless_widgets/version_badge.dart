import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:parametragesschool/core/theme/app_theme.dart';

class VersionBadge extends StatelessWidget {
  final String version;
  
  const VersionBadge({
    super.key,
    this.version = '1.0.0',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        'Version $version',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}