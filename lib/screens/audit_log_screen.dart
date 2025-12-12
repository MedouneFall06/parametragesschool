import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
// ignore: unused_import
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
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
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedFilter,
                            decoration: const InputDecoration(
                              labelText: 'Filtrer par type',
                              border: OutlineInputBorder(),
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
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedTimeRange,
                            decoration: const InputDecoration(
                              labelText: 'Période',
                              border: OutlineInputBorder(),
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
                        ),
                      ],
                    ),
                  ),
                  
                  // Statistiques
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        _buildStatItem(
                          label: 'Total logs',
                          value: '1,248',
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 16),
                        _buildStatItem(
                          label: 'Aujourd\'hui',
                          value: '42',
                          color: AppTheme.accentColor,
                        ),
                        const SizedBox(width: 16),
                        _buildStatItem(
                          label: 'Alertes',
                          value: '5',
                          color: AppTheme.warningColor,
                        ),
                        const SizedBox(width: 16),
                        _buildStatItem(
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
                        return _buildLogItem(log);
                      },
                    ),
                  ),
                  
                  // Actions
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Exporter les logs',
                            onPressed: () {
                              _exportLogs();
                            },
                            icon: Icons.download,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SecondaryButton(
                            text: 'Effacer anciens logs',
                            onPressed: () {
                              _showClearLogsDialog(context);
                            },
                            icon: Icons.delete_sweep,
                          ),
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
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
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

  Widget _buildLogItem(Map<String, dynamic> log) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    log['action'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getLevelColor(log['level']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    log['level'].toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getLevelColor(log['level']),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              log['details'],
              style: const TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.person, size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  log['user'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  log['timestamp'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.computer, size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Text(
                  log['ip'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Voir détails',
                    onPressed: () {
                      _showLogDetails(log);
                    },
                    fullWidth: true,
                    icon: Icons.visibility,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SecondaryButton(
                    text: 'Exporter',
                    onPressed: () {
                      _exportSingleLog(log);
                    },
                    fullWidth: true,
                    icon: Icons.download,
                  ),
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

  void _showLogDetails(Map<String, dynamic> log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Détails du log'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Action:', log['action']),
              _buildDetailRow('Utilisateur:', log['user']),
              _buildDetailRow('Détails:', log['details']),
              _buildDetailRow('Date/Heure:', log['timestamp']),
              _buildDetailRow('Adresse IP:', log['ip']),
              _buildDetailRow('Niveau:', log['level']),
              _buildDetailRow('ID:', log['id']),
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textSecondary,
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