import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Paramètres'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Account Settings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Compte',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSettingItem(
                            icon: Icons.person,
                            title: 'Profil',
                            subtitle: 'Modifier vos informations personnelles',
                            onTap: () {
                              // Naviguer vers profil
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.security,
                            title: 'Sécurité',
                            subtitle: 'Mot de passe et authentification',
                            onTap: () {
                              // Naviguer vers sécurité
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.notifications,
                            title: 'Notifications',
                            subtitle: 'Gérer les alertes et notifications',
                            onTap: () {
                              Navigator.pushNamed(context, '/notification-settings');
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // App Settings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Application',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSettingItem(
                            icon: Icons.palette,
                            title: 'Apparence',
                            subtitle: 'Thème, couleurs et polices',
                            onTap: () {
                              Navigator.pushNamed(context, '/appearance-settings');
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.language,
                            title: 'Langue',
                            subtitle: 'Langue d\'affichage',
                            onTap: () {
                              Navigator.pushNamed(context, '/language-settings');
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.storage,
                            title: 'Stockage',
                            subtitle: 'Gérer le cache et les données',
                            onTap: () {
                              // Naviguer vers stockage
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Privacy & Support
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Confidentialité et support',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSettingItem(
                            icon: Icons.privacy_tip,
                            title: 'Confidentialité',
                            subtitle: 'Politique de confidentialité',
                            onTap: () {
                              Navigator.pushNamed(
                                context, 
                                '/privacy-policy',
                                arguments: {'showConsent': false},
                              );
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.description,
                            title: 'Conditions d\'utilisation',
                            subtitle: 'Lire les conditions',
                            onTap: () {
                              Navigator.pushNamed(
                                context, 
                                '/terms',
                                arguments: {'showAcceptButton': false},
                              );
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.help,
                            title: 'Aide et support',
                            subtitle: 'FAQ et contact support',
                            onTap: () {
                              Navigator.pushNamed(context, '/help-support');
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.info,
                            title: 'À propos',
                            subtitle: 'Informations sur l\'application',
                            onTap: () {
                              Navigator.pushNamed(context, '/about');
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Advanced Settings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Paramètres avancés',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSettingItem(
                            icon: Icons.sync,
                            title: 'Synchronisation',
                            subtitle: 'Paramètres de sync hors ligne',
                            onTap: () {
                              // Naviguer vers synchronisation
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.backup,
                            title: 'Sauvegarde',
                            subtitle: 'Exporter et importer les données',
                            onTap: () {
                              // Naviguer vers sauvegarde
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            icon: Icons.developer_mode,
                            title: 'Développeur',
                            subtitle: 'Options de développement',
                            onTap: () {
                              // Naviguer vers dev
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // App Version
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.apps, color: AppTheme.primaryColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Paramétrages School',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Version 1.0.0 • Build 2024.01.001',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PrimaryButton(
                            text: 'Vérifier',
                            onPressed: () {
                              // Vérifier mises à jour
                            },
                            fullWidth: false,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Réinitialiser tout',
                            onPressed: () {
                              _showResetDialog(context);
                            },
                            icon: Icons.restart_alt,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Exporter config',
                            onPressed: () {
                              // Exporter configuration
                            },
                            icon: Icons.download,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.primaryColor),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser les paramètres'),
        content: const Text(
          'Cette action réinitialisera tous les paramètres aux valeurs par défaut. '
          'Êtes-vous sûr de vouloir continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Réinitialiser',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Paramètres réinitialisés'),
                ),
              );
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }
}