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
    // Détecter la taille de l'écran
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    
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
                  // Search and Filters - ADAPTÉ AU RESPONSIVE
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                    child: Column(
                      children: [
                        // Search Bar - TAILLE ADAPTATIVE
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
                              horizontal: isSmallScreen ? 12 : 16,
                              vertical: isSmallScreen ? 14 : 16,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // FILTRES EN COLONNE SI ÉCRAN PETIT
                        if (isSmallScreen) ...[
                          // Version mobile : une colonne
                          Column(
                            children: [
                              _buildFilterDropdown(
                                label: 'Filtrer par classe',
                                value: _selectedClass,
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
                                isSmallScreen: isSmallScreen,
                              ),
                              
                              const SizedBox(height: 12),
                              
                              _buildFilterDropdown(
                                label: 'Statut parent',
                                value: _selectedParentStatus,
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
                                isSmallScreen: isSmallScreen,
                              ),
                            ],
                          ),
                        ] else ...[
                          // Version desktop/tablette : deux colonnes
                          Row(
                            children: [
                              Expanded(
                                child: _buildFilterDropdown(
                                  label: 'Filtrer par classe',
                                  value: _selectedClass,
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
                                  isSmallScreen: isSmallScreen,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildFilterDropdown(
                                  label: 'Statut parent',
                                  value: _selectedParentStatus,
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
                                  isSmallScreen: isSmallScreen,
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                        const SizedBox(height: 12),
                        
                        // Quick Actions - ADAPTÉ AU RESPONSIVE
                        if (isSmallScreen) ...[
                          // Version mobile : boutons en colonne
                          Column(
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
                              const SizedBox(height: 8),
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
                        ] else ...[
                          // Version desktop/tablette : boutons en ligne
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Réinitialiser',
                                  onPressed: () {
                                    setState(() {
                                      _searchQuery = '';
                                      _selectedClass = null;
                                      _selectedParentStatus = null;
                                    });
                                  },
                                  icon: Icons.filter_alt_off,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Exporter',
                                  onPressed: () {
                                    // TODO: Exporter la liste
                                  },
                                  icon: Icons.download,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Results Counter - TEXTE ADAPTATIF
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: 8,
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
                            fontSize: isSmallScreen ? 13 : 14,
                          ),
                        ),
                        Text(
                          'Total: ${_etudiants.length}',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: isSmallScreen ? 13 : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Students List - RESPONSIVEGRID
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
                              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                              child: ResponsiveGrid(
                                spacing: isSmallScreen ? 8 : 12,
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
          size: isSmallScreen ? 20 : 24,
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
    required bool isSmallScreen,
  }) {
    return DropdownButtonFormField<String?>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 14 : 16,
        ),
        labelStyle: TextStyle(
          fontSize: isSmallScreen ? 14 : 16,
        ),
      ),
      items: items,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: isSmallScreen ? 14 : 16,
      ),
      isExpanded: true,
      iconSize: isSmallScreen ? 20 : 24,
    );
  }
}