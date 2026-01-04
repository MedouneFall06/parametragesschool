import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/classe_model.dart';
// ignore: unused_import
import 'package:parametragesschool/models/departement_model.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

// TODO: Transformer en ConsumerStatefulWidget avec Riverpod
// TODO: Créer ClasseViewModel
// TODO: Récupérer classes depuis l'API/BDD
// TODO: Implémenter CRUD des classes
// TODO: Gérer états loading/error
// TODO: Ajouter fonctionnalités d'affectation d'enseignants

class ClasseScreen extends StatefulWidget {
  const ClasseScreen({super.key});

  @override
  State<ClasseScreen> createState() => _ClasseScreenState();
}

class _ClasseScreenState extends State<ClasseScreen> {
  // Données fictives pour l'affichage statique
  final List<Classe> _classes = [
    Classe(
      id: "CLS001",
      nom: "Terminale S1",
      niveau: "Terminale",
      departementId: "DEP001",
    ),
    Classe(
      id: "CLS002",
      nom: "Terminale S2",
      niveau: "Terminale",
      departementId: "DEP001",
    ),
    Classe(
      id: "CLS003",
      nom: "Première L1",
      niveau: "Première",
      departementId: "DEP002",
    ),
    Classe(
      id: "CLS004",
      nom: "Seconde G1",
      niveau: "Seconde",
      departementId: "DEP001",
    ),
    Classe(
      id: "CLS005",
      nom: "Terminale ES",
      niveau: "Terminale",
      departementId: "DEP003",
    ),
  ];

  final Map<String, String> _departements = {
    "DEP001": "Sciences",
    "DEP002": "Lettres",
    "DEP003": "Économie",
  };

  final Map<String, int> _effectifs = {
    "CLS001": 32,
    "CLS002": 28,
    "CLS003": 25,
    "CLS004": 30,
    "CLS005": 27,
  };

  String? _selectedNiveau;
  String? _selectedDepartement;

