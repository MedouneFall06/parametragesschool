import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nouveau rapport
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Créer un nouveau rapport',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Rapports programmés
                    Text(
                      'Rapports programmés',
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    ..._scheduledReports.map((report) {
                      return Column(
                        children: [
                          _buildReportCard(context, report),
                          if (_scheduledReports.indexOf(report) < _scheduledReports.length - 1)
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                        ],
                      );
                    }).toList(),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Modèles de rapports
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Modèles disponibles',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Choisissez un modèle prédéfini pour créer rapidement un rapport',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              _buildTemplateCard(
                                context: context,
                                name: 'Rapport de notes',
                                icon: Icons.assignment,
                                color: AppTheme.primaryColor,
                              ),
                              _buildTemplateCard(
                                context: context,
                                name: 'Rapport d\'absences',
                                icon: Icons.person_off,
                                color: AppTheme.accentColor,
                              ),
                              _buildTemplateCard(
                                context: context,
                                name: 'Bulletin scolaire',
                                icon: Icons.school,
                                color: AppTheme.secondaryColor,
                              ),
                              _buildTemplateCard(
                                context: context,
                                name: 'Statistiques de classe',
                                icon: Icons.assessment,
                                color: AppTheme.infoColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Paramètres d'envoi
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paramètres d\'envoi',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SwitchListTile(
                            title: Text('Notifications par email',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            subtitle: Text('Envoyer des notifications quand un rapport est généré',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
                            title: Text('Archive automatique',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            subtitle: Text('Conserver une copie de tous les rapports envoyés',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
                            title: Text('Validation avant envoi',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            subtitle: Text('Requérir une validation manuelle avant l\'envoi',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
                    
                    // Actions globales
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        PrimaryButton(
                          text: 'Tester tous les rapports',
                          onPressed: () {
                            // TODO: Tester
                          },
                          icon: Icons.play_arrow,
                          fullWidth: true,
                        ),
                        SecondaryButton(
                          text: 'Exporter la configuration',
                          onPressed: () {
                            // TODO: Exporter
                          },
                          icon: Icons.download,
                          fullWidth: true,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    SecondaryButton(
                      text: 'Historique des rapports envoyés',
                      onPressed: () {
                        // TODO: Naviguer vers historique
                      },
                      fullWidth: true,
                      icon: Icons.history,
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

  Widget _buildReportCard(BuildContext context, Map<String, dynamic> report) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
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
                        style: TextStyle(
                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                      Row(
                        children: [
                          Icon(
                            _getReportIcon(report['type']),
                            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
                            color: AppTheme.textSecondary,
                          ),
                          SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            _getFrequencyText(report['frequency']),
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Row(
              children: [
                Icon(Icons.email, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize), color: AppTheme.textSecondary),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Expanded(
                  child: Text(
                    'Destinataires: ${(report['recipients'] as List).join(', ')}',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (report['lastSent'] != null) ...[
              SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
              Row(
                children: [
                  Icon(Icons.access_time, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize), color: AppTheme.textSecondary),
                  SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                  Text(
                    'Dernier envoi: ${report['lastSent']}',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            ResponsiveGrid(
              customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
              children: [
                SecondaryButton(
                  text: 'Modifier',
                  onPressed: () {
                    _editReport(report);
                  },
                  fullWidth: true,
                  icon: Icons.edit,
                ),
                SecondaryButton(
                  text: 'Tester',
                  onPressed: () {
                    _testReport(report);
                  },
                  fullWidth: true,
                  icon: Icons.play_arrow,
                ),
                SecondaryButton(
                  text: 'Supprimer',
                  onPressed: () {
                    _deleteReport(report);
                  },
                  fullWidth: true,
                  icon: Icons.delete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard({
    required BuildContext context,
    required String name,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        _createFromTemplate(name);
      },
      child: Container(
        width: AppConstants.widthPercentage(context, AppConstants.minCardWidth),
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
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
