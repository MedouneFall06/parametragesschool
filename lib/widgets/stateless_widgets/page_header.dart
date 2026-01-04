import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

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
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
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
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, 
                  color: Colors.white, 
                  size: MediaQuery.of(context).size.width * 0.025),
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
                      SizedBox(width: MediaQuery.of(context).size.width * 0.06), // Espace pour alignement

                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: max(18,MediaQuery.of(context).size.width * 0.035),
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
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.004),
                    child: Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: max(10, MediaQuery.of(context).size.width * 0.016),
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
