import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
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
                          Text(
                            'Type d\'archive',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Wrap(
                            spacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                            runSpacing: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
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
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Année académique',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Archive Statistics
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        _buildArchiveStat(
                          context: context,
                          label: 'Documents archivés',
                          value: '1,245',
                          icon: Icons.archive,
                        ),
                        _buildArchiveStat(
                          context: context,
                          label: 'Espace utilisé',
                          value: '4.2 GB',
                          icon: Icons.storage,
                        ),
                        _buildArchiveStat(
                          context: context,
                          label: 'Années disponibles',
                          value: '4',
                          icon: Icons.history,
                        ),
                        _buildArchiveStat(
                          context: context,
                          label: 'Dernière sauvegarde',
                          value: 'Hier',
                          icon: Icons.backup,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
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
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                '45 éléments',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          // TODO: Remplacer par ListView.builder
                          _buildArchiveItem(
                            context: context,
                            title: 'Promotion Terminale S 2023',
                            type: 'classe',
                            date: 'Juin 2023',
                            size: '45 MB',
                          ),
                          const Divider(),
                          _buildArchiveItem(
                            context: context,
                            title: 'Notes trimestre 3 - 2023',
                            type: 'notes',
                            date: 'Mai 2023',
                            size: '12 MB',
                          ),
                          const Divider(),
                          _buildArchiveItem(
                            context: context,
                            title: 'Liste élèves diplômés',
                            type: 'document',
                            date: 'Juillet 2023',
                            size: '8 MB',
                          ),
                          const Divider(),
                          _buildArchiveItem(
                            context: context,
                            title: 'Évaluations enseignants',
                            type: 'évaluation',
                            date: 'Avril 2023',
                            size: '25 MB',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Archive Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Actions d\'archivage',
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
                                text: 'Archiver l\'année',
                                onPressed: () {
                                  _showArchiveConfirmation(context);
                                },
                                icon: Icons.archive,
                                fullWidth: true,
                              ),
                              PrimaryButton(
                                text: 'Restaurer',
                                onPressed: () {
                                  // TODO: Restaurer archive
                                },
                                icon: Icons.restore,
                                fullWidth: true,
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Storage Analysis
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Analyse du stockage',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildStorageUsage(
                            context: context,
                            label: 'Documents',
                            usage: 45,
                            size: '2.1 GB',
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildStorageUsage(
                            context: context,
                            label: 'Images',
                            usage: 30,
                            size: '1.4 GB',
                            color: AppTheme.accentColor,
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildStorageUsage(
                            context: context,
                            label: 'Base de données',
                            usage: 20,
                            size: '0.9 GB',
                            color: AppTheme.secondaryColor,
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildStorageUsage(
                            context: context,
                            label: 'Autres',
                            usage: 5,
                            size: '0.2 GB',
                            color: AppTheme.warningColor,
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total: 4.6 GB / 10 GB',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                ),
                              ),
                              Text(
                                '46% utilisé',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Export Options
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Options d\'export',
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
                              _buildExportOption(
                                context: context,
                                icon: Icons.cloud_download,
                                label: 'Cloud',
                                onTap: () {
                                  // TODO: Exporter vers cloud
                                },
                              ),
                              _buildExportOption(
                                context: context,
                                icon: Icons.sd_card,
                                label: 'Support externe',
                                onTap: () {
                                  // TODO: Exporter vers support externe
                                },
                              ),
                              _buildExportOption(
                                context: context,
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Retention Policy
                    Container(
                      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                      decoration: BoxDecoration(
                        color: AppTheme.infoColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        border: Border.all(color: AppTheme.infoColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info, color: AppTheme.infoColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                          SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Politique de conservation',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  ),
                                ),
                                SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                Text(
                                  'Les archives sont conservées pendant 5 ans conformément à la réglementation.',
                                  style: TextStyle(
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Advanced Archive Management
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        SecondaryButton(
                          text: 'Configurer automatisation',
                          onPressed: () {
                            // TODO: Configurer automatisation
                          },
                          icon: Icons.settings,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Rapport d\'archivage',
                          onPressed: () {
                            // TODO: Générer rapport
                          },
                          icon: Icons.assessment,
                          fullWidth: true,
                        ),
                      ],
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

  Widget _buildArchiveStat({
    required BuildContext context,
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: AppConstants.lightShadowBlur,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
            height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(AppConstants.semiTransparentOpacity),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
          ),
          SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    color: AppTheme.textSecondary,
                  ),
                ),
                SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
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
    required BuildContext context,
    required String title,
    required String type,
    required String date,
    required String size,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(AppConstants.semiTransparentOpacity),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Icon(Icons.archive, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type: $type • Date: $date',
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
            ),
          ),
          Text(
            'Taille: $size',
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
            ),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.download, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
            onPressed: () {
              // TODO: Télécharger archive
            },
          ),
          IconButton(
            icon: Icon(Icons.preview, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
            onPressed: () {
              // TODO: Prévisualiser
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStorageUsage({
    required BuildContext context,
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
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              ),
            ),
            Text(
              size,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              ),
            ),
          ],
        ),
        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
        Stack(
          children: [
            Container(
              height: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
            Container(
              height: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
              width: MediaQuery.of(context).size.width * (usage / 100) * 0.8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
          ],
        ),
        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
        Text(
          '$usage% du stockage total',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildExportOption({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(AppConstants.semiTransparentOpacity),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.iconSize)),
              SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
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
