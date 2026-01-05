import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;
  
  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
        title: Text(
          widget.question,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
        childrenPadding: EdgeInsets.fromLTRB(
          AppConstants.widthPercentage(context, AppConstants.spacingSmall),
          0,
          AppConstants.widthPercentage(context, AppConstants.spacingSmall),
          AppConstants.heightPercentage(context, AppConstants.spacingSmall),
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Text(
            widget.answer,
            style: TextStyle(
              color: AppTheme.textSecondary,
              height: AppConstants.textHeight,
            ),
          ),
        ],
      ),
    );
  }
}
