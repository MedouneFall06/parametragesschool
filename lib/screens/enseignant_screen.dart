import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/enseignant_model.dart';
import 'package:parametragesschool/models/user_model.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer EnseignantViewModel
// TODO: Récupérer enseignants depuis l'API/BDD
// TODO: Implémenter CRUD des enseignants
// TODO: Gérer états loading/error
// TODO: Ajouter affectation des matières

class EnseignantScreen extends StatefulWidget {
  const EnseignantScreen({super.key});

  @override
  State<EnseignantScreen> createState() => _EnseignantScreenState();
}

class _EnseignantScreenState extends State<EnseignantScreen> {
  // Données fictives pour l'affichage statique
  final List<User> _enseignants = [
    User(
      id: "ENS001",
      nom: "Diallo",
      prenom: "Mamadou",
      email: "m.diallo@ecole.com",
      role: "enseignant",

    ),
    User(
      id: "ENS002",
      nom: "Ndiaye",
      prenom: "Aminata",
      email: "a.ndiaye@ecole.com",
      role: "enseignant",
    ),
    User(
      id: "ENS003",
      nom: "Sow",
      prenom: "Ibrahima",
      email: "i.sow@ecole.com",
      role: "enseignant",
    ),
    User(
      id: "ENS004",
      nom: "Traoré",
      prenom: "Fatou",
      email: "f.traore@ecole.com",
      role: "enseignant",
    ),
    User(
      id: "ENS005",
      nom: "Ba",
      prenom: "Ousmane",
      email: "o.ba@ecole.com",
      role: "enseignant",
    ),
  ];

  final Map<String, Enseignant> _enseignantsDetails = {
    "ENS001": Enseignant(userId: "ENS001", specialite: "Mathématiques"),
    "ENS002": Enseignant(userId: "ENS002", specialite: "Physique-Chimie"),
    "ENS003": Enseignant(userId: "ENS003", specialite: "Français"),
    "ENS004": Enseignant(userId: "ENS004", specialite: "Anglais"),
    "ENS005": Enseignant(userId: "ENS005", specialite: "Histoire-Géographie"),
  };

  final Map<String, List<String>> _matieresEnseignants = {
    "ENS001": ["Mathématiques", "Algorithmique"],
    "ENS002": ["Physique", "Chimie"],
    "ENS003": ["Français", "Philosophie"],
    "ENS004": ["Anglais", "Espagnol"],
    "ENS005": ["Histoire", "Géographie"],
  };

  final Map<String, List<String>> _classesEnseignants = {
    "ENS001": ["Terminale S1", "Terminale S2"],
    "ENS002": ["Terminale S1", "Première S"],
    "ENS003": ["Terminale L", "Première L"],
    "ENS004": ["Toutes les classes"],
    "ENS005": ["Terminale ES", "Première ES"],
  };

  String _searchQuery = '';
  String? _selectedSpecialite;

