import 'package:flutter/material.dart';

class ResponsiveHelper {
  // Points de rupture
  static const double verySmall = 350;  // iPhone SE
  static const double small = 400;      // Petits mobiles
  static const double medium = 600;     // Mobiles standards
  static const double large = 900;      // Tablettes
  static const double xlarge = 1200;    // Desktop

  // Détection de l'écran
  static bool isVerySmallScreen(BuildContext context) => 
      screenWidth(context) < verySmall;
  
  static bool isSmallScreen(BuildContext context) => 
      screenWidth(context) < medium;
  
  static bool isMediumScreen(BuildContext context) => 
      screenWidth(context) >= medium && screenWidth(context) < large;
  
  static bool isLargeScreen(BuildContext context) => 
      screenWidth(context) >= large;
  
  static double screenWidth(BuildContext context) => 
      MediaQuery.of(context).size.width;

  // TAILLES ADAPTATIVES POUR TOUT
  static double getCardPadding(BuildContext context) {
    if (isVerySmallScreen(context)) return 8;
    if (isSmallScreen(context)) return 10;
    return 12;
  }

  static double getTextSize(BuildContext context, {required String type}) {
    if (isVerySmallScreen(context)) {
      switch (type) {
        case 'title': return 13;
        case 'subtitle': return 11;
        case 'body': return 10;
        case 'small': return 9;
        default: return 11;
      }
    } else if (isSmallScreen(context)) {
      switch (type) {
        case 'title': return 14;
        case 'subtitle': return 12;
        case 'body': return 11;
        case 'small': return 10;
        default: return 12;
      }
    } else {
      switch (type) {
        case 'title': return 16;
        case 'subtitle': return 14;
        case 'body': return 13;
        case 'small': return 11;
        default: return 14;
      }
    }
  }

  static double getIconSize(BuildContext context) {
    if (isVerySmallScreen(context)) return 12;
    if (isSmallScreen(context)) return 14;
    return 16;
  }

  static double getAvatarSize(BuildContext context) {
    if (isVerySmallScreen(context)) return 32;
    if (isSmallScreen(context)) return 36;
    return 40;
  }

  static double getSpacing(BuildContext context) {
    if (isVerySmallScreen(context)) return 4;
    if (isSmallScreen(context)) return 8;
    return 12;
  }

  // Pour les formulaires et champs
  static double getFormFieldHeight(BuildContext context) {
    if (isVerySmallScreen(context)) return 45;
    if (isSmallScreen(context)) return 50;
    return 56;
  }

  static EdgeInsets getFormFieldPadding(BuildContext context) {
    if (isVerySmallScreen(context)) return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
    if (isSmallScreen(context)) return const EdgeInsets.symmetric(horizontal: 14, vertical: 12);
    return const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
  }

  // Pour les boutons
  static double getButtonHeight(BuildContext context) {
    if (isVerySmallScreen(context)) return 36;
    if (isSmallScreen(context)) return 42;
    return 48;
  }

  static EdgeInsets getButtonPadding(BuildContext context) {
    if (isVerySmallScreen(context)) return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    if (isSmallScreen(context)) return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
    return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  }
}