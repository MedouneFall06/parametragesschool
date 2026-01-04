import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
//import 'package:provider/provider.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  children: [
                    // Account Settings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compte',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.person,
                            title: 'Profil',
                            subtitle: 'Modifier vos informations personnelles',
                            onTap: () {
                              // Naviguer vers profil
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.security,
                            title: 'Sécurité',
                            subtitle: 'Mot de passe et authentification',
                            onTap: () {
                              // Naviguer vers sécurité
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.notifications,
                            title: 'Notifications',
                            subtitle: 'Gérer les alertes et notifications',
                            onTap: () {
                              // TODO: Naviguer vers notification-settings
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // App Settings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Application',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.palette,
                            title: 'Apparence',
                            subtitle: 'Thème, couleurs et polices',
                            onTap: () {
                              // TODO: Naviguer vers appearance-settings
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.language,
                            title: 'Langue',
                            subtitle: 'Langue d\'affichage',
                            onTap: () {
                              // TODO: Naviguer vers language-settings
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Privacy & Support
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Confidentialité et support',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.privacy_tip,
                            title: 'Confidentialité',
                            subtitle: 'Politique de confidentialité',
                            onTap: () {
                              // TODO: Naviguer vers privacy-policy
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.description,
                            title: 'Conditions d\'utilisation',
                            subtitle: 'Lire les conditions',
                            onTap: () {
                              // TODO: Naviguer vers terms
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.help,
                            title: 'Aide et support',
                            subtitle: 'FAQ et contact support',
                            onTap: () {
                              // TODO: Naviguer vers help-support
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.info,
                            title: 'À propos',
                            subtitle: 'Informations sur l\'application',
                            onTap: () {
                              // TODO: Naviguer vers about
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Advanced Settings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paramètres avancés',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.sync,
                            title: 'Synchronisation',
                            subtitle: 'Paramètres de sync hors ligne',
                            onTap: () {
                              // Naviguer vers synchronisation
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
                            icon: Icons.backup,
                            title: 'Sauvegarde',
                            subtitle: 'Exporter et importer les données',
                            onTap: () {
                              // Naviguer vers sauvegarde
                            },
                          ),
                          const Divider(),
                          _buildSettingItem(
                            context: context,
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // App Version
                    Container(
                      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.apps, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                          SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Paramétrages School',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  ),
                                ),
                                SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                Text(
                                  'Version 1.0.0 • Build 2024.01.001',
                                  style: TextStyle(
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    // Action Buttons
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        PrimaryButton(
                          text: 'Réinitialiser tout',
                          onPressed: () {
                            _showResetDialog(context);
                          },
                          icon: Icons.restart_alt,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Exporter config',
                          onPressed: () {
                            // Exporter configuration
                          },
                          icon: Icons.download,
                          fullWidth: true,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
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
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: AppTheme.textSecondary, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Réinitialiser les paramètres',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          ),
        ),
        content: Text(
          'Cette action réinitialisera tous les paramètres aux valeurs par défaut. '
          'Êtes-vous sûr de vouloir continuer ?',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              ),
            ),
          ),
          PrimaryButton(
            text: 'Réinitialiser',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Paramètres réinitialisés',
                    style: TextStyle(
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    ),
                  ),
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
