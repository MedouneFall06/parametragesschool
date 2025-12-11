import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A237E); // Bleu foncé
  static const Color secondaryColor = Color(0xFF2196F3); // Bleu moyen
  static const Color accentColor = Color(0xFF4CAF50); // Vert
  static const Color backgroundColor = Color(0xFFF5F5F5); // Gris clair
  static const Color cardColor = Colors.white;
  static const Color textPrimary = Color(0xFF424242); // Gris foncé
  static const Color textSecondary = Color(0xFF757575); // Gris moyen
  static const Color errorColor = Color(0xFFF44336); // Rouge
  static const Color warningColor = Color(0xFFFF9800); // Orange
  static const Color successColor = Color(0xFF4CAF50); // Vert
  static const Color infoColor = Color(0xFF2196F3); // Bleu info
  
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: textSecondary,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      buttonColor: primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}