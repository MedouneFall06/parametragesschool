import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // IMPORT GOROUTER
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/matiere_model.dart';
// ignore: unused_import
import 'package:parametragesschool/models/departement_model.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
import 'package:parametragesschool/core/constant/constants.dart';

// Constantes modifiables pour le responsive design
class MatiereScreenConstants {
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
  
  // Cartes de matières
  static const double matiereCardPadding = 0.02;
  static const double matiereAvatarSize = 0.08;
  static const double matiereTitleFontSize = 0.025;
  static const double matiereSubtitleFontSize = 0.018;
  static const double matiereCoefficientFontSize = 0.016;
  static const double matiereIconSize = 0.025;
  
  // Recherche et filtres
  static const double searchLabelFontSize = 0.025;
  static const double searchContentPaddingHorizontal = 0.02;
  static const double searchContentPaddingVertical = 0.015;
  static const double searchHintFontSize = 0.018;
  
  // Espacements
  static const double spacingSmall = 0.003;
  static const double spacingMedium = 0.006;
  static const double spacingLarge = 0.01;
  static const double spacingExtraLarge = 0.015;
}

// TODO: Transformer en ConsumerStatefulWidget avec Riverpod
// TODO: Créer MatiereViewModel
// TODO: Récupérer matières depuis l'API/BDD
// TODO: Implémenter CRUD des matières
// TODO: Gérer états loading/error
// TODO: Ajouter affectation aux classes

class MatiereScreen extends StatefulWidget {
  const MatiereScreen({super.key});

  @override
  State<MatiereScreen> createState() => _MatiereScreenState();
}

class _MatiereScreenState extends State<MatiereScreen> {
  // Données fictives pour l'affichage statique
  final List<Matiere> _matieres = [
    Matiere(id: "MAT001", nom: "Mathématiques", coefficient: 4.0),
    Matiere(id: "MAT002", nom: "Physique-Chimie", coefficient: 3.0),
    Matiere(id: "MAT003", nom: "Français", coefficient: 3.0),
    Matiere(id: "MAT004", nom: "Anglais", coefficient: 2.0),
    Matiere(id: "MAT005", nom: "Histoire-Géographie", coefficient: 2.0),
    Matiere(id: "MAT006", nom: "SVT", coefficient: 2.0),
    Matiere(id: "MAT007", nom: "Philosophie", coefficient: 2.0),
    Matiere(id: "MAT008", nom: "EPS", coefficient: 1.0),
  ];

  final Map<String, String> _departements = {
    "DEP001": "Sciences",
    "DEP002": "Lettres",
    "DEP003": "Langues",
    "DEP004": "Sciences Humaines",
  };

  final Map<String, List<String>> _matieresParDepartement = {
    "DEP001": ["MAT001", "MAT002", "MAT006"],
    "DEP002": ["MAT003", "MAT007"],
    "DEP003": ["MAT004"],
    "DEP004": ["MAT005"],
  };

