import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
// TODO: Importer les services d'export
// import 'package:parametragesschool/services/export_service.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  bool _isExporting = false;
  String _selectedFormat = 'pdf';
  final Map<String, bool> _selectedData = {
    'students': true,
    'grades': true,
    'attendance': false,
    'timetable': false,
    'teachers': false,
  };
  // ignore: unused_field
  DateTimeRange? _dateRange;

  // TODO: Remplacer par un vrai ViewModel/Controller

  Future<void> _exportData() async {
    setState(() {
      _isExporting = true;
    });

    // TODO: Implémenter l'export réel
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isExporting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Export ${_selectedFormat.toUpperCase()} terminé'),
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
            const PageHeader(title: 'Export des données'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sélection du format
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Format d\'export',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Choisissez le format de fichier pour l\'export',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildFormatOption(
                                format: 'pdf',
                                label: 'PDF',
                                icon: Icons.picture_as_pdf,
                              ),
                              _buildFormatOption(
                                format: 'excel',
                                label: 'Excel',
                                icon: Icons.table_chart,
                              ),
                              _buildFormatOption(
                                format: 'csv',
                                label: 'CSV',
                                icon: Icons.grid_on,
                              ),
                              _buildFormatOption(
                                format: 'json',
                                label: 'JSON',
                                icon: Icons.code,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sélection des données
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Données à exporter',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Sélectionnez les types de données à inclure dans l\'export',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDataOption(
                            key: 'students',
                            label: 'Liste des étudiants',
                            count: '250 étudiants',
                          ),
                          const Divider(),
                          _buildDataOption(
                            key: 'grades',
                            label: 'Notes et évaluations',
                            count: '1,240 notes',
                          ),
                          const Divider(),
                          _buildDataOption(
                            key: 'attendance',
                            label: 'Absences et présences',
                            count: '85 absences',
                          ),
                          const Divider(),
                          _buildDataOption(
                            key: 'timetable',
                            label: 'Emplois du temps',
                            count: '15 emplois du temps',
                          ),
                          const Divider(),
                          _buildDataOption(
                            key: 'teachers',
                            label: 'Informations enseignants',
                            count: '30 enseignants',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Sélectionner tout',
                                  onPressed: () {
                                    setState(() {
                                      for (var key in _selectedData.keys) {
                                        _selectedData[key] = true;
                                      }
                                    });
                                  },
                                  icon: Icons.check_box,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Désélectionner tout',
                                  onPressed: () {
                                    setState(() {
                                      for (var key in _selectedData.keys) {
                                        _selectedData[key] = false;
                                      }
                                    });
                                  },
                                  icon: Icons.check_box_outline_blank,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Période
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
                          const SizedBox(height: 12),
                          const Text(
                            'Définissez la période des données à exporter',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
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
                                      'Date de début',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // TODO: Implémenter sélection de date
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppTheme.textPrimary,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('01/09/2024'),
                                          Icon(Icons.calendar_today, size: 18),
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
                                      'Date de fin',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // TODO: Implémenter sélection de date
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppTheme.textPrimary,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('31/12/2024'),
                                          Icon(Icons.calendar_today, size: 18),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Toutes les données'),
                            subtitle: const Text('Exporter toutes les données sans filtre de date'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Options avancées
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Options avancées',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Inclure les fichiers joints'),
                            subtitle: const Text('Photos, documents attachés, etc.'),
                            value: false,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Compresser le fichier'),
                            subtitle: const Text('Réduire la taille du fichier exporté'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Chiffrer le fichier'),
                            subtitle: const Text('Protéger l\'export avec un mot de passe'),
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
                    
                    // Bouton d'export
                    if (_isExporting) ...[
                      PrimaryButton(
                        text: 'Export en cours...',
                        onPressed: null,
                        fullWidth: true,
                        icon: Icons.hourglass_bottom,
                      ),
                    ] else ...[
                      PrimaryButton(
                        text: 'Exporter les données',
                        onPressed: _exportData,
                        fullWidth: true,
                        icon: Icons.download,
                      ),
                    ],
                    
                    const SizedBox(height: 16),
                    
                    SecondaryButton(
                      text: 'Programmer un export',
                      onPressed: () {
                        // TODO: Implémenter programmation
                      },
                      fullWidth: true,
                      icon: Icons.schedule,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Historique des exports
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Historique des exports',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Voir l\'historique complet',
                            onPressed: () {
                              // TODO: Naviguer vers historique
                            },
                            fullWidth: true,
                            icon: Icons.history,
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

  Widget _buildFormatOption({
    required String format,
    required String label,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFormat = format;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _selectedFormat == format
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _selectedFormat == format
                ? AppTheme.primaryColor
                : Colors.grey[300]!,
            width: _selectedFormat == format ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: _selectedFormat == format
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataOption({
    required String key,
    required String label,
    required String count,
  }) {
    return CheckboxListTile(
      title: Text(label),
      subtitle: Text(count),
      value: _selectedData[key] ?? false,
      onChanged: (value) {
        setState(() {
          _selectedData[key] = value ?? false;
        });
      },
      activeColor: AppTheme.primaryColor,
    );
  }
}