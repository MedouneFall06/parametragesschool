import 'package:flutter/material.dart';
// ignore: unused_import
import '../../core/theme/app_theme.dart';

class InfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  
  const InfoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding is EdgeInsets
            ? EdgeInsets.all(MediaQuery.of(context).size.width * 0.02)
            : padding,
        child: child,
      ),
    );
  }
}
