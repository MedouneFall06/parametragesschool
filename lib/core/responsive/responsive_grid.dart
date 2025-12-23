import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    // Déterminer le nombre de colonnes selon la largeur
    int crossAxisCount;
    if (width < 400) {
      crossAxisCount = 1; // Très petit mobile
    } else if (width < 600) {
      crossAxisCount = 2; // Mobile standard
    } else if (width < 900) {
      crossAxisCount = 3; // Tablet
    } else if (width < 1200) {
      crossAxisCount = 4; // Desktop moyen
    } else {
      crossAxisCount = 5; // Grand écran/Desktop large
    }

    // Ajuster le ratio selon le nombre de colonnes
    double childAspectRatio;
    switch (crossAxisCount) {
      case 1:
        childAspectRatio = 3.0; // Très long pour 1 colonne
      case 2:
        childAspectRatio = 1.8; // Long
      case 3:
        childAspectRatio = 1.2; // Moyen
      case 4:
        childAspectRatio = 1.0; // Carré
      case 5:
        childAspectRatio = 0.8; // Court
      default:
        childAspectRatio = 1.0;
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: spacing,
      mainAxisSpacing: spacing,
      childAspectRatio: childAspectRatio,
      children: children,
    );
  }
}