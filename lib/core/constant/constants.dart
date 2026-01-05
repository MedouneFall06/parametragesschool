import 'package:flutter/material.dart';

/// Constantes globales pour le responsive design
/// Toutes les tailles sont exprimées en pourcentage de la largeur/hauteur de l'écran
/// pour garantir un affichage optimal sur tous les appareils

class AppConstants {
  // ==================== PADDING GÉNÉRAL ====================
  /// Padding extérieur principal
  static const double paddingAll = 0.02;
  
  /// Padding horizontal
  static const double paddingHorizontal = 0.02;
  
  /// Padding vertical
  static const double paddingVertical = 0.013;
  
  /// Espacement entre les éléments principaux
  static const double paddingBetweenItems = 0.02;
  
  /// Espacement entre les cartes de statistiques
  static const double paddingBetweenStats = 0.02;
  
  /// Espacement entre les cartes d'information
  static const double paddingBetweenCards = 0.01;

  // ==================== TAILLES DE POLICES ====================
  /// Titre principal des sections
  static const double titleFontSize = 0.025;
  
  /// Titre des cartes de statistiques
  static const double statTitleFontSize = 0.025;
  
  /// Valeur des statistiques
  static const double statValueFontSize = 0.045;
  
  /// Sous-titre des cartes
  static const double subtitleFontSize = 0.018;
  
  /// Texte d'information
  static const double infoFontSize = 0.016;
  
  /// Texte d'aide dans les filtres
  static const double hintFontSize = 0.018;
  
  /// Texte des boutons
  static const double buttonTextFontSize = 0.020;
  
  /// Texte des labels
  static const double labelFontSize = 0.025;
  
  // ==================== TAILLES DE POLICES FIXES ====================
  /// Petite taille de police
  static const double smallFontSize = 12.0;
  
  /// Taille de police standard
  static const double mediumFontSize = 14.0;
  
  /// Taille de police légèrement grande
  static const double largeFontSize = 16.0;
  
  /// Grande taille de police
  static const double extraLargeFontSize = 18.0;
  
  /// Très grande taille de police
  static const double hugeFontSize = 20.0;
  
  /// Taille de police pour titres
  static const double titleFontSizeFixed = 24.0;
  
  /// Taille de police pour gros titres
  static const double bigTitleFontSize = 25.0;
  
  /// Taille de police pour très gros titres
  static const double hugeTitleFontSize = 30.0;
  
  /// Taille de police pour énormes titres
  static const double massiveTitleFontSize = 35.0;
  
  /// Taille de police pour valeurs statistiques
  static const double statValueFontSizeFixed = 45.0;

  // ==================== ICONES ====================
  /// Taille des icônes principales
  static const double iconSize = 0.04;
  
  /// Taille des icônes secondaires
  static const double smallIconSize = 0.025;
  
  /// Taille des avatars
  static const double avatarSize = 0.08;
  
  // ==================== TAILLES D'ICÔNES FIXES ====================
  /// Petite taille d'icône (12px)
  static const double smallIconSizeFixed = 12.0;
  
  /// Taille d'icône standard (16px)
  static const double mediumIconSize = 16.0;
  
  /// Grande taille d'icône (20px)
  static const double largeIconSize = 20.0;
  
  /// Très grande taille d'icône (24px)
  static const double extraLargeIconSize = 24.0;
  
  /// Icône pour boutons (25px)
  static const double buttonIconSize = 25.0;
  
  /// Icône pour liste (18px)
  static const double listItemIconSize = 18.0;
  
  /// Icône pour badges (10px)
  static const double badgeIconSize = 10.0;
  
  /// Icône pour notifications (14px)
  static const double notificationIconSize = 14.0;

  // ==================== ESPACEMENTS ====================
  /// Espacement très petit
  static const double spacingTiny = 0.002;
  
  /// Espacement petit
  static const double spacingSmall = 0.003;
  
  /// Espacement moyen
  static const double spacingMedium = 0.006;
  
  /// Espacement grand
  static const double spacingLarge = 0.01;
  
  /// Espacement très grand
  static const double spacingExtraLarge = 0.015;
  
  // ==================== ESPACEMENTS FIXES ====================
  /// Espacement fixe très petit (4px)
  static const double fixedSpacingTiny = 4.0;
  
  /// Espacement fixe petit (8px)
  static const double fixedSpacingSmall = 8.0;
  
