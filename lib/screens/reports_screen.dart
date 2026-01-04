import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

// Constantes modifiables pour le responsive design
class ReportsScreenConstants {
  // Padding général
  static const double paddingAll = 0.02;
  static const double paddingHorizontal = 0.02;
  static const double paddingVertical = 0.013;
  static const double paddingBetweenItems = 0.02;
  static const double paddingBetweenStats = 0.02;
  static const double paddingBetweenCards = 0.01;
  
  // Statistiques
  static const double statTitleFontSize = 0.025;
  static const double statIconSize = 0.04;
  static const double statValueFontSize = 0.045;
  static const double statSpacing = 0.015;
  
  // Cartes de rapports
  static const double reportCardPadding = 0.02;
  static const double reportAvatarSize = 0.08;
  static const double reportTitleFontSize = 0.025;
  static const double reportSubtitleFontSize = 0.018;
  static const double reportInfoFontSize = 0.016;
  static const double reportIconSize = 0.025;
  
  // Recherche et filtres
  static const double filterLabelFontSize = 0.025;
  static const double filterContentPaddingHorizontal = 0.02;
  static const double filterContentPaddingVertical = 0.015;
  static const double searchHintFontSize = 0.018;
  
  // Espacements
  static const double spacingSmall = 0.003;
  static const double spacingMedium = 0.006;
  static const double spacingLarge = 0.01;
  static const double spacingExtraLarge = 0.015;
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReportType = 'academic';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  final List<String> _reportTypes = [
    'academic',
    'attendance',
    'financial',
    'performance',
    'user_activity',
  ];

  final Map<String, String> _reportTypeLabels = {
    'academic': 'Académique',
    'attendance': 'Présences',
    'financial': 'Financier',
    'performance': 'Performance',
    'user_activity': 'Activité utilisateurs',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Rapports & Statistiques',
              subtitle: 'Analyse des données scolaires',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * ReportsScreenConstants.paddingAll),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter ReportsViewModel
                    // TODO: Connecter à l'API rapports
                    
                    // Report Type Selection
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type de rapport',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.statTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          Wrap(
                            spacing: MediaQuery.of(context).size.width * ReportsScreenConstants.spacingSmall,
                            runSpacing: MediaQuery.of(context).size.width * ReportsScreenConstants.spacingSmall,
                            children: _reportTypes.map((type) {
                              return ChoiceChip(
                                label: Text(_reportTypeLabels[type] ?? type),
                                selected: _selectedReportType == type,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedReportType = type;
                                  });
                                },
                                selectedColor: AppTheme.primaryColor,
                                labelStyle: TextStyle(
                                  color: _selectedReportType == type
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingExtraLarge),
                    