  @override
  Widget build(BuildContext context) {
    // Filtrage local (à déplacer dans ViewModel)
    List<User> filteredEnseignants = _enseignants.where((enseignant) {
      bool matchesSearch = '${enseignant.prenom} ${enseignant.nom} ${enseignant.email}'
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      
      bool matchesSpecialite = _selectedSpecialite == null ||
          _enseignantsDetails[enseignant.id]?.specialite == _selectedSpecialite;
      
      return matchesSearch && matchesSpecialite;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final Set<String> specialites = _enseignantsDetails.values
        .map((e) => e.specialite)
        .toSet();
    
    final int totalClasses = _classesEnseignants.values
        .expand((list) => list)
        .toSet()
        .length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des enseignants',
              subtitle: 'Corps professoral',
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
                            title: 'Enseignants',
                            value: _enseignants.length.toString(),
                            icon: Icons.people,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Spécialités',
                            value: specialites.length.toString(),
                            icon: Icons.school,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Classes couvertes',
                            value: totalClasses.toString(),
                            icon: Icons.class_,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Matières enseignées',
                            value: _matieresEnseignants.values
                                .expand((list) => list)
                                .toSet()
                                .length
                                .toString(),
                            icon: Icons.menu_book,
                            color: AppTheme.infoColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Search and Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recherche et filtres',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Search Bar
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Rechercher un enseignant...',
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
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String?>(
                                  value: _selectedSpecialite,
                                  decoration: const InputDecoration(
                                    labelText: 'Spécialité (optionnel)',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('Toutes les spécialités'),
                                    ),
                                    ...specialites.map((specialite) {
                                      return DropdownMenuItem(
                                        value: specialite,
                                        child: Text(specialite),
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSpecialite = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Réinitialiser',
                                  onPressed: () {
                                    setState(() {
                                      _searchQuery = '';
                                      _selectedSpecialite = null;
                                    });
                                  },
                                  icon: Icons.filter_alt_off,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Enseignants List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enseignants (${filteredEnseignants.length})',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Nouvel enseignant',
                                onPressed: () {
                                  // TODO: Ajouter enseignant
                                },
                                icon: Icons.person_add,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (filteredEnseignants.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'Aucun enseignant ne correspond aux critères',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            )
                          else
                            ...filteredEnseignants.map((enseignant) {
                              final details = _enseignantsDetails[enseignant.id];
                              final matieres = _matieresEnseignants[enseignant.id] ?? [];
                              // ignore: unused_local_variable
                              final classes = _classesEnseignants[enseignant.id] ?? [];
                              
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _getEnseignantColor(enseignant.id),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getInitials(enseignant.prenom, enseignant.nom),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${enseignant.prenom} ${enseignant.nom}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      if (details != null)
                                        Text(
                                          details.specialite,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      const SizedBox(height: 4),
                                      Text(
                                        enseignant.email,
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Wrap(
                                        spacing: 4,
                                        runSpacing: 4,
                                        children: [
                                          ...matieres.take(2).map((matiere) {
                                            return Chip(
                                              label: Text(
                                                matiere,
                                                style: const TextStyle(fontSize: 10),
                                              ),
                                              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                            );
                                          }).toList(),
                                          if (matieres.length > 2)
                                            Chip(
                                              label: Text(
                                                '+${matieres.length - 2}',
                                                style: const TextStyle(fontSize: 10),
                                              ),
                                              backgroundColor: AppTheme.textSecondary.withOpacity(0.1),
                                              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            size: 20),
                                        onPressed: () {
                                          // TODO: Éditer enseignant
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            size: 20),
                                        onPressed: () {
                                          _showDeleteDialog(context, enseignant);
                                        },
                                        color: AppTheme.errorColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // TODO: Voir détails enseignant
                                  },
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Specialties Distribution
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Répartition par spécialité',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...specialites.map((specialite) {
                            final count = _enseignantsDetails.values
                                .where((e) => e.specialite == specialite)
                                .length;
                            final percentage = (count / _enseignants.length * 100);
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        specialite,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '$count enseignant(s) (${percentage.toStringAsFixed(1)}%)',
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: count / _enseignants.length,
                                    backgroundColor: AppTheme.backgroundColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getSpecialiteColor(specialite),
                                    ),
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quick Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actions rapides',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.5,
                            children: [
                              _buildActionTile(
                                icon: Icons.assignment,
                                title: 'Affecter matières',
                                onTap: () {
                                  // TODO: Affecter matières
                                },
                              ),
                              _buildActionTile(
                                icon: Icons.schedule,
                                title: 'Emploi du temps',
                                onTap: () {
                                  // TODO: Voir emploi du temps
                                },
                              ),
                              _buildActionTile(
                                icon: Icons.grade,
                                title: 'Notes à saisir',
                                onTap: () {
                                  // TODO: Voir notes à saisir
                                },
                              ),
                              _buildActionTile(
                                icon: Icons.download,
                                title: 'Exporter liste',
                                onTap: () {
                                  // TODO: Exporter liste
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Management Tools
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Générer rapport',
                            onPressed: () {
                              // TODO: Générer rapport
                            },
                            icon: Icons.description,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Répartir charges',
                            onPressed: () {
                              // TODO: Répartir charges
                            },
                            icon: Icons.balance,
                          ),
                        ),
                      ],
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

  Color _getEnseignantColor(String id) {
    final hash = id.hashCode;
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      AppTheme.infoColor,
      AppTheme.successColor,
    ];
    return colors[hash.abs() % colors.length];
  }

  Color _getSpecialiteColor(String specialite) {
    final hash = specialite.hashCode;
    final colors = [
      AppTheme.primaryColor,
      AppTheme.accentColor,
      AppTheme.secondaryColor,
      AppTheme.infoColor,
      Colors.purple,
      Colors.teal,
    ];
    return colors[hash.abs() % colors.length];
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, User enseignant) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'enseignant'),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer "${enseignant.prenom} ${enseignant.nom}" ? '
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
                  content: Text('Enseignant "${enseignant.prenom} ${enseignant.nom}" supprimé'),
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