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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Statistics
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Moyenne classe',
                            value: moyenneClasse.toStringAsFixed(1),
                            icon: Icons.school,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Meilleure moyenne',
                            value: meilleureMoyenne.toStringAsFixed(1),
                            icon: Icons.emoji_events,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Bulletins générés',
                      value: _bulletins.length.toString(),
                      icon: Icons.description,
                      color: AppTheme.secondaryColor,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Selection
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sélection du bulletin',
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
                                child: DropdownButtonFormField<String?>(
                                  value: _selectedEtudiant,
                                  decoration: const InputDecoration(
                                    labelText: 'Étudiant',
                                    border: OutlineInputBorder(),
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
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String?>(
                                  value: _selectedAnnee,
                                  decoration: const InputDecoration(
                                    labelText: 'Année scolaire',
                                    border: OutlineInputBorder(),
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Générer tous',
                                  onPressed: () {
                                    // TODO: Générer tous les bulletins
                                  },
                                  icon: Icons.autorenew,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Recalculer',
                                  onPressed: _selectedEtudiant != null
                                      ? () {
                                          // TODO: Recalculer le bulletin
                                        }
                                      : null,
                                  icon: Icons.calculate,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Bulletin Details
                    if (_showDetails && selectedBulletin != null) ...[
                      _buildBulletinHeader(selectedBulletin),
                      const SizedBox(height: 24),
                      
                      // Matières détaillées
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Détail par matière',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ..._detailsBulletins[_selectedEtudiant]!.map((detail) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              detail['matiere'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getNoteColor(detail['note']),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                detail['note'].toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Chip(
                                              label: Text(
                                                'Coef. ${detail['coefficient']}',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                            ),
                                            const SizedBox(width: 8),
                                            Chip(
                                              label: Text(
                                                'Points: ${(detail['note'] * detail['coefficient']).toStringAsFixed(1)}',
                                                style: const TextStyle(fontSize: 12),
                                              ),
                                              backgroundColor: AppTheme.accentColor.withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Appréciation: ${detail['appreciation']}',
                                          style: const TextStyle(
                                            color: AppTheme.textSecondary,
                                            fontStyle: FontStyle.italic,
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
                      
                      const SizedBox(height: 24),
                      
                      // Résumé et classement
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Résumé et classement',
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
                                  child: _buildSummaryItem(
                                    label: 'Moyenne générale',
                                    value: selectedBulletin.moyenneGenerale.toStringAsFixed(2),
                                    color: _getMoyenneColor(selectedBulletin.moyenneGenerale),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildSummaryItem(
                                    label: 'Rang dans la classe',
                                    value: '5ème/32',
                                    color: AppTheme.infoColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSummaryItem(
                                    label: 'Total des points',
                                    value: '452.5',
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildSummaryItem(
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
                      
                      const SizedBox(height: 24),
                      
                      // Appréciations générales
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Appréciations générales',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Élève sérieux et assidu qui fournit un travail régulier. '
                              'Excellents résultats en sciences, particulièrement en mathématiques. '
                              'Continue sur cette voie pour le baccalauréat.',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Signature du professeur principal:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  'M. Diallo, Professeur principal',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: 'Imprimer',
                              onPressed: () {
                                // TODO: Imprimer le bulletin
                              },
                              icon: Icons.print,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimaryButton(
                              text: 'Exporter PDF',
                              onPressed: () {
                                // TODO: Exporter en PDF
                              },
                              icon: Icons.picture_as_pdf,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      SecondaryButton(
                        text: 'Envoyer aux parents',
                        onPressed: () {
                          // TODO: Envoyer aux parents
                        },
                        icon: Icons.send,
                        fullWidth: true,
                      ),
                      
                      const SizedBox(height: 32),
                    ] else if (_selectedEtudiant == null) ...[
                      // Empty State
                      Container(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Icon(
                              Icons.description,
                              size: 80,
                              color: AppTheme.textSecondary.withOpacity(0.3),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Sélectionnez un étudiant',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Choisissez un étudiant pour voir son bulletin scolaire.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 16,
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

  Widget _buildBulletinHeader(Bulletin bulletin) {
    return InfoCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _etudiants[bulletin.etudiantId] ?? 'Étudiant inconnu',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Année scolaire $_selectedAnnee',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getMoyenneColor(bulletin.moyenneGenerale),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  bulletin.moyenneGenerale.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBulletinInfo('Date', '15 Jan 2024'),
              _buildBulletinInfo('Trimestre', '1er Trimestre'),
              _buildBulletinInfo('Statut', 'Validé'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletinInfo(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
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