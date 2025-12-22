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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
                      const SizedBox(width: 48), // Espace pour alignement

                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
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
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 14,
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