  /// Espacement fixe moyen (12px)
  static const double fixedSpacingMedium = 12.0;
  
  /// Espacement fixe grand (16px)
  static const double fixedSpacingLarge = 16.0;
  
  /// Espacement fixe très grand (24px)
  static const double fixedSpacingExtraLarge = 24.0;
  
  /// Espacement fixe énorme (32px)
  static const double fixedSpacingHuge = 32.0;
  
  /// Espacement fixe très énorme (48px)
  static const double fixedSpacingMassive = 48.0;

  // ==================== DIMENSIONS DES CARTES ====================
  /// Padding intérieur des cartes
  static const double cardPadding = 0.02;
  
  /// Hauteur minimale des cartes
  static const double minCardHeight = 0.15;
  
  /// Largeur minimale des cartes
  static const double minCardWidth = 0.4;

  // ==================== DIMENSIONS DES BOUTONS ====================
  /// Hauteur des boutons primaires
  static const double buttonHeight = 0.05;
  
  /// Largeur minimale des boutons
  static const double minButtonWidth = 0.3;
  
  /// Rayon des coins des boutons
  static const double buttonBorderRadius = 12.0;

  // ==================== DIMENSIONS DES CHAMPS DE FORMULAIRE ====================
  /// Hauteur des champs de texte
  static const double textFieldHeight = 0.06;
  
  /// Rayon des coins des champs de texte
  static const double textFieldBorderRadius = 8.0;

  // ==================== DIMENSIONS DES LISTES ====================
  /// Hauteur des éléments de liste
  static const double listItemHeight = 0.12;
  
  /// Espacement entre les éléments de liste
  static const double listSpacing = 0.01;

  // ==================== DIMENSIONS DES TABLEAUX ====================
  /// Hauteur des en-têtes de tableau
  static const double tableHeaderHeight = 0.06;
  
  /// Hauteur des lignes de tableau
  static const double tableRowHeight = 0.08;

  // ==================== ANIMATIONS ====================
  /// Durée des animations standard
  static const Duration animationDuration = Duration(milliseconds: 250);
  
  /// Courbe d'animation standard
  static const Curve animationCurve = Curves.easeInOut;

  // ==================== COULEURS ====================
  /// Opacité des arrière-plans semi-transparents
  static const double semiTransparentOpacity = 0.1;
  
  /// Opacité des éléments désactivés
  static const double disabledOpacity = 0.5;
  
  /// Opacité très faible
  static const double veryLowOpacity = 0.15;
  
  /// Opacité faible
  static const double lowOpacity = 0.2;
  
  /// Opacité moyenne
  static const double mediumOpacity = 0.3;
  
  /// Opacité élevée
  static const double highOpacity = 0.7;
  
  /// Opacité très élevée
  static const double veryHighOpacity = 0.8;
  
  /// Opacité maximale
  static const double maxOpacity = 0.9;
  
  // ==================== TAILLES FIXES ====================
  /// Hauteur fixe petite (24px)
  static const double fixedHeightSmall = 24.0;
  
  /// Hauteur fixe grande (32px)
  static const double fixedHeightLarge = 32.0;
  
  /// Hauteur fixe énorme (48px)
  static const double fixedHeightHuge = 48.0;
  
  /// Hauteur fixe pour texte (1.5)
  static const double textHeight = 1.5;

  // ==================== SHADOWS ====================
  /// Flou des ombres légères
  static const double lightShadowBlur = 4.0;
  
  /// Flou des ombres moyennes
  static const double mediumShadowBlur = 8.0;
  
  /// Flou des ombres fortes
  static const double heavyShadowBlur = 16.0;

  // ==================== BORDURES ====================
  /// Épaisseur des bordures principales
  static const double borderWidth = 1.0;
  
  /// Rayon des coins arrondis
  static const double borderRadius = 8.0;
  
  /// Rayon des coins très arrondis
  static const double extraBorderRadius = 12.0;
  
  /// Rayon des coins petits
  static const double smallBorderRadius = 4.0;
  
  /// Rayon des coins très petits
  static const double tinyBorderRadius = 5.0;
  
  /// Rayon des coins très grands
  static const double largeBorderRadius = 20.0;
  
  // ==================== CONSTANTES NUMÉRIQUES SPÉCIFIQUES ====================
  /// Constante pour les notes maximales
  static const double maxNote = 20.0;
  
