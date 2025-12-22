import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 1. IMPORTER GOROUTER
import '../../core/theme/app_theme.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    // 2. DÉTECTER SI ON PEUT REVENIR EN ARRIÈRE
    final bool canPop = GoRouter.of(context).canPop();

    return Container(
      // Le padding est conservé
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20), // Simplifié pour les 4 coins
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        // Utilisation d'une Row pour aligner le bouton retour et le contenu
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 3. AFFICHER LE BOUTON RETOUR SI POSSIBLE
          if (canPop)
            Padding(
              // Un peu d'espace entre la flèche et le titre
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                // On utilise une icône blanche pour correspondre à votre design
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () {
                  context.pop(); // L'action pour revenir en arrière
                },
                tooltip: 'Retour',
              ),
            ),

          // Le reste de votre contenu (titre, sous-titre) est maintenant dans un Expanded
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Le titre doit être flexible pour ne pas causer de "pixel overflow"
                    // si le texte est long et qu'il y a le bouton retour
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        // Empêche le texte de déborder
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Le widget 'trailing' est conservé
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
