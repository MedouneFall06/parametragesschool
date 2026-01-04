// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/bulletin_model.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:parametragesschool/models/note_model.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer BulletinViewModel
// TODO: Récupérer bulletins depuis l'API/BDD
// TODO: Générer bulletins automatiquement
// TODO: Gérer états loading/error
// TODO: Ajouter fonctionnalités d'export PDF

class BulletinScreen extends StatefulWidget {
  const BulletinScreen({super.key});

  @override
  State<BulletinScreen> createState() => _BulletinScreenState();
}

class _BulletinScreenState extends State<BulletinScreen> {
  // Données fictives pour l'affichage statique
  final List<Bulletin> _bulletins = [
    Bulletin(
      id: "BUL001",
      etudiantId: "1",
      anneeId: "2023-2024",
      moyenneGenerale: 15.2,
    ),
    Bulletin(
      id: "BUL002",
      etudiantId: "2",
      anneeId: "2023-2024",
      moyenneGenerale: 13.8,
    ),
    Bulletin(
      id: "BUL003",
      etudiantId: "3",
      anneeId: "2023-2024",
      moyenneGenerale: 16.5,
    ),
  ];

  final Map<String, String> _etudiants = {
    "1": "Medoune Fall - Terminale S1",
    "2": "Awa Diop - Terminale S1",
    "3": "Moussa Ndoye - Première L1",
  };

  final Map<String, List<Map<String, dynamic>>> _detailsBulletins = {
    "1": [
      {"matiere": "Mathématiques", "note": 16.0, "coefficient": 4, "appreciation": "Excellent travail"},
      {"matiere": "Physique", "note": 15.5, "coefficient": 3, "appreciation": "Très bon résultats"},
      {"matiere": "Français", "note": 14.0, "coefficient": 3, "appreciation": "Bon niveau"},
      {"matiere": "Anglais", "note": 15.0, "coefficient": 2, "appreciation": "Très bonne maîtrise"},
    ],
    "2": [
      {"matiere": "Mathématiques", "note": 13.0, "coefficient": 4, "appreciation": "Peut mieux faire"},
      {"matiere": "Physique", "note": 12.5, "coefficient": 3, "appreciation": "Efforts à fournir"},
      {"matiere": "Français", "note": 15.0, "coefficient": 3, "appreciation": "Très bon travail"},
      {"matiere": "Anglais", "note": 14.5, "coefficient": 2, "appreciation": "Bon niveau"},
    ],
    "3": [
      {"matiere": "Mathématiques", "note": 18.0, "coefficient": 4, "appreciation": "Exceptionnel"},
      {"matiere": "Physique", "note": 17.5, "coefficient": 3, "appreciation": "Excellent"},
      {"matiere": "Français", "note": 15.5, "coefficient": 3, "appreciation": "Très bon"},
      {"matiere": "Anglais", "note": 16.0, "coefficient": 2, "appreciation": "Excellent"},
    ],
  };

  String? _selectedEtudiant;
  String? _selectedAnnee = "2023-2024";
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    // Calcul des statistiques (à déplacer dans ViewModel)
    final double moyenneClasse = _bulletins.isNotEmpty
        ? _bulletins.map((b) => b.moyenneGenerale).reduce((a, b) => a + b) / _bulletins.length
        : 0.0;

    final double meilleureMoyenne = _bulletins.isNotEmpty
        ? _bulletins.map((b) => b.moyenneGenerale).reduce((a, b) => a > b ? a : b)
        : 0.0;