                    // Date Range
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Période',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.statTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          ResponsiveGrid(
                            customSpacing: MediaQuery.of(context).size.width * ReportsScreenConstants.paddingBetweenItems,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Début',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportInfoFontSize,
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: _startDate,
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _startDate = picked;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppTheme.textPrimary,
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                                        ),
                                        Icon(Icons.calendar_today, size: MediaQuery.of(context).size.width * ReportsScreenConstants.reportIconSize),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fin',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportInfoFontSize,
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: _endDate,
                                        firstDate: _startDate,
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _endDate = picked;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: AppTheme.textPrimary,
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                                        ),
                                        Icon(Icons.calendar_today, size: MediaQuery.of(context).size.width * ReportsScreenConstants.reportIconSize),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          SecondaryButton(
                            text: 'Derniers 30 jours',
                            onPressed: () {
                              setState(() {
                                _endDate = DateTime.now();
                                _startDate = DateTime.now().subtract(const Duration(days: 30));
                              });
                            },
                            fullWidth: true,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingExtraLarge),
                    
                    // Report Preview
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Aperçu du rapport',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.statTitleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Générer',
                                onPressed: () {
                                  // TODO: Générer rapport
                                },
                                fullWidth: false,
                                icon: Icons.bar_chart,
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.auto_graph, size: MediaQuery.of(context).size.width * 0.15, color: Colors.grey),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  Text(
                                    'Graphique du rapport',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                  Text(
                                    'Les données s\'afficheront ici après génération',
                                    style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportInfoFontSize),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          // TODO: Remplacer par données dynamiques
                          _buildStatRow(
                            label: 'Nombre d\'étudiants',
                            value: '320',
                            change: '+12% vs période précédente',
                          ),
                          const Divider(),
                          _buildStatRow(
                            label: 'Moyenne générale',
                            value: '14.2/20',
                            change: '+0.5 points',
                          ),
                          const Divider(),
                          _buildStatRow(
                            label: 'Taux de présence',
                            value: '94%',
                            change: '+2% vs période précédente',
                          ),
                          const Divider(),
                          _buildStatRow(
                            label: 'Activité enseignants',
                            value: '85%',
                            change: '+5% cette période',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingExtraLarge),
                    
                    // Export Options
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Options d\'export',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.statTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          ResponsiveGrid(
                            customSpacing: MediaQuery.of(context).size.width * ReportsScreenConstants.paddingBetweenItems,
                            children: [
                              _buildExportOption(
                                icon: Icons.picture_as_pdf,
                                label: 'PDF',
                                onTap: () {
                                  // TODO: Exporter PDF
                                },
                              ),
                              _buildExportOption(
                                icon: Icons.table_chart,
                                label: 'Excel',
                                onTap: () {
                                  // TODO: Exporter Excel
                                },
                              ),
                              _buildExportOption(
                                icon: Icons.image,
                                label: 'Image',
                                onTap: () {
                                  // TODO: Exporter Image
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          PrimaryButton(
                            text: 'Exporter le rapport complet',
                            onPressed: () {
                              // TODO: Exporter rapport complet
                            },
                            fullWidth: true,
                            icon: Icons.download,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingExtraLarge),
                    
                    // Saved Reports
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rapports sauvegardés',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.statTitleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SecondaryButton(
                                text: 'Nouveau modèle',
                                onPressed: () {
                                  // TODO: Créer modèle
                                },
                                fullWidth: false,
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
                          // TODO: Remplacer par ListView.builder
                          _buildSavedReport(
                            name: 'Rapport mensuel académique',
                            date: 'Janvier 2024',
                            type: 'Académique',
                          ),
                          const Divider(),
                          _buildSavedReport(
                            name: 'Analyse des présences',
                            date: 'Décembre 2023',
                            type: 'Présences',
                          ),
                          const Divider(),
                          _buildSavedReport(
                            name: 'Performance enseignants',
                            date: 'Novembre 2023',
                            type: 'Performance',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingExtraLarge),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow({
    required String label,
    required String value,
    required String change,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportSubtitleFontSize,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportTitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                change,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportInfoFontSize,
                  color: AppTheme.accentColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * ReportsScreenConstants.reportCardPadding),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: MediaQuery.of(context).size.width * ReportsScreenConstants.reportIconSize),
              SizedBox(height: MediaQuery.of(context).size.height * ReportsScreenConstants.spacingSmall),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * ReportsScreenConstants.reportSubtitleFontSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavedReport({
    required String name,
    required String date,
    required String type,
  }) {
    return ListTile(
      leading: Container(
        width: MediaQuery.of(context).size.width * ReportsScreenConstants.reportAvatarSize,
        height: MediaQuery.of(context).size.width * ReportsScreenConstants.reportAvatarSize,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.description, color: AppTheme.primaryColor, size: MediaQuery.of(context).size.width * ReportsScreenConstants.reportIconSize),
      ),
      title: Text(name),
      subtitle: Text('$type • $date'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.download, size: MediaQuery.of(context).size.width * ReportsScreenConstants.reportIconSize),
            onPressed: () {
              // TODO: Télécharger
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, size: MediaQuery.of(context).size.width * ReportsScreenConstants.reportIconSize, color: AppTheme.errorColor),
            onPressed: () {
              // TODO: Supprimer
            },
          ),
        ],
      ),
    );
  }
}
