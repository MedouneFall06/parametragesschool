import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/etudiant_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/empty_state_widget.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:go_router/go_router.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer EtudiantListViewModel
// TODO: Récupérer la liste depuis l'API/BDD
// TODO: Implémenter la recherche/filtrage
// TODO: Ajouter pagination infinie
// TODO: Gérer états loading/error/empty

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
    // Filtrage local (à remplacer par ViewModel)
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
                    padding: const EdgeInsets.all(16),
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
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        // Filters
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedClass,
                                decoration: const InputDecoration(
                                  labelText: 'Filtrer par classe',
                                  border: OutlineInputBorder(),
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
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedParentStatus,
                                decoration: const InputDecoration(
                                  labelText: 'Statut parent',
                                  border: OutlineInputBorder(),
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Quick Actions
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
                    ),
                  ),
                  
                  // Results Counter
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: AppTheme.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${filteredEtudiants.length} étudiant(s) trouvé(s)',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Total: ${_etudiants.length}',
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
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
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: filteredEtudiants.length,
                            itemBuilder: (context, index) {
                              final etudiant = filteredEtudiants[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: EtudiantCard(
                                  etudiant: etudiant,
                                  nomClasse: _classes[etudiant.classeId],
                                  onTap: () {
                                    context.pushNamed(  // CHANGER Navigator.pushNamed en context.pushNamed
                                      'etudiant-detail',  // CHANGER '/etudiant-detail' en 'etudiant-detail'
                                      extra: {  // CHANGER arguments en extra
                                        'etudiant': etudiant,
                                        'nomClasse': _classes[etudiant.classeId],
                                      },
                                    );
                                  },
                                ),
                              );
                            },
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
        context.pushNamed('etudiant-create');  // CHANGER Navigator.pushNamed
      },
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      child: const Icon(Icons.person_add),
      ),
    );
  }
}