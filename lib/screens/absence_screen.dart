import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/absence_model.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer AbsenceViewModel
// TODO: Récupérer absences depuis l'API/BDD
// TODO: Implémenter CRUD des absences
// TODO: Gérer états loading/error
// TODO: Ajouter notifications automatiques

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({super.key});

  @override
  State<AbsenceScreen> createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen> {
  // Données fictives pour l'affichage statique
  final List<Absence> _absences = [
    Absence(
      id: "1",
      etudiantId: "1",
      date: DateTime(2024, 1, 15),
      motif: "Maladie",
      justifie: true,
    ),
    Absence(
      id: "2",
      etudiantId: "2",
      date: DateTime(2024, 1, 14),
      motif: "Rendez-vous médical",
      justifie: true,
    ),
    Absence(
      id: "3",
      etudiantId: "3",
      date: DateTime(2024, 1, 13),
      motif: "Absence non justifiée",
      justifie: false,
    ),
    Absence(
      id: "4",
      etudiantId: "1",
      date: DateTime(2024, 1, 12),
      motif: "Problèmes familiaux",
      justifie: true,
    ),
    Absence(
      id: "5",
      etudiantId: "4",
      date: DateTime(2024, 1, 11),
      motif: "Retard",
      justifie: false,
    ),
  ];

  final Map<String, String> _etudiants = {
    "1": "Medoune Fall",
    "2": "Awa Diop",
    "3": "Moussa Ndoye",
    "4": "Fatou Sarr",
  };

  final Map<String, String> _classes = {
    "1": "Terminale S1",
    "2": "Terminale S1",
    "3": "Première L1",
    "4": "Terminale S1",
  };

  String? _selectedEtudiant;
  String? _selectedStatut;
  DateTimeRange? _dateRange;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filtrage local (à déplacer dans ViewModel)
    List<Absence> filteredAbsences = _absences.where((absence) {
      bool matchesEtudiant = _selectedEtudiant == null ||
          absence.etudiantId == _selectedEtudiant;
      
      bool matchesStatut = _selectedStatut == null ||
          (_selectedStatut == 'justified' && absence.justifie) ||
          (_selectedStatut == 'unjustified' && !absence.justifie);
      
      bool matchesDate = _dateRange == null ||
          (absence.date.isAfter(_dateRange!.start) &&
           absence.date.isBefore(_dateRange!.end));
      
      bool matchesSearch = _searchQuery.isEmpty ||
          _etudiants[absence.etudiantId]!.toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          absence.motif.toLowerCase().contains(_searchQuery.toLowerCase());
      
      return matchesEtudiant && matchesStatut && matchesDate && matchesSearch;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final int totalAbsences = _absences.length;
    final int absencesJustifiees = _absences.where((a) => a.justifie).length;
    final int absencesNonJustifiees = totalAbsences - absencesJustifiees;
    final double tauxAbsentisme = totalAbsences > 0
        ? (totalAbsences / _etudiants.length) * 100
        : 0.0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des absences',
              subtitle: 'Suivi des présences',
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
                          title: 'Absences totales',
                          value: totalAbsences.toString(),
                          icon: Icons.person_off,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Justifiées',
                          value: absencesJustifiees.toString(),
                          icon: Icons.check_circle,
                          color: AppTheme.successColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Non justifiées',
                          value: absencesNonJustifiees.toString(),
                          icon: Icons.cancel,
                          color: AppTheme.errorColor,
                        ),
                        StatCard(
                          title: 'Taux d\'absentisme',
                          value: '${tauxAbsentisme.toStringAsFixed(1)}%',
                          icon: Icons.trending_up,
                          color: AppTheme.warningColor,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filtres',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          // Search Bar
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher par étudiant ou motif...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          _searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Étudiant',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  DropdownButtonFormField<String?>(
                                    value: _selectedEtudiant,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    items: [
                                      const DropdownMenuItem(
                                        value: null,
                                        child: Text('Tous les étudiants'),
                                      ),
                                      ..._etudiants.entries.map((entry) {
                                        return DropdownMenuItem(
                                          value: entry.key,
                                          child: Text('${entry.value} - ${_classes[entry.key]}'),
                                        );
                                      }).toList(),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedEtudiant = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Statut',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  DropdownButtonFormField<String?>(
                                    value: _selectedStatut,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    items: [
                                      const DropdownMenuItem(
                                        value: null,
                                        child: Text('Tous'),
                                      ),
                                      const DropdownMenuItem(
                                        value: 'justified',
                                        child: Text('Justifiées'),
                                      ),
                                      const DropdownMenuItem(
                                        value: 'unjustified',
                                        child: Text('Non justifiées'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedStatut = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final DateTimeRange? picked = await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(2023, 1, 1),
                                    lastDate: DateTime(2024, 12, 31),
                                    currentDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _dateRange = picked;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.textPrimary,
                                  elevation: 0,
                                ),
                                child: Text(
                                  _dateRange != null
                                      ? '${_dateRange!.start.day}/${_dateRange!.start.month} - ${_dateRange!.end.day}/${_dateRange!.end.month}'
                                      : 'Période (optionnel)',
                                ),
                              ),
                              SecondaryButton(
                                text: 'Réinitialiser',
                                onPressed: () {
                                  setState(() {
                                    _selectedEtudiant = null;
                                    _selectedStatut = null;
                                    _dateRange = null;
                                    _searchQuery = '';
                                  });
                                },
                                icon: Icons.filter_alt_off,
                                fullWidth: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Absences List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Absences (${filteredAbsences.length})',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Nouvelle absence',
                                onPressed: () {
                                  // TODO: Ajouter absence
                                },
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (filteredAbsences.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'Aucune absence ne correspond aux critères',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            )
                          else
                            ...filteredAbsences.map((absence) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: Container(
                                    width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                                    height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                                    decoration: BoxDecoration(
                                      color: absence.justifie
                                          ? AppTheme.successColor.withOpacity(0.1)
                                          : AppTheme.errorColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      absence.justifie
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                      color: absence.justifie
                                          ? AppTheme.successColor
                                          : AppTheme.errorColor,
                                      size: AppConstants.widthPercentage(context, AppConstants.iconSize),
                                    ),
                                  ),
                                  title: Text(
                                    _etudiants[absence.etudiantId] ?? 'Étudiant inconnu',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      Text(
                                        '${absence.date.day}/${absence.date.month}/${absence.date.year} - ${absence.motif}',
                                        style: TextStyle(
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                        ),
                                      ),
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      Text(
                                        _classes[absence.etudiantId] ?? 'Classe inconnue',
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (!absence.justifie)
                                        IconButton(
                                          icon: Icon(Icons.check,
                                              size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                          onPressed: () {
                                            _showJustifyDialog(context, absence);
                                          },
                                          color: AppTheme.successColor,
                                          tooltip: 'Justifier',
                                        ),
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                        onPressed: () {
                                          // TODO: Éditer absence
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                        onPressed: () {
                                          _showDeleteDialog(context, absence);
                                        },
                                        color: AppTheme.errorColor,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics by Student
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Absences par étudiant',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._etudiants.entries.map((etudiant) {
                            final absencesEtudiant = _absences
                                .where((a) => a.etudiantId == etudiant.key)
                                .toList();
                            final justifiees = absencesEtudiant
                                .where((a) => a.justifie)
                                .length;
                            final nonJustifiees = absencesEtudiant.length - justifiees;
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Text(
                                        etudiant.value,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                        ),
                                      ),
                                      Text(
                                        _classes[etudiant.key] ?? '',
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                        ),
                                      ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.successColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '$justifiees',
                                      style: TextStyle(
                                        color: AppTheme.successColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.errorColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '$nonJustifiees',
                                      style: TextStyle(
                                        color: AppTheme.errorColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${absencesEtudiant.length}',
                                      style: TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Action Buttons
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        SecondaryButton(
                          text: 'Exporter rapport',
                          onPressed: () {
                            // TODO: Exporter rapport
                          },
                          icon: Icons.description,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Notifier les parents',
                          onPressed: () {
                            // TODO: Notifier parents
                          },
                          icon: Icons.notifications_active,
                          fullWidth: true,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    SecondaryButton(
                      text: 'Générer statistiques',
                      onPressed: () {
                        // TODO: Générer statistiques
                      },
                      icon: Icons.bar_chart,
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

  void _showJustifyDialog(BuildContext context, Absence absence) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Justifier l\'absence',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          ),
        ),
        content: Text(
          'Voulez-vous marquer cette absence comme justifiée ?',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              ),
            ),
          ),
          PrimaryButton(
            text: 'Justifier',
            onPressed: () {
              // TODO: Justifier via ViewModel
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Absence justifiée',
                    style: TextStyle(
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    ),
                  ),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Absence absence) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Supprimer l\'absence',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          ),
        ),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer cette absence ? Cette action est irréversible.',
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              ),
            ),
          ),
          PrimaryButton(
            text: 'Supprimer',
            onPressed: () {
              // TODO: Supprimer via ViewModel
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Absence supprimée',
                    style: TextStyle(
                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                    ),
                  ),
                  backgroundColor: AppTheme.errorColor,
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
