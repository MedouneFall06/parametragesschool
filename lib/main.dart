// ============================================================================
// FICHIER : lib/main.dart
// ============================================================================
//
// Point d'entrée de l'application Flutter.
// Ce fichier initialise l'application et configure la navigation de base.
// 
// Points pédagogiques couverts :
// - Structure de base d'une application Flutter
// - Configuration du MaterialApp
// - Gestion de la navigation initiale
// - Bonnes pratiques d'importation
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parametragesschool/screens/note_screen.dart';
import 'config/router.dart';

import 'package:parametragesschool/core/responsive/responsive_wrapper.dart'; // AJOUTE CET IMPORT

// ----------------------------------------------------------------------------
// IMPORTATIONS DES ÉCRANS
// ----------------------------------------------------------------------------
//
// Importation des différents écrans de l'application.
// Convention : organiser les imports par catégories (écrans, widgets, modèles, etc.)
//
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

import 'screens/forgot_password_screen.dart';
import 'screens/help_support_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/terms_screen.dart';

import 'screens/privacy_policy_screen.dart';
import 'screens/about_screen.dart';
import 'screens/no_internet_screen.dart';
import 'screens/maintenance_screen.dart';
import 'screens/coming_soon_screen.dart';

import 'screens/appearance_settings_screen.dart';
import 'screens/language_settings_screen.dart';
import 'screens/notification_settings_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';


// ============================================================================
// 1. FONCTION MAIN : POINT D'ENTRÉE DE L'APPLICATION
// ============================================================================
//
// Toute application Flutter commence par exécuter la fonction main().
// Elle appelle runApp() qui initialise l'interface utilisateur.
//
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// ============================================================================
// 2. WIDGET RACINE : MyApp
// ============================================================================
//
// MyApp est le widget racine qui contient toute l'application.
// Il doit être un StatelessWidget ou StatefulWidget, et retourne un MaterialApp.
//
// Pourquoi MaterialApp ?
// - Fournit une base pour les applications Material Design
// - Gère la navigation, les thèmes, les localisations
// - Offre de nombreux widgets prédéfinis
//
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ------------------------------------------------------------------------
    // 3. MATERIALAPP : CONFIGURATION PRINCIPALE
    // ------------------------------------------------------------------------
    //
    // MaterialApp est le widget qui encapsule toute l'application.
    // Il fournit :
    // - Un système de navigation (Navigator)
    // - Un thème par défaut
    // - Des routes nommées
    // - Des paramètres de débogage
    //
    
    final router = ref.watch(routerProvider);


    return MaterialApp.router(
      /*builder: (context, child) { // ← AJOUTÉ
        return ResponsiveWrapper(
          child: child!,
        );
      },*/
      // ----------------------------------------------------------------------
      // 4. ÉCRAN D'ACCUEIL (home)
      // ----------------------------------------------------------------------
      //
      // Définit le premier écran affiché au lancement de l'application.
      // Ici, on commence par l'écran de connexion.
      //
      // Pourquoi LoginScreen en premier ?
      // - Authentification requise avant d'accéder au contenu
      // - Expérience utilisateur standard pour les apps nécessitant un login
      // - Possibilité de vérifier les tokens/sessions existants
      //
      routerConfig: router,

      // ----------------------------------------------------------------------
      // 5. CONFIGURATION DU THÈME
      // ----------------------------------------------------------------------
      //
      // Définit l'apparence visuelle de l'application.
      // On peut personnaliser les couleurs, typographies, formes, etc.
      //
      theme: ThemeData(
        // Couleur principale de l'application
        primaryColor: Colors.blue,

        // Palette de couleurs (optionnelle mais recommandée)
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),

        // Style des textes
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
          ),
        ),

        // Style des Input (TextFields)
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),

      // ----------------------------------------------------------------------
      // 6. DÉSACTIVATION DE LA BANNIÈRE DE DÉBOGAGE
      // ----------------------------------------------------------------------
      //
      // Enlève l'étiquette "DEBUG" rouge dans le coin supérieur droit
      // en mode développement.
      //
      // IMPORTANT : Ne pas oublier de la remettre à true pendant le développement
      // si vous avez besoin de déboguer.
      //
      debugShowCheckedModeBanner: false,

      // ----------------------------------------------------------------------
      // 7. ROUTES NOMNÉES (OPTIONNEL - POUR PLUS TARD)
      // ----------------------------------------------------------------------
      //
      // Vous pouvez définir des routes nommées pour une navigation plus claire :
      //
      // routes: {
      //   '/': (context) => const LoginScreen(),
      //   '/home': (context) => const HomeScreen(),
      //   // Ajouter d'autres routes ici
      // },
      //
      // Puis naviguer avec :
      // Navigator.pushNamed(context, '/home');
      //

      // ----------------------------------------------------------------------
      // 8. TITRE DE L'APPLICATION
      // ----------------------------------------------------------------------
      //
      // Le titre apparaît dans le gestionnaire de tâches du système d'exploitation.
      //
      title: 'Gestion Éducative',

      // ----------------------------------------------------------------------
      // 9. AUTRES PARAMÈTRES UTILES
      // ----------------------------------------------------------------------
      //
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      //
      // supportedLocales: const [
      //   Locale('fr', 'FR'), // Français
      //   Locale('en', 'US'), // Anglais
      // ],
      //
      // locale: const Locale('fr', 'FR'),
      //
    );
  }
}

// ============================================================================
// NOTES POUR LA STRUCTURE FUTURE :
// ============================================================================
//
// 1. GESTION D'ÉTAT :
//    - Pour gérer l'état d'authentification, vous pourriez utiliser :
//        * Provider
//        * Riverpod
//        * Bloc
//        * GetX
//
// 2. NAVIGATION CONDITIONNELLE :
//    - Après l'authentification, rediriger vers HomeScreen
//    - Exemple :
//        home: StreamBuilder<User?>(
//          stream: FirebaseAuth.instance.authStateChanges(),
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              return const HomeScreen();
//            }
//            return const LoginScreen();
//          },
//        ),
//
// 3. GESTION DES ERREURS :
//    - Ajouter un ErrorWidget.builder pour capturer les erreurs non gérées
//
// 4. INTERNATIONALISATION :
//    - Ajouter les packages de localisation si nécessaire
//
// 5. PERFORMANCE :
//    - Activer les outils de performance en développement :
//        showPerformanceOverlay: false,
//        checkerboardRasterCacheImages: false,
//        checkerboardOffscreenLayers: false,
//
// ============================================================================