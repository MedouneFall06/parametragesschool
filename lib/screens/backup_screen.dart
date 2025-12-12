//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
// TODO: Importer les services de sauvegarde

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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statut actuel
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Statut des sauvegardes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildBackupStatusIndicator(),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sauvegarde à jour',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.successColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Dernière sauvegarde: Aujourd\'hui, 02:00',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (_isBackingUp) ...[
                                      const LinearProgressIndicator(),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Sauvegarde en cours...',
                                        style: TextStyle(
                                          color: AppTheme.warningColor,
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
                    
                    const SizedBox(height: 24),
                    
                    // Statistiques
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Sauvegardes',
                            value: '24',
                            icon: Icons.backup,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Dernière taille',
                            value: '45.2 MB',
                            icon: Icons.storage,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Espace utilisé',
                      value: '1.2 GB',
                      icon: Icons.cloud,
                      color: AppTheme.infoColor,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Options de sauvegarde
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Destination',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Choisissez où sauvegarder vos données',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildStorageOption(
                                type: 'local',
                                name: 'Stockage local',
                                icon: Icons.phone_android,
                                description: 'Sur votre appareil',
                              ),
                              _buildStorageOption(
                                type: 'cloud',
                                name: 'Cloud',
                                icon: Icons.cloud,
                                description: 'Google Drive / iCloud',
                              ),
                              _buildStorageOption(
                                type: 'nas',
                                name: 'NAS/Server',
                                icon: Icons.storage,
                                description: 'Serveur local',
                              ),
                              _buildStorageOption(
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
                    
                    const SizedBox(height: 24),
                    
                    // Configuration automatique
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sauvegarde automatique',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Activer la sauvegarde automatique'),
                            subtitle: const Text('Sauvegarder automatiquement les données'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          const ListTile(
                            leading: Icon(Icons.schedule),
                            title: Text('Fréquence'),
                            subtitle: Text('Tous les jours à 02:00'),
                            trailing: Icon(Icons.chevron_right),
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Sauvegarde sur Wi-Fi seulement'),
                            subtitle: const Text('Éviter l\'utilisation des données mobiles'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Notification après sauvegarde'),
                            subtitle: const Text('Recevoir une notification quand la sauvegarde est terminée'),
                            value: false,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Historique des sauvegardes
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Historique des sauvegardes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._backupHistory.map((backup) {
                            return Column(
                              children: [
                                _buildBackupHistoryItem(backup),
                                if (_backupHistory.indexOf(backup) < _backupHistory.length - 1)
                                  const Divider(),
                              ],
                            );
                          }).toList(),
                          const SizedBox(height: 16),
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
                    
                    const SizedBox(height: 32),
                    
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
                    
                    const SizedBox(height: 16),
                    
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
                    
                    const SizedBox(height: 16),
                    
                    SecondaryButton(
                      text: 'Configurer la sauvegarde cloud',
                      onPressed: () {
                        // TODO: Configurer cloud
                      },
                      fullWidth: true,
                      icon: Icons.cloud_upload,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Actions avancées
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actions avancées',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Exporter config',
                                  onPressed: () {
                                    // TODO: Exporter configuration
                                  },
                                  icon: Icons.download,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Vérifier intégrité',
                                  onPressed: () {
                                    // TODO: Vérifier intégrité
                                  },
                                  icon: Icons.verified,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
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

  Widget _buildBackupStatusIndicator() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppTheme.successColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_circle,
        color: AppTheme.successColor,
        size: 28,
      ),
    );
  }

  Widget _buildStorageOption({
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
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedBackup == type
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _selectedBackup == type
                ? AppTheme.primaryColor
                : Colors.grey[300]!,
            width: _selectedBackup == type ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 32),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupHistoryItem(Map<String, dynamic> backup) {
    return ListTile(
      leading: Icon(
        backup['status'] == 'success' ? Icons.check_circle : Icons.error,
        color: backup['status'] == 'success' ? AppTheme.successColor : AppTheme.errorColor,
      ),
      title: Text('${backup['type']} - ${backup['location']}'),
      subtitle: Text('${backup['date']} • ${backup['size']}'),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
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