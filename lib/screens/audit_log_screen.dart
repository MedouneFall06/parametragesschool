import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
// TODO: Importer les modèles d'audit

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen> {
  String _selectedFilter = 'all';
  String _selectedTimeRange = 'today';
  
  // TODO: Remplacer par des données réelles depuis ViewModel
  final List<Map<String, dynamic>> _auditLogs = [
    {
      'id': '1',
      'user': 'Admin User',
      'action': 'Connexion',
      'details': 'Connexion réussie depuis l\'app mobile',
      'timestamp': '2024-01-20 14:30:22',
      'ip': '192.168.1.100',
      'level': 'info',
    },
    {
      'id': '2',
      'user': 'Enseignant Math',
      'action': 'Modification note',
      'details': 'Note modifiée pour l\'étudiant Fall Medoune (Math: 14.5 → 15.0)',
      'timestamp': '2024-01-20 13:15:10',
      'ip': '192.168.1.101',
      'level': 'warning',
    },
    {
      'id': '3',
      'user': 'System',
      'action': 'Synchronisation',
      'details': 'Synchronisation automatique terminée (5 opérations)',
      'timestamp': '2024-01-20 12:00:00',
      'ip': '127.0.0.1',
      'level': 'info',
    },
    {
      'id': '4',
      'user': 'Admin User',
      'action': 'Suppression',
      'details': 'Étudiant supprimé: Diop Awa',
      'timestamp': '2024-01-19 16:45:33',
      'ip': '192.168.1.100',
      'level': 'error',
    },
    {
      'id': '5',
      'user': 'Parent User',
      'action': 'Consultation',
      'details': 'Consultation des notes de l\'étudiant Fall Medoune',
      'timestamp': '2024-01-19 15:20:18',
      'ip': '192.168.1.102',
      'level': 'info',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Journal d\'audit'),
            Expanded(
              child: Column(
                children: [
                  // Filtres
                  Container(
                    padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                    color: Colors.white,
                    child: ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        DropdownButtonFormField<String>(
                          value: _selectedFilter,
                          decoration: InputDecoration(
                            labelText: 'Filtrer par type',
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('Tous les logs'),
                            ),
                            DropdownMenuItem(
                              value: 'login',
                              child: Text('Connexions'),
                            ),
                            DropdownMenuItem(
                              value: 'modification',
                              child: Text('Modifications'),
                            ),
                            DropdownMenuItem(
                              value: 'deletion',
                              child: Text('Suppressions'),
                            ),
                            DropdownMenuItem(
                              value: 'system',
                              child: Text('Système'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedFilter = value!;
                            });
                          },
                        ),
                        DropdownButtonFormField<String>(
                          value: _selectedTimeRange,
                          decoration: InputDecoration(
                            labelText: 'Période',
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'today',
                              child: Text('Aujourd\'hui'),
                            ),
                            DropdownMenuItem(
                              value: 'week',
                              child: Text('7 derniers jours'),
                            ),
                            DropdownMenuItem(
                              value: 'month',
                              child: Text('30 derniers jours'),
                            ),
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('Tout l\'historique'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedTimeRange = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Statistiques
                  Container(
                    padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                    color: Colors.white,
                    child: ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        _buildStatItem(
                          context: context,
                          label: 'Total logs',
                          value: '1,248',
                          color: AppTheme.primaryColor,
                        ),
                        _buildStatItem(
                          context: context,
                          label: 'Aujourd\'hui',
                          value: '42',
                          color: AppTheme.accentColor,
                        ),
                        _buildStatItem(
                          context: context,
                          label: 'Alertes',
                          value: '5',
                          color: AppTheme.warningColor,
                        ),
                        _buildStatItem(
                          context: context,
                          label: 'Erreurs',
                          value: '2',
                          color: AppTheme.errorColor,
                        ),
                      ],
                    ),
                  ),
                  
                  // Liste des logs
                  Expanded(
                    child: ListView.builder(
                      itemCount: _auditLogs.length,
                      itemBuilder: (context, index) {
                        final log = _auditLogs[index];
                        return _buildLogItem(context, log);
                      },
                    ),
                  ),
                  
                  // Actions
                  Container(
                    padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                    color: Colors.white,
                    child: ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        PrimaryButton(
                          text: 'Exporter les logs',
                          onPressed: () {
                            _exportLogs();
                          },
                          icon: Icons.download,
                          fullWidth: true,
                        ),
                        SecondaryButton(
                          text: 'Effacer anciens logs',
                          onPressed: () {
                            _showClearLogsDialog(context);
                          },
                          icon: Icons.delete_sweep,
                          fullWidth: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              label,
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

  Widget _buildLogItem(BuildContext context, Map<String, dynamic> log) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.widthPercentage(context, AppConstants.cardPadding),
        vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    log['action'],
                    style: TextStyle(
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                    vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                  ),
                  decoration: BoxDecoration(
                    color: _getLevelColor(log['level']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: Text(
                    log['level'].toUpperCase(),
                    style: TextStyle(
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                      fontWeight: FontWeight.w600,
                      color: _getLevelColor(log['level']),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              log['details'],
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
              ),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Row(
              children: [
                Icon(Icons.person, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize), color: AppTheme.textSecondary),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Text(
                  log['user'],
                  style: TextStyle(
                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Icon(Icons.access_time, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize), color: AppTheme.textSecondary),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Text(
                  log['timestamp'],
                  style: TextStyle(
                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Icon(Icons.computer, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize), color: AppTheme.textSecondary),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Text(
                  log['ip'],
                  style: TextStyle(
                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            ResponsiveGrid(
              customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
              children: [
                SecondaryButton(
                  text: 'Voir détails',
                  onPressed: () {
                    _showLogDetails(context, log);
                  },
                  fullWidth: true,
                  icon: Icons.visibility,
                ),
                SecondaryButton(
                  text: 'Exporter',
                  onPressed: () {
                    _exportSingleLog(log);
                  },
                  fullWidth: true,
                  icon: Icons.download,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'error':
        return AppTheme.errorColor;
      case 'warning':
        return AppTheme.warningColor;
      case 'info':
        return AppTheme.infoColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  void _exportLogs() {
    // TODO: Implémenter export des logs
  }

  void _showClearLogsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Effacer les logs'),
        content: const Text(
          'Cette action supprimera tous les logs de plus de 30 jours. '
          'Cette opération est irréversible. Continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Effacer',
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implémenter effacement
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  void _showLogDetails(BuildContext context, Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Détails du log',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow(context, 'Action:', log['action']),
              _buildDetailRow(context, 'Utilisateur:', log['user']),
              _buildDetailRow(context, 'Détails:', log['details']),
              _buildDetailRow(context, 'Date/Heure:', log['timestamp']),
              _buildDetailRow(context, 'Adresse IP:', log['ip']),
              _buildDetailRow(context, 'Niveau:', log['level']),
              _buildDetailRow(context, 'ID:', log['id']),
            ],
          ),
        ),
        actions: [
          PrimaryButton(
            text: 'Fermer',
            onPressed: () => Navigator.pop(context),
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
            ),
          ),
        ],
      ),
    );
  }

  void _exportSingleLog(Map<String, dynamic> log) {
    // TODO: Implémenter export d'un log
  }
}
