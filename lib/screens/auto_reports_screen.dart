import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
// TODO: Importer les services de rapports

class AutoReportsScreen extends StatefulWidget {
  const AutoReportsScreen({super.key});

  @override
  State<AutoReportsScreen> createState() => _AutoReportsScreenState();
}

class _AutoReportsScreenState extends State<AutoReportsScreen> {
  final List<Map<String, dynamic>> _scheduledReports = [
    {
      'id': '1',
      'name': 'Rapport hebdomadaire des notes',
      'type': 'notes',
      'frequency': 'weekly',
      'recipients': ['parents@ecole.com'],
      'lastSent': '2024-01-15',
      'enabled': true,
    },
    {
      'id': '2',
      'name': 'Rapport mensuel des absences',
      'type': 'attendance',
      'frequency': 'monthly',
      'recipients': ['direction@ecole.com'],
      'lastSent': '2024-01-01',
      'enabled': true,
    },
    {
      'id': '3',
      'name': 'Bulletin trimestriel',
      'type': 'bulletin',
      'frequency': 'quarterly',
      'recipients': ['parents@ecole.com', 'archives@ecole.com'],
      'lastSent': '2023-12-15',
      'enabled': false,
    },
  ];
  
  // TODO: Remplacer par ViewModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Rapports automatiques'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nouveau rapport
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Créer un nouveau rapport',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Nouveau rapport automatique',
                            onPressed: () {
                              _showCreateReportDialog(context);
                            },
                            fullWidth: true,
                            icon: Icons.add_circle,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Rapports programmés
                    const Text(
                      'Rapports programmés',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    ..._scheduledReports.map((report) {
                      return Column(
                        children: [
                          _buildReportCard(report),
                          if (_scheduledReports.indexOf(report) < _scheduledReports.length - 1)
                            const SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                    
                    const SizedBox(height: 24),
                    
                    // Modèles de rapports
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Modèles disponibles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Choisissez un modèle prédéfini pour créer rapidement un rapport',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildTemplateCard(
                                name: 'Rapport de notes',
                                icon: Icons.assignment,
                                color: AppTheme.primaryColor,
                              ),
                              _buildTemplateCard(
                                name: 'Rapport d\'absences',
                                icon: Icons.person_off,
                                color: AppTheme.accentColor,
                              ),
                              _buildTemplateCard(
                                name: 'Bulletin scolaire',
                                icon: Icons.school,
                                color: AppTheme.secondaryColor,
                              ),
                              _buildTemplateCard(
                                name: 'Statistiques de classe',
                                icon: Icons.assessment,
                                color: AppTheme.infoColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Paramètres d'envoi
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Paramètres d\'envoi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Notifications par email'),
                            subtitle: const Text('Envoyer des notifications quand un rapport est généré'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Archive automatique'),
                            subtitle: const Text('Conserver une copie de tous les rapports envoyés'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Validation avant envoi'),
                            subtitle: const Text('Requérir une validation manuelle avant l\'envoi'),
                            value: false,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Actions globales
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Tester tous les rapports',
                            onPressed: () {
                              // TODO: Tester
                            },
                            icon: Icons.play_arrow,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SecondaryButton(
                            text: 'Exporter la configuration',
                            onPressed: () {
                              // TODO: Exporter
                            },
                            icon: Icons.download,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    SecondaryButton(
                      text: 'Historique des rapports envoyés',
                      onPressed: () {
                        // TODO: Naviguer vers historique
                      },
                      fullWidth: true,
                      icon: Icons.history,
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

  Widget _buildReportCard(Map<String, dynamic> report) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            _getReportIcon(report['type']),
                            size: 14,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getFrequencyText(report['frequency']),
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: report['enabled'],
                  onChanged: (value) {
                    setState(() {
                      report['enabled'] = value;
                    });
                  },
                  activeColor: AppTheme.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email, size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Destinataires: ${(report['recipients'] as List).join(', ')}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (report['lastSent'] != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: AppTheme.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    'Dernier envoi: ${report['lastSent']}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Modifier',
                    onPressed: () {
                      _editReport(report);
                    },
                    fullWidth: true,
                    icon: Icons.edit,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SecondaryButton(
                    text: 'Tester',
                    onPressed: () {
                      _testReport(report);
                    },
                    fullWidth: true,
                    icon: Icons.play_arrow,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SecondaryButton(
                    text: 'Supprimer',
                    onPressed: () {
                      _deleteReport(report);
                    },
                    fullWidth: true,
                    icon: Icons.delete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard({
    required String name,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        _createFromTemplate(name);
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getReportIcon(String type) {
    switch (type) {
      case 'notes':
        return Icons.assignment;
      case 'attendance':
        return Icons.person_off;
      case 'bulletin':
        return Icons.school;
      default:
        return Icons.description;
    }
  }

  String _getFrequencyText(String frequency) {
    switch (frequency) {
      case 'daily':
        return 'Quotidien';
      case 'weekly':
        return 'Hebdomadaire';
      case 'monthly':
        return 'Mensuel';
      case 'quarterly':
        return 'Trimestriel';
      default:
        return frequency;
    }
  }

  void _showCreateReportDialog(BuildContext context) {
    // TODO: Implémenter dialogue de création
  }

  void _editReport(Map<String, dynamic> report) {
    // TODO: Implémenter édition
  }

  void _testReport(Map<String, dynamic> report) {
    // TODO: Implémenter test
  }

  void _deleteReport(Map<String, dynamic> report) {
    // TODO: Implémenter suppression
  }

  void _createFromTemplate(String templateName) {
    // TODO: Implémenter création à partir de template
  }
}