  @override
  Widget build(BuildContext context) {
    // Filtrage local (à déplacer dans ViewModel)
    List<Classe> filteredClasses = _classes.where((classe) {
      bool matchesNiveau =
          _selectedNiveau == null || classe.niveau == _selectedNiveau;

      bool matchesDepartement = _selectedDepartement == null ||
          classe.departementId == _selectedDepartement;

      return matchesNiveau && matchesDepartement;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final totalEtudiants =
    _effectifs.values.fold(0, (sum, effectif) => sum + effectif);
    final classesParNiveau = {
      'Terminale': _classes.where((c) => c.niveau == 'Terminale').length,
      'Première': _classes.where((c) => c.niveau == 'Première').length,
      'Seconde': _classes.where((c) => c.niveau == 'Seconde').length,
    };

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des classes',
              subtitle: 'Organisation des groupes d\'étudiants',
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
                          title: 'Classes totales',
                          value: _classes.length.toString(),
                          icon: Icons.class_,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Étudiants total',
                          value: totalEtudiants.toString(),
                          icon: Icons.people,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),

                    StatCard(
                      title: 'Moyenne par classe',
                      value:
                      (totalEtudiants / _classes.length).toStringAsFixed(1),
                      icon: Icons.calculate,
                      color: AppTheme.secondaryColor,
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),

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
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              DropdownButtonFormField<String?>(
                                value: _selectedNiveau,
                                decoration: InputDecoration(
                                  labelText: 'Niveau (optionnel)',
                                  labelStyle: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize)),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: AppConstants.widthPercentage(context, AppConstants.cardPadding),
                                    vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                                  ),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Tous les niveaux'),
                                  ),
                                  ...['Terminale', 'Première', 'Seconde']
                                      .map((niveau) {
                                    return DropdownMenuItem(
                                      value: niveau,
                                      child: Text(niveau),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNiveau = value;
                                  });
                                },
                              ),
                              DropdownButtonFormField<String?>(
                                value: _selectedDepartement,
                                decoration: InputDecoration(
                                  labelText: 'Département (optionnel)',
                                  labelStyle: TextStyle(fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize)),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: AppConstants.widthPercentage(context, AppConstants.cardPadding),
                                    vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                                  ),
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
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              SecondaryButton(
                                text: 'Réinitialiser',
                                onPressed: () {
                                  setState(() {
                                    _selectedNiveau = null;
                                    _selectedDepartement = null;
                                  });
                                },
                                icon: Icons.filter_alt_off,
                                fullWidth: true,
                              ),
                              PrimaryButton(
                                text: 'Nouvelle classe',
                                onPressed: () {
                                  context.goNamed('classe_details',
                                      pathParameters: {'id': 'new'});
                                },
                                icon: Icons.add,
                                fullWidth: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),

                    // Classes List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Classes (${filteredClasses.length})',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // TODO: Exporter la liste
                                },
                                icon: const Icon(Icons.download),
                                tooltip: 'Exporter',
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          if (filteredClasses.isEmpty)
                            Padding(
                              padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                              child: Text(
                                'Aucune classe ne correspond aux filtres',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                ),
                              ),
                            )
                          else
                            ...filteredClasses.map((classe) {
                              return Card(
                                margin: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                child: ListTile(
                                  leading: Container(
                                    width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                                    height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                                    decoration: BoxDecoration(
                                      color: _getClasseColor(classe.niveau),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getClasseInitials(classe.nom),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    classe.nom,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      Text(
                                        '${classe.niveau} • ${_departements[classe.departementId] ?? 'Département inconnu'}',
                                        style: TextStyle(
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                        ),
                                      ),
                                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                      Text(
                                        'Effectif: ${_effectifs[classe.id] ?? 0} étudiants',
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.people,
                                            size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                        onPressed: () {
                                          // TODO: Naviguer vers la liste des étudiants de la classe
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                        onPressed: () {
                                          context.goNamed('classe_details',
                                              pathParameters: {
                                                'id': classe.id
                                              });
                                        },
                                        color: AppTheme.accentColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    context.pushNamed('matieres');
                                  },
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),

                    // Statistics by Level
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Répartition par niveau',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ...classesParNiveau.entries.map((entry) {
                            final percentage =
                            (entry.value / _classes.length * 100);
                            return Padding(
                              padding: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${entry.value} classes (${percentage.toStringAsFixed(1)}%)',
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  LinearProgressIndicator(
                                    value: entry.value / _classes.length,
                                    backgroundColor: AppTheme.backgroundColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getNiveauColor(entry.key),
                                    ),
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),

                    // Quick Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Actions rapides',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                            children: [
                              _buildQuickAction(
                                context: context,
                                icon: Icons.schedule,
                                label: 'Emploi du temps',
                                onTap: () {
                                  // TODO: Naviguer vers la page générale des EDT
                                },
                              ),
                              _buildQuickAction(
                                context: context,
                                icon: Icons.assignment,
                                label: 'Programmes',
                                onTap: () {
                                  // TODO: Voir programmes
                                },
                              ),
                              _buildQuickAction(
                                context: context,
                                icon: Icons.people_alt,
                                label: 'Affecter enseignants',
                                onTap: () {
                                  // TODO: Affecter enseignants
                                },
                              ),
                              _buildQuickAction(
                                context: context,
                                icon: Icons.bar_chart,
                                label: 'Statistiques',
                                onTap: () {
                                  // TODO: Voir statistiques
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),

                    // Export Options
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        SecondaryButton(
                          text: 'Générer rapport',
                          onPressed: () {},
                          icon: Icons.description,
                          fullWidth: true,
                        ),
                        SecondaryButton(
                          text: 'Importer classes',
                          onPressed: () {},
                          icon: Icons.upload,
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

  Color _getClasseColor(String niveau) {
    switch (niveau) {
      case 'Terminale':
        return AppTheme.primaryColor;
      case 'Première':
        return AppTheme.accentColor;
      case 'Seconde':
        return AppTheme.secondaryColor;
      default:
        return AppTheme.infoColor;
    }
  }

  Color _getNiveauColor(String niveau) {
    switch (niveau) {
      case 'Terminale':
        return AppTheme.primaryColor;
      case 'Première':
        return AppTheme.accentColor;
      case 'Seconde':
        return AppTheme.secondaryColor;
      default:
        return AppTheme.infoColor;
    }
  }

  String _getClasseInitials(String nom) {
    final parts = nom.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}';
    }
    return nom.length >= 2
        ? nom.substring(0, 2).toUpperCase()
        : nom.toUpperCase();
  }

  Widget _buildQuickAction({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.widthPercentage(context, AppConstants.minCardWidth),
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppTheme.backgroundColor),
        ),
        child: Column(
          children: [
            Container(
              width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.8),
              height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
