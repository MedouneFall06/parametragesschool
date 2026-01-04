import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/etudiant_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/empty_state_widget.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

// Constantes modifiables pour le responsive design
class EtudiantListScreenConstants {
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
  
  // Cartes d'étudiants
  static const double studentCardPadding = 0.02;
  static const double studentAvatarSize = 0.08;
  static const double studentTitleFontSize = 0.025;
  static const double studentSubtitleFontSize = 0.018;
  static const double studentInfoFontSize = 0.016;
  static const double studentIconSize = 0.025;
  
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

class EtudiantListScreen extends StatefulWidget {
  const EtudiantListScreen({super.key});

  @override
  State<EtudiantListScreen> createState() => _EtudiantListScreenState();
}

class _EtudiantListScreenState extends State<EtudiantListScreen> {
  // Données fictives pour l'affichage statique
  final List<Etudiant> _etudiants = [
    Etudiant(
      id: "1",
      nom: "Fall",
      prenom: "Medoune",
      matricule: "ETU2024001",
      classeId: "CLS001",
      parentId: "PAR001",
    ),
    Etudiant(
      id: "2",
      nom: "Diop",
      prenom: "Awa",
      matricule: "ETU2024002",
      classeId: "CLS001",
      parentId: null,
    ),
    Etudiant(
      id: "3",
      nom: "Ndoye",
      prenom: "Moussa",
      matricule: "ETU2024003",
      classeId: "CLS002",
      parentId: "PAR002",
    ),
    Etudiant(
      id: "4",
      nom: "Sarr",
      prenom: "Fatou",
      matricule: "ETU2024004",
      classeId: "CLS001",
      parentId: "PAR003",
    ),
    Etudiant(
      id: "5",
      nom: "Gueye",
      prenom: "Ibrahima",
      matricule: "ETU2024005",
      classeId: "CLS003",
      parentId: null,
    ),
    Etudiant(
      id: "6",
      nom: "Diallo",
      prenom: "Aminata",
      matricule: "ETU2024006",
      classeId: "CLS002",
      parentId: "PAR004",
    ),
    Etudiant(
      id: "7",
      nom: "Ba",
      prenom: "Ousmane",
      matricule: "ETU2024007",
      classeId: "CLS003",
      parentId: "PAR005",
    ),
    Etudiant(
      id: "8",
      nom: "Camara",
      prenom: "Khadija",
      matricule: "ETU2024008",
      classeId: "CLS001",
      parentId: null,
    ),
  ];

  final Map<String, String> _classes = {
    "CLS001": "Terminale S",
    "CLS002": "Première L",
    "CLS003": "Seconde G",
  };

  String _searchQuery = '';
  String? _selectedClass;
  String? _selectedParentStatus;

  @override
  Widget build(BuildContext context) {
    // Filtrage local
    List<Etudiant> filteredEtudiants = _etudiants.where((etudiant) {
      bool matchesSearch = '${etudiant.prenom} ${etudiant.nom} ${etudiant.matricule}'
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      
      bool matchesClass = _selectedClass == null || 
          etudiant.classeId == _selectedClass;
      
      bool matchesParentStatus = _selectedParentStatus == null ||
          (_selectedParentStatus == 'with_parent' && etudiant.parentId != null) ||
          (_selectedParentStatus == 'without_parent' && etudiant.parentId == null);
      
      return matchesSearch && matchesClass && matchesParentStatus;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Liste des étudiants',
              subtitle: 'Gestion complète des élèves',
            ),
            Expanded(
              child: Column(
                children: [
                  // Search and Filters
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * EtudiantListScreenConstants.paddingAll),
                    child: Column(
                      children: [
                        // Search Bar
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher un étudiant...',
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchContentPaddingHorizontal,
                              vertical: MediaQuery.of(context).size.height * EtudiantListScreenConstants.searchContentPaddingVertical,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchHintFontSize,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                        
                        SizedBox(height: MediaQuery.of(context).size.height * EtudiantListScreenConstants.spacingSmall),
                        
                        // Filters
                        ResponsiveGrid(
                          customSpacing: MediaQuery.of(context).size.width * EtudiantListScreenConstants.paddingBetweenItems,
                          children: [
                            DropdownButtonFormField<String?>(
                              value: _selectedClass,
                              decoration: InputDecoration(
                                labelText: 'Filtrer par classe',
                                labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchLabelFontSize),
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: null,
                                  child: Text('Toutes les classes'),
                                ),
                                ..._classes.entries.map((entry) {
                                  return DropdownMenuItem(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  );
                                }).toList(),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedClass = value;
                                });
                              },
                            ),
                            DropdownButtonFormField<String?>(
                              value: _selectedParentStatus,
                              decoration: InputDecoration(
                                labelText: 'Statut parent',
                                labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchLabelFontSize),
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text('Tous'),
                                ),
                                DropdownMenuItem(
                                  value: 'with_parent',
                                  child: Text('Avec parent'),
                                ),
                                DropdownMenuItem(
                                  value: 'without_parent',
                                  child: Text('Sans parent'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedParentStatus = value;
                                });
                              },
                            ),
                          ],
                        ),
                        
