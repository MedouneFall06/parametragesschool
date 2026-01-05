import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constant/constants.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.showBackButton = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Vérifier si on peut revenir en arrière
    final bool canPop = GoRouter.of(context).canPop();
    final bool shouldShowBackButton = showBackButton && canPop;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.widthPercentage(context, AppConstants.paddingHorizontal),
        vertical: AppConstants.heightPercentage(context, AppConstants.paddingVertical),
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: AppConstants.lightShadowBlur,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bouton Retour - AFFICHER TOUJOURS (sauf si explicitement désactivé)
          if (shouldShowBackButton)
            Padding(
              padding: EdgeInsets.only(right: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, 
                  color: Colors.white, 
                  size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                onPressed: onBackPressed ?? () => context.pop(),
                tooltip: 'Retour',
              ),
            ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Si pas de bouton retour mais qu'on veut l'espacement
                    if (!shouldShowBackButton)
                      SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingExtraLarge)), // Espace pour alignement

                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: max(AppConstants.hugeFontSize, AppConstants.responsiveFontSize(context, AppConstants.titleFontSize)),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    if (trailing != null) trailing!,
                  ],
                ),
                
                    if (subtitle != null)
                      Padding(
                        padding: EdgeInsets.only(top: AppConstants.heightPercentage(context, AppConstants.spacingTiny)),
                        child: Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: max(AppConstants.smallFontSize, AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize)),
                            color: Colors.white70,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
