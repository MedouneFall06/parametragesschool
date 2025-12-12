import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  String _selectedArchiveType = 'students';
  String _selectedYear = '2023-2024';
  final List<String> _archiveTypes = ['students', 'teachers', 'classes', 'grades', 'documents'];
  final Map<String, String> _archiveTypeLabels = {
    'students': 'Élèves',
    'teachers': 'Enseignants',
    'classes': 'Classes',
    'grades': 'Notes',
    'documents': 'Documents',
  };
  final List<String> _academicYears = ['2023-2024', '2022-2023', '2021-2022', '2020-2021'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Archivage',
              subtitle: 'Gestion des archives historiques',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter ArchiveViewModel
                    // TODO: Connecter à l'API archivage
                    
                    // Archive Type Selection
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Type d\'archive',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: _archiveTypes.map((type) {
                              return ChoiceChip(
                                label: Text(_archiveTypeLabels[type] ?? type),
                                selected: _selectedArchiveType == type,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedArchiveType = type;
                                  });
                                },
                                selectedColor: AppTheme.primaryColor,
                                labelStyle: TextStyle(
                                  color: _selectedArchiveType == type
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Année académique',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedYear,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: _academicYears.map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Archive Statistics
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _buildArchiveStat(
                          label: 'Documents archivés',
                          value: '1,245',
                          icon: Icons.archive,
                        ),
                        _buildArchiveStat(
                          label: 'Espace utilisé',
                          value: '4.2 GB',
                          icon: Icons.storage,
                        ),
                        _buildArchiveStat(
                          label: 'Années disponibles',
                          value: '4',
                          icon: Icons.history,
                        ),
                        _buildArchiveStat(
                          label: 'Dernière sauvegarde',
                          value: 'Hier',
                          icon: Icons.backup,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Archived Items List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Archives ${_archiveTypeLabels[_selectedArchiveType]} ($_selectedYear)',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                '45 éléments',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildArchiveItem(
                            title: 'Promotion Terminale S 2023',
                            type: 'classe',
                            date: 'Juin 2023',
                            size: '45 MB',
                          ),
                          const Divider(),
                          _buildArchiveItem(
                            title: 'Notes trimestre 3 - 2023',
                            type: 'notes',
                            date: 'Mai 2023',
                            size: '12 MB',
                          ),
                          const Divider(),
                          _buildArchiveItem(
                            title: 'Liste élèves diplômés',
                            type: 'document',
                            date: 'Juillet 2023',
                            size: '8 MB',
                          ),
                          const Divider(),
                          _buildArchiveItem(
                            title: 'Évaluations enseignants',
                            type: 'évaluation',
                            date: 'Avril 2023',
                            size: '25 MB',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Archive Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actions d\'archivage',
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
                                child: SecondaryButton(
                                  text: 'Archiver l\'année',
                                  onPressed: () {
                                    _showArchiveConfirmation(context);
                                  },
                                  icon: Icons.archive,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Restaurer',
                                  onPressed: () {
                                    // TODO: Restaurer archive
                                  },
                                  icon: Icons.restore,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          PrimaryButton(
                            text: 'Nettoyer les archives',
                            onPressed: () {
                              _showCleanupDialog(context);
                            },
                            fullWidth: true,
                            icon: Icons.cleaning_services,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Storage Analysis
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Analyse du stockage',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildStorageUsage(
                            label: 'Documents',
                            usage: 45,
                            size: '2.1 GB',
                            color: AppTheme.primaryColor,
                          ),
                          const SizedBox(height: 12),
                          _buildStorageUsage(
                            label: 'Images',
                            usage: 30,
                            size: '1.4 GB',
                            color: AppTheme.accentColor,
                          ),
                          const SizedBox(height: 12),
                          _buildStorageUsage(
                            label: 'Base de données',
                            usage: 20,
                            size: '0.9 GB',
                            color: AppTheme.secondaryColor,
                          ),
                          const SizedBox(height: 12),
                          _buildStorageUsage(
                            label: 'Autres',
                            usage: 5,
                            size: '0.2 GB',
                            color: AppTheme.warningColor,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total: 4.6 GB / 10 GB',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '46% utilisé',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
                                icon: Icons.cloud_download,
                                label: 'Cloud',
                                onTap: () {
                                  // TODO: Exporter vers cloud
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildExportOption(
                                icon: Icons.sd_card,
                                label: 'Support externe',
                                onTap: () {
                                  // TODO: Exporter vers support externe
                                },
                              ),
                              const SizedBox(width: 12),
                              _buildExportOption(
                                icon: Icons.print,
                                label: 'Impression',
                                onTap: () {
                                  // TODO: Imprimer archives
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Retention Policy
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.infoColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.infoColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: AppTheme.infoColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Politique de conservation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Les archives sont conservées pendant 5 ans conformément à la réglementation.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Advanced Archive Management
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Configurer automatisation',
                            onPressed: () {
                              // TODO: Configurer automatisation
                            },
                            icon: Icons.settings,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Rapport d\'archivage',
                            onPressed: () {
                              // TODO: Générer rapport
                            },
                            icon: Icons.assessment,
                          ),
                        ),
                      ],
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

  Widget _buildArchiveStat({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchiveItem({
    required String title,
    required String type,
    required String date,
    required String size,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.archive, color: AppTheme.primaryColor),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Type: $type • Date: $date'),
          Text('Taille: $size'),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.download, size: 20),
            onPressed: () {
              // TODO: Télécharger archive
            },
          ),
          IconButton(
            icon: const Icon(Icons.preview, size: 20),
            onPressed: () {
              // TODO: Prévisualiser
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStorageUsage({
    required String label,
    required int usage,
    required String size,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              size,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 8,
              width: MediaQuery.of(context).size.width * (usage / 100) * 0.8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$usage% du stockage total',
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
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

  void _showArchiveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Archiver l\'année scolaire'),
        content: Text(
          'Cette action va archiver toutes les données de l\'année $_selectedYear. '
          'Les données archivées seront toujours accessibles mais ne pourront plus être modifiées. '
          'Êtes-vous sûr de vouloir continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Archiver',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Archivage de l\'année $_selectedYear en cours...'),
                ),
              );
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  void _showCleanupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nettoyer les archives'),
        content: const Text(
          'Cette action va supprimer définitivement les archives de plus de 5 ans '
          'pour libérer de l\'espace de stockage. Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Nettoyer',
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Nettoyage des archives en cours...'),
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