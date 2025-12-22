import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:go_router/go_router.dart';

class EtudiantDetailScreen extends StatelessWidget {
  final Etudiant etudiant;
  final String? nomClasse;

  const EtudiantDetailScreen({
    super.key,
    required this.etudiant,
    this.nomClasse,
  });

  @override
  Widget build(BuildContext context) {
    // Données fictives pour l'affichage statique
    final Map<String, dynamic> studentStats = {
      'moyenne': 14.5,
      'absences': 3,
      'retards': 2,
      'notesCount': 15,
    };

    final List<Map<String, dynamic>> recentNotes = [
      {'matiere': 'Mathématiques', 'note': 16.0, 'date': '2024-01-15'},
      {'matiere': 'Physique', 'note': 13.5, 'date': '2024-01-10'},
      {'matiere': 'Français', 'note': 15.0, 'date': '2024-01-05'},
    ];

    final List<Map<String, dynamic>> absences = [
      {'date': '2024-01-12', 'motif': 'Maladie', 'justifie': true},
      {'date': '2024-01-08', 'motif': 'Rendez-vous médical', 'justifie': true},
      {'date': '2024-01-03', 'motif': 'Absence non justifiée', 'justifie': false},
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Détail étudiant',
              subtitle: 'Informations complètes',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile Header
                    InfoCard(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: _getAvatarColor(etudiant.id),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                _getInitials(etudiant.prenom, etudiant.nom),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${etudiant.prenom} ${etudiant.nom}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            etudiant.matricule,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              nomClasse ?? 'Classe non spécifiée',
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Moyenne',
                            value: studentStats['moyenne'].toString(),
                            icon: Icons.assessment,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Absences',
                            value: studentStats['absences'].toString(),
                            icon: Icons.person_off,
                            color: AppTheme.warningColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Retards',
                            value: studentStats['retards'].toString(),
                            icon: Icons.schedule,
                            color: AppTheme.infoColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Notes',
                            value: studentStats['notesCount'].toString(),
                            icon: Icons.grade,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Personal Information
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informations personnelles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoItem(
                            icon: Icons.badge,
                            label: 'Matricule',
                            value: etudiant.matricule,
                          ),
                          const Divider(),
                          _buildInfoItem(
                            icon: Icons.school,
                            label: 'Classe',
                            value: nomClasse ?? 'Non spécifiée',
                          ),
                          const Divider(),
                          _buildInfoItem(
                            icon: Icons.family_restroom,
                            label: 'Parent lié',
                            value: etudiant.parentId != null ? 'Oui (ID: ${etudiant.parentId})' : 'Non',
                          ),
                          const Divider(),
                          _buildInfoItem(
                            icon: Icons.calendar_today,
                            label: 'Date d\'inscription',
                            value: '15 Sept 2023',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Recent Notes
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Notes récentes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed(
                                    'notes',
                                    extra: {'etudiantId': etudiant.id},
                                  );
                                },
                                child: const Text('Voir tout'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...recentNotes.map((note) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      note['matiere'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getNoteColor(note['note']),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      note['note'].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    note['date'],
                                    style: const TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Absences
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Absences récentes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.pushNamed(
                                    'absences',
                                    extra: {'etudiantId': etudiant.id},
                                  );
                                },
                                child: const Text('Voir tout'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...absences.map((absence) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          absence['date'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          absence['motif'],
                                          style: const TextStyle(
                                            color: AppTheme.textSecondary,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: absence['justifie']
                                          ? AppTheme.successColor.withOpacity(0.1)
                                          : AppTheme.errorColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: absence['justifie']
                                            ? AppTheme.successColor
                                            : AppTheme.errorColor,
                                      ),
                                    ),
                                    child: Text(
                                      absence['justifie'] ? 'Justifiée' : 'Non justifiée',
                                      style: TextStyle(
                                        color: absence['justifie']
                                            ? AppTheme.successColor
                                            : AppTheme.errorColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Modifier',
                            onPressed: () {
                              context.pushNamed(
                                'etudiant-edit',
                                extra: {  // CHANGER arguments en extra
                                  'etudiant': etudiant,
                                },
                              );
                            },
                            icon: Icons.edit,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Ajouter une note',
                            onPressed: () {
                              // TODO: Créer une route '/note-create' dans router.dart
                              context.pushNamed(
                                'note-create',
                                extra: {
                                  'etudiantId': etudiant.id,
                                  'etudiantNom': '${etudiant.prenom} ${etudiant.nom}',
                                },
                              );
                            },
                            icon: Icons.add,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Voir le bulletin',
                            onPressed: () {
                              context.pushNamed(
                                'bulletin',
                                extra: {
                                  'etudiantId': etudiant.id,
                                  'etudiantNom': '${etudiant.prenom} ${etudiant.nom}',
                                },
                              );
                            },
                            icon: Icons.description,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SecondaryButton(
                            text: 'Ajouter absence',
                            onPressed: () {
                              // TODO: Créer une route '/absence-create' dans router.dart
                              context.pushNamed(
                                'absence-create',
                                extra: {
                                  'etudiantId': etudiant.id,
                                  'etudiantNom': '${etudiant.prenom} ${etudiant.nom}',
                                },
                              );
                            },
                            icon: Icons.person_add_disabled,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    SecondaryButton(
                      text: 'Contacter parent',
                      onPressed: () {
                        // TODO: Contacter parent
                        if (etudiant.parentId != null) {
                          // Naviguer vers écran de messagerie
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Aucun parent associé à cet étudiant'),
                            ),
                          );
                        }
                      },
                      icon: Icons.message,
                      fullWidth: true,
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

  String _getInitials(String prenom, String nom) {
    String initials = "";
    if (prenom.isNotEmpty) initials += prenom[0];
    if (nom.isNotEmpty) initials += nom[0];
    return initials;
  }

  Color _getAvatarColor(String id) {
    final hash = id.hashCode;
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
    ];
    return colors[hash.abs() % colors.length];
  }

  Color _getNoteColor(double note) {
    if (note >= 16) return AppTheme.successColor;
    if (note >= 14) return AppTheme.accentColor;
    if (note >= 10) return AppTheme.infoColor;
    return AppTheme.errorColor;
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}