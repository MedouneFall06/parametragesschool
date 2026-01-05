import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constant/constants.dart';

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
            ? EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll))
            : padding,
        child: child,
      ),
    );
  }
}