  String? _selectedDepartement;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filtrage local (à déplacer dans ViewModel)
    List<Matiere> filteredMatieres = _matieres.where((matiere) {
      bool matchesSearch =
      matiere.nom.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesDepartement = _selectedDepartement == null ||
          (_matieresParDepartement[_selectedDepartement]?.contains(matiere.id) ??
              false);

      return matchesSearch && matchesDepartement;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final totalCoefficient =
    _matieres.map((m) => m.coefficient).fold(0.0, (a, b) => a + b);

    final moyenneCoefficient =
    _matieres.isNotEmpty ? totalCoefficient / _matieres.length : 0.0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des matières',
              subtitle: 'Organisation des enseignements',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * MatiereScreenConstants.paddingAll),
                child: Column(
                  children: [
                    // Statistics
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Matières totales',
                          value: _matieres.length.toString(),
                          icon: Icons.menu_book,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Coefficient total',
                          value: totalCoefficient.toStringAsFixed(1),
                          icon: Icons.calculate,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),

                    StatCard(
                      title: 'Moyenne coefficient',
                      value: moyenneCoefficient.toStringAsFixed(1),
                      icon: Icons.trending_up,
                      color: AppTheme.secondaryColor,
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),

                    // Search and Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recherche et filtres',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.statTitleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingMedium)),
                          // Search Bar
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher une matière...',
                              hintStyle: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.hintFontSize)),
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
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingMedium)),
                          ResponsiveGrid(
                            customSpacing: MediaQuery.of(context).size.width * MatiereScreenConstants.paddingBetweenItems,
                            children: [
                              DropdownButtonFormField<String?>(
                                value: _selectedDepartement,
                                decoration: InputDecoration(
                                  labelText: 'Département (optionnel)',
                                  labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.searchLabelFontSize),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Tous les départements'),
                                  ),
                                  ..._departements.entries.map((entry) {
                                    return DropdownMenuItem(
                                      value: entry.key,
                                      child: Text(entry.value),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDepartement = value;
                                  });
                                },
                              ),
                              SecondaryButton(
                                text: 'Réinitialiser',
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                    _selectedDepartement = null;
                                  });
                                },
                                icon: Icons.filter_alt_off,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * MatiereScreenConstants.spacingExtraLarge),

                    // Matières List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Matières (${filteredMatieres.length})',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.statTitleFontSize,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Nouvelle matière',
                                onPressed: () {
                                  // Naviguer vers la page de création/modification
                                  context.goNamed('matiere_details',
                                      pathParameters: {'id': 'new'});
                                },
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * MatiereScreenConstants.spacingMedium),
                          if (filteredMatieres.isEmpty)
                            Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * MatiereScreenConstants.paddingAll),
                              child: Text(
                                'Aucune matière ne correspond aux critères',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereSubtitleFontSize,
                                ),
                              ),
                            )
                          else
                            ...filteredMatieres.map((matiere) {
                              return Card(
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * MatiereScreenConstants.paddingBetweenCards),
                                child: ListTile(
                                  leading: Container(
                                    width: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereAvatarSize,
                                    height: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereAvatarSize,
                                    decoration: BoxDecoration(
                                      color: _getMatiereColor(matiere.nom),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getMatiereInitials(matiere.nom),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereTitleFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    matiere.nom,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereTitleFontSize,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height * MatiereScreenConstants.spacingSmall),
                                      Row(
                                        children: [
                                          Icon(Icons.scale, size: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereIconSize),
                                          SizedBox(width: MediaQuery.of(context).size.width * MatiereScreenConstants.spacingSmall),
                                          Text(
                                            'Coefficient: ${matiere.coefficient}',
                                            style: TextStyle(fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereCoefficientFontSize),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * MatiereScreenConstants.spacingSmall),
                                      Text(
                                        _getDepartementForMatiere(matiere.id),
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereSubtitleFontSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, size: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereIconSize),
                                        onPressed: () {
                                          // Naviguer vers l'édition
                                          context.goNamed('matiere_details',
                                              pathParameters: {
                                                'id': matiere.id
                                              });
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, size: MediaQuery.of(context).size.width * MatiereScreenConstants.matiereIconSize),
                                        onPressed: () {
                                          _showDeleteDialog(context, matiere);
                                        },
                                        color: AppTheme.errorColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Naviguer vers les détails de la matière
                                    context.goNamed('matiere_details',
                                        pathParameters: {'id': matiere.id});
                                  },
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),

                    // ... Le reste de votre code (charts, actions, etc.)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Vos fonctions helper restent ici ---
  Color _getMatiereColor(String nom) {
    final hash = nom.hashCode;
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
      AppTheme.successColor,
      AppTheme.warningColor,
    ];
    return colors[hash.abs() % colors.length];
  }

  String _getMatiereInitials(String nom) {
    final parts = nom.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return nom.length >= 2 ? nom.substring(0, 2).toUpperCase() : nom.toUpperCase();
  }

  String _getDepartementForMatiere(String matiereId) {
    for (final entry in _matieresParDepartement.entries) {
      if (entry.value.contains(matiereId)) {
        return _departements[entry.key] ?? 'Département inconnu';
      }
    }
    return 'Non affectée';
  }

  void _showDeleteDialog(BuildContext context, Matiere matiere) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la matière'),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer "${matiere.nom}" ? '
              'Cette action est irréversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Supprimer',
            onPressed: () {
              // TODO: Supprimer via ViewModel
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Matière "${matiere.nom}" supprimée'),
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