  /// Constante pour les notes excellentes
  static const double excellentNote = 16.0;
  
  /// Constante pour les notes bonnes
  static const double goodNote = 14.0;
  
  /// Constante pour les notes moyennes
  static const double averageNote = 10.0;
  
  /// Constante pour les années scolaires
  static const int schoolYearStart = 2023;
  static const int schoolYearEnd = 2024;
  
  /// Constante pour les durées
  static const int defaultDurationDays = 30;
  
  /// Constante pour les tailles fixes
  static const double fixedSize12 = 12.0;
  static const double fixedSize14 = 14.0;
  static const double fixedSize16 = 16.0;
  static const double fixedSize18 = 18.0;
  static const double fixedSize20 = 20.0;
  static const double fixedSize24 = 24.0;
  static const double fixedSize32 = 32.0;
  static const double fixedSize40 = 40.0;
  static const double fixedSize48 = 48.0;
  static const double fixedSize50 = 50.0;
  static const double fixedSize60 = 60.0;
  static const double fixedSize72 = 72.0;
  static const double fixedSize80 = 80.0;
  static const double fixedSize100 = 100.0;
  static const double fixedSize120 = 120.0;
  static const double fixedSize144 = 144.0;
  static const double fixedSize160 = 160.0;
  static const double fixedSize180 = 180.0;
  static const double fixedSize200 = 200.0;
  static const double fixedSize240 = 240.0;
  static const double fixedSize280 = 280.0;
  static const double fixedSize320 = 320.0;
  static const double fixedSize360 = 360.0;
  static const double fixedSize400 = 400.0;
  static const double fixedSize480 = 480.0;
  static const double fixedSize560 = 560.0;
  static const double fixedSize640 = 640.0;
  static const double fixedSize720 = 720.0;
  static const double fixedSize800 = 800.0;
  static const double fixedSize960 = 960.0;
  static const double fixedSize1080 = 1080.0;
  static const double fixedSize1200 = 1200.0;
  static const double fixedSize1440 = 1440.0;
  static const double fixedSize1920 = 1920.0;

  // ==================== UTILITAIRES ====================
  /// Nombre minimum de colonnes pour le grid
  static const int minGridColumns = 1;
  
  /// Nombre maximum de colonnes pour le grid
  static const int maxGridColumns = 4;
  
  /// Ratio d'aspect par défaut pour les cartes
  static const double defaultAspectRatio = 1.5;
  
  /// Ratio d'aspect pour les cartes carrées
  static const double squareAspectRatio = 1.0;
  
  /// Ratio d'aspect pour les cartes rectangulaires
  static const double rectangularAspectRatio = 2.0;

  // ==================== FONCTIONS UTILITAIRES ====================
  
  /// Convertit un pourcentage de largeur en pixels
  static double widthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }
  
  /// Convertit un pourcentage de hauteur en pixels
  static double heightPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
  
  /// Retourne une taille minimale ou maximale selon l'écran
  static double responsiveSize(BuildContext context, double minSize, double maxSize) {
    final width = MediaQuery.of(context).size.width;
    final calculatedSize = width * 0.04; // 4% de la largeur
    return calculatedSize.clamp(minSize, maxSize);
  }
  
  /// Retourne une police adaptée à la taille de l'écran
  static double responsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    final calculatedSize = width * baseSize;
    return calculatedSize.clamp(12.0, 24.0); // Entre 12 et 24 points
  }
  
  /// Retourne un espacement adapté à la taille de l'écran
  static double responsiveSpacing(BuildContext context, double baseSpacing) {
    return MediaQuery.of(context).size.width * baseSpacing;
  }
  
  /// Retourne une largeur de colonne adaptée pour le grid
  static double gridItemWidth(BuildContext context, int crossAxisCount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = widthPercentage(context, paddingAll) * 2;
    final spacing = widthPercentage(context, paddingBetweenItems) * (crossAxisCount - 1);
    return (screenWidth - padding - spacing) / crossAxisCount;
  }
  
  /// Retourne un ratio d'aspect adapté à la taille de l'écran
  static double responsiveAspectRatio(BuildContext context, double baseRatio) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
    // Ajuste le ratio selon l'orientation
    if (width > height) {
      // Mode paysage - ratio plus large
      return baseRatio * 1.2;
    } else {
      // Mode portrait - ratio plus carré
      return baseRatio * 0.8;
    }
  }
}
