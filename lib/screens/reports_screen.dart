import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

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
                padding: const EdgeInsets.all(16),
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
                          const Text(
                            'Type de rapport',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
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
                    
                    const SizedBox(height: 24),
                    
                    // Date Range
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Période',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Début',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                          const Icon(Icons.calendar_today, size: 18),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Fin',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                          const Icon(Icons.calendar_today, size: 18),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
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
                    
                    const SizedBox(height: 24),
                    
                    // Report Preview
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Aperçu du rapport',
                                style: TextStyle(
                                  fontSize: 18,
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
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.auto_graph, size: 50, color: Colors.grey),
                                  SizedBox(height: 12),
                                  Text(
                                    'Graphique du rapport',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Les données s\'afficheront ici après génération',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                    
                    const SizedBox(height: 24),
                    
                    // Export Options
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Options d\'export',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildExportOption(
                                icon: Icons.picture_as_pdf,
                                label: 'PDF',
                                onTap: () {
                                  // TODO: Exporter PDF
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildExportOption(
                                icon: Icons.table_chart,
                                label: 'Excel',
                                onTap: () {
                                  // TODO: Exporter Excel
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildExportOption(
                                icon: Icons.image,
                                label: 'Image',
                                onTap: () {
                                  // TODO: Exporter Image
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
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
                    
                    const SizedBox(height: 32),
                    
                    // Saved Reports
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Rapports sauvegardés',
                                style: TextStyle(
                                  fontSize: 18,
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
                          const SizedBox(height: 16),
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

  Widget _buildStatRow({
    required String label,
    required String value,
    required String change,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                change,
                style: const TextStyle(
                  fontSize: 12,
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 30),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.description, color: AppTheme.primaryColor),
      ),
      title: Text(name),
      subtitle: Text('$type • $date'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.download, size: 20),
            onPressed: () {
              // TODO: Télécharger
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20, color: AppTheme.errorColor),
            onPressed: () {
              // TODO: Supprimer
            },
          ),
        ],
      ),
    );
  }
}