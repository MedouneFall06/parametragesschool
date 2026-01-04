import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/enseignant_model.dart';
import 'package:parametragesschool/models/user_model.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

// Constantes modifiables pour le responsive design
class EnseignantScreenConstants {
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
  
  // Cartes d'enseignants
  static const double teacherCardPadding = 0.02;
  static const double teacherAvatarSize = 0.08;
  static const double teacherTitleFontSize = 0.025;
  static const double teacherSubtitleFontSize = 0.018;
  static const double teacherInfoFontSize = 0.016;
  static const double teacherIconSize = 0.025;
  
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
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingAll),
                child: Column(
                  children: [
                    // Statistics
                    ResponsiveGrid(
                      customSpacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingBetweenStats,
                      children: [
                        StatCard(
                          title: 'Enseignants',
                          value: _enseignants.length.toString(),
                          icon: Icons.people,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Spécialités',
                          value: specialites.length.toString(),
                          icon: Icons.school,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                    
                    ResponsiveGrid(
                      customSpacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingBetweenStats,
                      children: [
                        StatCard(
                          title: 'Classes couvertes',
                          value: totalClasses.toString(),
                          icon: Icons.class_,
                          color: AppTheme.secondaryColor,
                        ),
                        StatCard(
                          title: 'Matières enseignées',
                          value: _matieresEnseignants.values
                              .expand((list) => list)
                              .toSet()
                              .length
                              .toString(),
                          icon: Icons.menu_book,
                          color: AppTheme.infoColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingExtraLarge),
                    
                    // Search and Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recherche et filtres',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.statTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
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
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * EnseignantScreenConstants.searchContentPaddingHorizontal,
                                vertical: MediaQuery.of(context).size.height * EnseignantScreenConstants.searchContentPaddingVertical,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.searchHintFontSize,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                          ResponsiveGrid(
                            customSpacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingBetweenItems,
                            children: [
                              DropdownButtonFormField<String?>(
                                value: _selectedSpecialite,
                                decoration: InputDecoration(
                                  labelText: 'Spécialité (optionnel)',
                                  labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.searchLabelFontSize),
                                  border: const OutlineInputBorder(),
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
                              SecondaryButton(
                                text: 'Réinitialiser',
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                    _selectedSpecialite = null;
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
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingExtraLarge),
                    
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
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.statTitleFontSize,
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
                          SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                          if (filteredEnseignants.isEmpty)
                            Padding(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingAll),
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
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * EnseignantScreenConstants.paddingBetweenCards),
                                child: ListTile(
                                  leading: Container(
                                    width: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherAvatarSize,
                                    height: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherAvatarSize,
                                    decoration: BoxDecoration(
                                      color: _getEnseignantColor(enseignant.id),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getInitials(enseignant.prenom, enseignant.nom),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherTitleFontSize,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${enseignant.prenom} ${enseignant.nom}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherTitleFontSize,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                                      if (details != null)
                                        Text(
                                          details.specialite,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherSubtitleFontSize,
                                          ),
                                        ),
                                      SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                                      Text(
                                        enseignant.email,
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherInfoFontSize,
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                                      Wrap(
                                        spacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.spacingSmall,
                                        runSpacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.spacingSmall,
                                        children: [
                                          ...matieres.take(2).map((matiere) {
                                            return Chip(
                                              label: Text(
                                                matiere,
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherInfoFontSize),
                                              ),
                                              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                              labelPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * EnseignantScreenConstants.spacingSmall),
                                            );
                                          }).toList(),
                                          if (matieres.length > 2)
                                            Chip(
                                              label: Text(
                                                '+${matieres.length - 2}',
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherInfoFontSize),
                                              ),
                                              backgroundColor: AppTheme.textSecondary.withOpacity(0.1),
                                              labelPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * EnseignantScreenConstants.spacingSmall),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            size: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherIconSize),
                                        onPressed: () {
                                          // TODO: Éditer enseignant
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            size: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherIconSize),
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
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingExtraLarge),
                    
                    // Specialties Distribution
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Répartition par spécialité',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.statTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                          ...specialites.map((specialite) {
                            final count = _enseignantsDetails.values
                                .where((e) => e.specialite == specialite)
                                .length;
                            final percentage = (count / _enseignants.length * 100);
                            
                            return Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
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
                                  SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
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
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingExtraLarge),
                    
                    // Quick Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Actions rapides',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.statTitleFontSize,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingSmall),
                          ResponsiveGrid(
                            customSpacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingBetweenItems,
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
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingExtraLarge),
                    
                    // Management Tools
                    ResponsiveGrid(
                      customSpacing: MediaQuery.of(context).size.width * EnseignantScreenConstants.paddingBetweenItems,
                      children: [
                        SecondaryButton(
                          text: 'Générer rapport',
                          onPressed: () {
                            // TODO: Générer rapport
                          },
                          icon: Icons.description,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Répartir charges',
                          onPressed: () {
                            // TODO: Répartir charges
                          },
                          icon: Icons.balance,
                          fullWidth: true,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * EnseignantScreenConstants.spacingExtraLarge),
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherCardPadding),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherAvatarSize,
                height: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherAvatarSize,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppTheme.primaryColor, size: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherIconSize),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * EnseignantScreenConstants.spacingSmall),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * EnseignantScreenConstants.teacherSubtitleFontSize,
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
