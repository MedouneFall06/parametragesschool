//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  bool _isBackingUp = false;
  bool _isRestoring = false;
  String _selectedBackup = 'local';
  
  // TODO: Remplacer par ViewModel
  final List<Map<String, dynamic>> _backupHistory = [
    {
      'id': '1',
      'type': 'Automatique',
      'date': '2024-01-20 02:00:00',
      'size': '45.2 MB',
      'location': 'Cloud',
      'status': 'success',
    },
    {
      'id': '2',
      'type': 'Manuel',
      'date': '2024-01-19 15:30:00',
      'size': '44.8 MB',
      'location': 'Local',
      'status': 'success',
    },
    {
      'id': '3',
      'type': 'Automatique',
      'date': '2024-01-18 02:00:00',
      'size': '43.5 MB',
      'location': 'Cloud',
      'status': 'success',
    },
    {
      'id': '4',
      'type': 'Automatique',
      'date': '2024-01-17 02:00:00',
      'size': '42.1 MB',
      'location': 'Cloud',
      'status': 'failed',
    },
  ];

  Future<void> _createBackup() async {
    setState(() {
      _isBackingUp = true;
    });

    // TODO: Implémenter sauvegarde réelle
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isBackingUp = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sauvegarde créée avec succès'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  Future<void> _restoreBackup() async {
    setState(() {
      _isRestoring = true;
    });

    // TODO: Implémenter restauration réelle
    //await Future.delapsed(const Duration(seconds: 2));

    setState(() {
      _isRestoring = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Restauration terminée'),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Sauvegardes'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statut actuel
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Statut des sauvegardes',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Row(
                            children: [
                              _buildBackupStatusIndicator(context),
                              SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sauvegarde à jour',
                                      style: TextStyle(
                                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.successColor,
                                      ),
                                    ),
                                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                    Text(
                                      'Dernière sauvegarde: Aujourd\'hui, 02:00',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                      ),
                                    ),
                                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                    if (_isBackingUp) ...[
                                      const LinearProgressIndicator(),
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      Text(
                                        'Sauvegarde en cours...',
                                        style: TextStyle(
                                          color: AppTheme.warningColor,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Statistiques
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Sauvegardes',
                          value: '24',
                          icon: Icons.backup,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Dernière taille',
                          value: '45.2 MB',
                          icon: Icons.storage,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    StatCard(
                      title: 'Espace utilisé',
                      value: '1.2 GB',
                      icon: Icons.cloud,
                      color: AppTheme.infoColor,
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Options de sauvegarde
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Destination',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Choisissez où sauvegarder vos données',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              _buildStorageOption(
                                context: context,
                                type: 'local',
                                name: 'Stockage local',
                                icon: Icons.phone_android,
                                description: 'Sur votre appareil',
                              ),
                              _buildStorageOption(
                                context: context,
                                type: 'cloud',
                                name: 'Cloud',
                                icon: Icons.cloud,
                                description: 'Google Drive / iCloud',
                              ),
                              _buildStorageOption(
                                context: context,
                                type: 'nas',
                                name: 'NAS/Server',
                                icon: Icons.storage,
                                description: 'Serveur local',
                              ),
                              _buildStorageOption(
                                context: context,
                                type: 'external',
                                name: 'Externe',
                                icon: Icons.usb,
                                description: 'Disque externe',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Configuration automatique
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sauvegarde automatique',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SwitchListTile(
                            title: Text(
                              'Activer la sauvegarde automatique',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              ),
                            ),
                            subtitle: Text(
                              'Sauvegarder automatiquement les données',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(Icons.schedule, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                            title: Text(
                              'Fréquence',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              ),
                            ),
                            subtitle: Text(
                              'Tous les jours à 02:00',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            trailing: Icon(Icons.chevron_right, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: Text(
                              'Sauvegarde sur Wi-Fi seulement',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              ),
                            ),
                            subtitle: Text(
                              'Éviter l\'utilisation des données mobiles',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: Text(
                              'Notification après sauvegarde',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              ),
                            ),
                            subtitle: Text(
                              'Recevoir une notification quand la sauvegarde est terminée',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            value: false,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Historique des sauvegardes
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Historique des sauvegardes',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ..._backupHistory.map((backup) {
                            return Column(
                              children: [
                                _buildBackupHistoryItem(context, backup),
                                if (_backupHistory.indexOf(backup) < _backupHistory.length - 1)
                                  const Divider(),
                              ],
                            );
                          }).toList(),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SecondaryButton(
                            text: 'Voir tout l\'historique',
                            onPressed: () {
                              // TODO: Naviguer vers historique complet
                            },
                            fullWidth: true,
                            icon: Icons.history,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Actions principales
                    if (_isBackingUp) ...[
                      PrimaryButton(
                        text: 'Sauvegarde en cours...',
                        onPressed: null,
                        fullWidth: true,
                        icon: Icons.hourglass_bottom,
                      ),
                    ] else ...[
                      PrimaryButton(
                        text: 'Créer une sauvegarde',
                        onPressed: _createBackup,
                        fullWidth: true,
                        icon: Icons.backup,
                      ),
                    ],
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    if (_isRestoring) ...[
                      PrimaryButton(
                        text: 'Restauration en cours...',
                        onPressed: null,
                        fullWidth: true,
                        icon: Icons.hourglass_bottom,
                      ),
                    ] else ...[
                      SecondaryButton(
                        text: 'Restaurer depuis sauvegarde',
                        onPressed: _restoreBackup,
                        fullWidth: true,
                        icon: Icons.restore,
                      ),
                    ],
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    SecondaryButton(
                      text: 'Configurer la sauvegarde cloud',
                      onPressed: () {
                        // TODO: Configurer cloud
                      },
                      fullWidth: true,
                      icon: Icons.cloud_upload,
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Actions avancées
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Actions avancées',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              SecondaryButton(
                                text: 'Exporter config',
                                onPressed: () {
                                  // TODO: Exporter configuration
                                },
                                icon: Icons.download,
                                fullWidth: true,
                              ),
                              SecondaryButton(
                                text: 'Vérifier intégrité',
                                onPressed: () {
                                  // TODO: Vérifier intégrité
                                },
                                icon: Icons.verified,
                                fullWidth: true,
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SecondaryButton(
                            text: 'Gérer l\'espace de stockage',
                            onPressed: () {
                              // TODO: Gérer espace
                            },
                            fullWidth: true,
                            icon: Icons.clean_hands,
                          ),
                        ],
                      ),
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

  Widget _buildBackupStatusIndicator(BuildContext context) {
    return Container(
      width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
      height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
      decoration: BoxDecoration(
        color: AppTheme.successColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.check_circle,
        color: AppTheme.successColor,
        size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
      ),
    );
  }

  Widget _buildStorageOption({
    required BuildContext context,
    required String type,
    required String name,
    required IconData icon,
    required String description,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBackup = type;
        });
      },
      child: Container(
        width: AppConstants.widthPercentage(context, AppConstants.minCardWidth),
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        decoration: BoxDecoration(
          color: _selectedBackup == type
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: _selectedBackup == type
                ? AppTheme.primaryColor
                : Colors.grey[300]!,
            width: _selectedBackup == type ? AppConstants.borderWidth : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.iconSize)),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              ),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupHistoryItem(BuildContext context, Map<String, dynamic> backup) {
    return ListTile(
      leading: Icon(
        backup['status'] == 'success' ? Icons.check_circle : Icons.error,
        color: backup['status'] == 'success' ? AppTheme.successColor : AppTheme.errorColor,
        size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
      ),
      title: Text(
        '${backup['type']} - ${backup['location']}'
      ),
      subtitle: Text(
        '${backup['date']} • ${backup['size']}'
      ),
      trailing: IconButton(
        icon: Icon(Icons.more_vert, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
        onPressed: () {
          _showBackupOptions(backup);
        },
      ),
    );
  }

  void _showBackupOptions(Map<String, dynamic> backup) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Voir détails'),
            onTap: () {
              Navigator.pop(context);
              _showBackupDetails(backup);
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('Restaurer'),
            onTap: () {
              Navigator.pop(context);
              _restoreFromBackup(backup);
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Télécharger'),
            onTap: () {
              Navigator.pop(context);
              _downloadBackup(backup);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: AppTheme.errorColor),
            title: const Text('Supprimer', style: TextStyle(color: AppTheme.errorColor)),
            onTap: () {
              Navigator.pop(context);
              _deleteBackup(backup);
            },
          ),
        ],
      ),
    );
  }

  void _showBackupDetails(Map<String, dynamic> backup) {
    // TODO: Afficher détails
  }

  void _restoreFromBackup(Map<String, dynamic> backup) {
    // TODO: Restaurer depuis cette sauvegarde
  }

  void _downloadBackup(Map<String, dynamic> backup) {
    // TODO: Télécharger
  }

  void _deleteBackup(Map<String, dynamic> backup) {
    // TODO: Supprimer
  }
}