    final selectedBulletin = _selectedEtudiant != null
        ? _bulletins.firstWhere(
            (b) => b.etudiantId == _selectedEtudiant,
            orElse: () => _bulletins.first,
          )
        : null;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Bulletins scolaires',
              subtitle: 'Suivi des résultats',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  children: [
                    // Statistics
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Moyenne classe',
                          value: moyenneClasse.toStringAsFixed(1),
                          icon: Icons.school,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Meilleure moyenne',
                          value: meilleureMoyenne.toStringAsFixed(1),
                          icon: Icons.emoji_events,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    StatCard(
                      title: 'Bulletins générés',
                      value: _bulletins.length.toString(),
                      icon: Icons.description,
                      color: AppTheme.secondaryColor,
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Selection
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sélection du bulletin',
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
                              DropdownButtonFormField<String?>(
                                value: _selectedEtudiant,
                                decoration: InputDecoration(
                                  labelText: 'Étudiant',
                                  labelStyle: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize)),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Sélectionner un étudiant'),
                                  ),
                                  ..._etudiants.entries.map((entry) {
                                    return DropdownMenuItem(
                                      value: entry.key,
                                      child: Text(entry.value),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedEtudiant = value;
                                    _showDetails = value != null;
                                  });
                                },
                              ),
                              DropdownButtonFormField<String?>(
                                value: _selectedAnnee,
                                decoration: InputDecoration(
                                  labelText: 'Année scolaire',
                                  labelStyle: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize)),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: "2023-2024",
                                    child: Text('2023-2024'),
                                  ),
                                  DropdownMenuItem(
                                    value: "2022-2023",
                                    child: Text('2022-2023'),
                                  ),
                                  DropdownMenuItem(
                                    value: "2021-2022",
                                    child: Text('2021-2022'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnnee = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              SecondaryButton(
                                text: 'Générer tous',
                                onPressed: () {
                                  // TODO: Générer tous les bulletins
                                },
                                icon: Icons.autorenew,
                                fullWidth: true,
                              ),
                              PrimaryButton(
                                text: 'Recalculer',
                                onPressed: _selectedEtudiant != null
                                    ? () {
                                        // TODO: Recalculer le bulletin
                                      }
                                    : null,
                                icon: Icons.calculate,
                                fullWidth: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Bulletin Details
                    if (_showDetails && selectedBulletin != null) ...[
                      _buildBulletinHeader(context, selectedBulletin),
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                      
                      // Matières détaillées
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Détail par matière',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            ..._detailsBulletins[_selectedEtudiant]!.map((detail) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              detail['matiere'],
                                              style: TextStyle(
                                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: AppConstants.widthPercentage(context, AppConstants.cardPadding),
                                                vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getNoteColor(detail['note']),
                                                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                              ),
                                              child: Text(
                                                detail['note'].toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                        Row(
                                          children: [
                                            Chip(
                                              label: Text(
                                                'Coef. ${detail['coefficient']}',
                                                style: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize)),
                                              ),
                                              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                            ),
                                            SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                                            Chip(
                                              label: Text(
                                                'Points: ${(detail['note'] * detail['coefficient']).toStringAsFixed(1)}',
                                                style: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize)),
                                              ),
                                              backgroundColor: AppTheme.accentColor.withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                        Text(
                                          'Appréciation: ${detail['appreciation']}',
                                          style: TextStyle(
                                            color: AppTheme.textSecondary,
                                            fontStyle: FontStyle.italic,
                                            fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                      
                      // Résumé et classement
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Résumé et classement',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSummaryItem(
                                    context: context,
                                    label: 'Moyenne générale',
                                    value: selectedBulletin.moyenneGenerale.toStringAsFixed(2),
                                    color: _getMoyenneColor(selectedBulletin.moyenneGenerale),
                                  ),
                                ),
                                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems)),
                                Expanded(
                                  child: _buildSummaryItem(
                                    context: context,
                                    label: 'Rang dans la classe',
                                    value: '5ème/32',
                                    color: AppTheme.infoColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSummaryItem(
                                    context: context,
                                    label: 'Total des points',
                                    value: '452.5',
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems)),
                                Expanded(
                                  child: _buildSummaryItem(
                                    context: context,
                                    label: 'Mentions',
                                    value: 'Très Bien',
                                    color: AppTheme.successColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                      
                      // Appréciations générales
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Appréciations générales',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            Text(
                              'Élève sérieux et assidu qui fournit un travail régulier. '
                              'Excellents résultats en sciences, particulièrement en mathématiques. '
                              'Continue sur cette voie pour le baccalauréat.',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                height: 1.5,
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            Text(
                              'Signature du professeur principal:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            Container(
                              height: AppConstants.heightPercentage(context, AppConstants.avatarSize),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                              ),
                              child: Center(
                                child: Text(
                                  'M. Diallo, Professeur principal',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppTheme.textSecondary,
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                      
                      // Action Buttons
                      ResponsiveGrid(
                        customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                        children: [
                          SecondaryButton(
                            text: 'Imprimer',
                            onPressed: () {
                              // TODO: Imprimer le bulletin
                            },
                            icon: Icons.print,
                            fullWidth: true,
                          ),
                          PrimaryButton(
                            text: 'Exporter PDF',
                            onPressed: () {
                              // TODO: Exporter en PDF
                            },
                            icon: Icons.picture_as_pdf,
                            fullWidth: true,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                      
                      SecondaryButton(
                        text: 'Envoyer aux parents',
                        onPressed: () {
                          // TODO: Envoyer aux parents
                        },
                        icon: Icons.send,
                        fullWidth: true,
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    ] else if (_selectedEtudiant == null) ...[
                      // Empty State
                      Container(
                        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.description,
                              size: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                              color: AppTheme.textSecondary.withOpacity(0.3),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                            Text(
                              'Sélectionnez un étudiant',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                            Text(
                              'Choisissez un étudiant pour voir son bulletin scolaire.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletinHeader(BuildContext context, Bulletin bulletin) {
    return InfoCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.school,
                  color: Colors.white,
                  size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
                ),
              ),
              SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _etudiants[bulletin.etudiantId] ?? 'Étudiant inconnu',
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    Text(
                      'Année scolaire $_selectedAnnee',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.widthPercentage(context, AppConstants.cardPadding),
                  vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                ),
                decoration: BoxDecoration(
                  color: _getMoyenneColor(bulletin.moyenneGenerale),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Text(
                  bulletin.moyenneGenerale.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          const Divider(),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBulletinInfo(context, 'Date', '15 Jan 2024'),
              _buildBulletinInfo(context, 'Trimestre', '1er Trimestre'),
              _buildBulletinInfo(context, 'Statut', 'Validé'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletinInfo(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
          ),
        ),
        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem({
    required BuildContext context,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getNoteColor(double note) {
    if (note >= 16) return AppTheme.successColor;
    if (note >= 14) return AppTheme.accentColor;
    if (note >= 10) return AppTheme.infoColor;
    return AppTheme.errorColor;
  }

  Color _getMoyenneColor(double moyenne) {
    if (moyenne >= 16) return AppTheme.successColor;
    if (moyenne >= 14) return Colors.green;
    if (moyenne >= 12) return AppTheme.accentColor;
    if (moyenne >= 10) return AppTheme.infoColor;
    return AppTheme.errorColor;
  }
}
