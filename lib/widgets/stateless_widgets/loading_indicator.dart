import 'package:flutter/material.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double size;
  final String? text;
  
  const LoadingIndicator({
    super.key,
    this.color,
    this.size = 40,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppConstants.widthPercentage(context, AppConstants.iconSize),
          height: AppConstants.widthPercentage(context, AppConstants.iconSize),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Colors.white,
            ),
            strokeWidth: AppConstants.borderWidth,
          ),
        ),
        if (text != null) ...[
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
