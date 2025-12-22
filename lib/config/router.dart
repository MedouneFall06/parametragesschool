// ============================================================================
// FICHIER : lib/config/router.dart
// ============================================================================
//
// Navigation globale avec GoRouter + Riverpod
// Gestion de l’authentification et des redirections
//
// ============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/screens/forgot_password_screen.dart';

// ---------------- PROVIDER AUTH ----------------
import '../providers/auth_provider.dart';

// ---------------- SCREENS ----------------
import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';

import '../screens/profile_screen.dart';
import '../screens/user_management_screen.dart';

import '../screens/etudiant_list_screen.dart';
import '../screens/etudiant_screen.dart';
import '../screens/etudiant_detail_screen.dart';

import '../screens/enseignant_screen.dart';
import '../screens/teacher_evaluation_screen.dart';

import '../screens/absence_screen.dart';
import '../screens/absence_list_screen.dart';

import '../screens/note_screen.dart';
import '../screens/note_list_screen.dart';

import '../screens/schedule_screen.dart';
import '../screens/emploi_du_temps_screen.dart';

import '../screens/classe_screen.dart';
import '../screens/matiere_screen.dart';

import '../screens/messaging_screen.dart';
import '../screens/notification_settings_screen.dart';

import '../screens/reports_screen.dart';
import '../screens/advanced_stats_screen.dart';
import '../screens/auto_reports_screen.dart';

import '../screens/admin_dashboard_screen.dart';
import '../screens/audit_log_screen.dart';
import '../screens/backup_screen.dart';
import '../screens/export_data_screen.dart';
import '../screens/sync_screen.dart';

import '../screens/settings_screen.dart';
import '../screens/appearance_settings_screen.dart';
import '../screens/language_settings_screen.dart';
import '../screens/privacy_policy_screen.dart';
import '../screens/terms_screen.dart';

import '../screens/help_support_screen.dart';
import '../screens/technical_support_screen.dart';
import '../screens/developer_screen.dart';
import '../screens/about_screen.dart';
import '../screens/coming_soon_screen.dart';
import '../screens/no_internet_screen.dart';

