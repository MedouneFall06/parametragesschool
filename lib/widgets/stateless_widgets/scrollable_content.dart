import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:parametragesschool/core/theme/app_theme.dart';

class ScrollableContent extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  
  const ScrollableContent({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: child,
    );
  }
}