                        SizedBox(height: MediaQuery.of(context).size.height * EtudiantListScreenConstants.spacingSmall),
                        
                        // Quick Actions
                        ResponsiveGrid(
                          customSpacing: MediaQuery.of(context).size.width * EtudiantListScreenConstants.paddingBetweenItems,
                          children: [
                            SecondaryButton(
                              text: 'Réinitialiser',
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
                                  _selectedClass = null;
                                  _selectedParentStatus = null;
                                });
                              },
                              icon: Icons.filter_alt_off,
                              fullWidth: true,
                            ),
                            PrimaryButton(
                              text: 'Exporter',
                              onPressed: () {
                                // TODO: Exporter la liste
                              },
                              icon: Icons.download,
                              fullWidth: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Results Counter
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * EtudiantListScreenConstants.paddingHorizontal,
                      vertical: MediaQuery.of(context).size.height * EtudiantListScreenConstants.spacingSmall,
                    ),
                    color: AppTheme.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${filteredEtudiants.length} étudiant(s)',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.statTitleFontSize,
                          ),
                        ),
                        Text(
                          'Total: ${_etudiants.length}',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.statTitleFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Students List
                  Expanded(
                    child: filteredEtudiants.isEmpty
                        ? EmptyStateWidget(
                            title: 'Aucun étudiant trouvé',
                            message: _searchQuery.isNotEmpty
                                ? 'Aucun étudiant ne correspond à votre recherche.'
                                : 'Aucun étudiant dans cette catégorie.',
                            icon: Icons.people_alt_outlined,
                            buttonText: 'Réinitialiser les filtres',
                            onButtonPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _selectedClass = null;
                                _selectedParentStatus = null;
                              });
                            },
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * EtudiantListScreenConstants.paddingAll),
                              child: ResponsiveGrid(
                                customSpacing: MediaQuery.of(context).size.width * EtudiantListScreenConstants.paddingBetweenCards,
                                children: filteredEtudiants.map((etudiant) {
                                  return EtudiantCard(
                                    etudiant: etudiant,
                                    nomClasse: _classes[etudiant.classeId],
                                    onTap: () {
                                      context.pushNamed(
                                        'etudiant-detail',
                                        extra: {
                                          'etudiant': etudiant,
                                          'nomClasse': _classes[etudiant.classeId],
                                        },
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('etudiant-create');
        },
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        child: Icon(
          Icons.person_add,
          size: MediaQuery.of(context).size.width * EtudiantListScreenConstants.studentIconSize,
        ),
      ),
    );
  }

  // WIDGET POUR LES DROPDOWNS ADAPTATIFS
  Widget _buildFilterDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String?>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String?>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchLabelFontSize),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchContentPaddingHorizontal,
          vertical: MediaQuery.of(context).size.height * EtudiantListScreenConstants.searchContentPaddingVertical,
        ),
      ),
      items: items,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.searchHintFontSize,
      ),
      isExpanded: true,
      iconSize: MediaQuery.of(context).size.width * EtudiantListScreenConstants.studentIconSize,
    );
  }
}