// ============================================================================
// ROUTER PROVIDER
// ============================================================================
final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/home',

    // ------------------------------------------------------------------------
    // REDIRECTION AUTH
    // ------------------------------------------------------------------------
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToForgotPassword = state.matchedLocation == '/forgot-password';

      // Autoriser /forgot-password même si non authentifié
      if (isGoingToForgotPassword) {
        return null;  // Pas de redirection
      }

      if (!isAuthenticated && !isGoingToLogin) {
        return '/login';
      }

      if (isAuthenticated && isGoingToLogin) {
        return '/home';
      }

      return null;
    },

    // ------------------------------------------------------------------------
    // ROUTES
    // ------------------------------------------------------------------------
    routes: [

      // ================= AUTH =================
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // ================= CORE =================
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // ================= USERS =================
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/user-management',
        name: 'userManagement',
        builder: (context, state) => const UserManagementScreen(),
      ),

      // ================= ÉTUDIANTS =================
      // Route pour l'écran de détail étudiant avec paramètres
      // Dans config/router.dart
      GoRoute(
        path: '/etudiants',
        builder: (context, state) => const EtudiantListScreen(),
      ),
      GoRoute(
        path: '/etudiant-detail',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>? ?? {};
          return EtudiantDetailScreen(
            etudiant: args['etudiant']!,
            nomClasse: args['nomClasse'],
          );
        },
      ),
      GoRoute(
        path: '/etudiant-create',
        builder: (context, state) => const EtudiantEditScreen(mode: 'create'),
      ),
      GoRoute(
        path: '/etudiant-edit',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>? ?? {};
          return EtudiantEditScreen(
            etudiant: args['etudiant']!,
            mode: 'edit',
          );
        },
      ),

      // ================= ENSEIGNANTS =================
      GoRoute(
        path: '/enseignants',
        name: 'enseignants',
        builder: (context, state) => const EnseignantScreen(),
      ),
      GoRoute(
        path: '/teacher-evaluation',
        name: 'teacherEvaluation',
        builder: (context, state) => const TeacherEvaluationScreen(),
      ),

      // ================= ABSENCES =================
      GoRoute(
        path: '/absences',
        name: 'absence',
        builder: (context, state) => const AbsenceScreen(),
      ),
      GoRoute(
        path: '/absences/list',
        name: 'absenceList',
        builder: (context, state) => const AbsenceListScreen(),
      ),

      // ================= NOTES =================
      GoRoute(
        path: '/notes',
        name: 'note',
        builder: (context, state) => const NoteScreen(),
      ),
      GoRoute(
        path: '/notes/list',
        name: 'noteList',
        builder: (context, state) => const NoteListScreen(),
      ),

      // ================= EMPLOI DU TEMPS =================
      GoRoute(
        path: '/schedule',
        name: 'schedule',
        builder: (context, state) => const ScheduleScreen(),
      ),
      GoRoute(
        path: '/emploi-du-temps',
        name: 'emploiDuTemps',
        builder: (context, state) => const EmploiDuTempsScreen(),
      ),

      // ================= CLASSES & MATIÈRES =================
      GoRoute(
        path: '/classes',
        name: 'classes',
        builder: (context, state) => const ClasseScreen(),
      ),
      GoRoute(
        path: '/matieres',
        name: 'matieres',
        builder: (context, state) => const MatiereScreen(),
      ),

      // ================= COMMUNICATION =================
      GoRoute(
        path: '/messaging',
        name: 'messaging',
        builder: (context, state) => const MessagingScreen(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notificationSettings',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),

      // ================= RAPPORTS =================
      GoRoute(
        path: '/reports',
        name: 'reports',
        builder: (context, state) => const ReportsScreen(),
      ),
      GoRoute(
        path: '/advanced-stats',
        name: 'advancedStats',
        builder: (context, state) => const AdvancedStatsScreen(),
      ),
      GoRoute(
        path: '/auto-reports',
        name: 'autoReports',
        builder: (context, state) => const AutoReportsScreen(),
      ),

      // ================= ADMIN =================
      GoRoute(
        path: '/admin-dashboard',
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: '/audit-log',
        name: 'auditLog',
        builder: (context, state) => const AuditLogScreen(),
      ),
      GoRoute(
        path: '/backup',
        name: 'backup',
        builder: (context, state) => const BackupScreen(),
      ),
      GoRoute(
        path: '/export-data',
        name: 'exportData',
        builder: (context, state) => const ExportDataScreen(),
      ),
      GoRoute(
        path: '/sync',
        name: 'sync',
        builder: (context, state) => const SyncScreen(),
      ),

      // ================= SETTINGS =================
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/appearance-settings',
        name: 'appearanceSettings',
        builder: (context, state) => const AppearanceSettingsScreen(),
      ),
      GoRoute(
        path: '/language-settings',
        name: 'languageSettings',
        builder: (context, state) => const LanguageSettingsScreen(),
      ),
      GoRoute(
        path: '/privacy-policy',
        name: 'privacyPolicy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: '/terms',
        name: 'terms',
        builder: (context, state) => const TermsScreen(),
      ),

      // ================= HELP =================
      GoRoute(
        path: '/help',
        name: 'helpSupport',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/technical-support',
        name: 'technicalSupport',
        builder: (context, state) => const TechnicalSupportScreen(),
      ),
      GoRoute(
        path: '/developer',
        name: 'developer',
        builder: (context, state) => const DeveloperScreen(),
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/coming-soon',
        name: 'comingSoon',
        builder: (context, state) => const ComingSoonScreen(),
      ),
      GoRoute(
        path: '/no-internet',
        name: 'noInternet',
        builder: (context, state) => const NoInternetScreen(),
      ),
      // Autres
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  );
});
