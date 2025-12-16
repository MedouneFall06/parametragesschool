import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/matiere_model.dart';
// ignore: unused_import
import 'package:parametragesschool/models/departement_model.dart';

// TODO: Transformer en StatefulWidget avec Provider
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
    Matiere(
      id: "MAT001",
      nom: "Mathématiques",
      coefficient: 4.0,
    ),
    Matiere(
      id: "MAT002",
      nom: "Physique-Chimie",
      coefficient: 3.0,
    ),
    Matiere(
      id: "MAT003",
      nom: "Français",
      coefficient: 3.0,
    ),
    Matiere(
      id: "MAT004",
      nom: "Anglais",
      coefficient: 2.0,
    ),
    Matiere(
      id: "MAT005",
      nom: "Histoire-Géographie",
      coefficient: 2.0,
    ),
    Matiere(
      id: "MAT006",
      nom: "SVT",
      coefficient: 2.0,
    ),
    Matiere(
      id: "MAT007",
      nom: "Philosophie",
      coefficient: 2.0,
    ),
    Matiere(
      id: "MAT008",
      nom: "EPS",
      coefficient: 1.0,
    ),
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
      bool matchesSearch = matiere.nom
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      
      bool matchesDepartement = _selectedDepartement == null ||
          (_matieresParDepartement[_selectedDepartement]?.contains(matiere.id) ?? false);
      
      return matchesSearch && matchesDepartement;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final totalCoefficient = _matieres
        .map((m) => m.coefficient)
        .reduce((a, b) => a + b);
    
    final moyenneCoefficient = totalCoefficient / _matieres.length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des matières',
              subtitle: 'Organisation des enseignements',
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
                            title: 'Matières totales',
                            value: _matieres.length.toString(),
                            icon: Icons.menu_book,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Coefficient total',
                            value: totalCoefficient.toStringAsFixed(1),
                            icon: Icons.calculate,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Moyenne coefficient',
                      value: moyenneCoefficient.toStringAsFixed(1),
                      icon: Icons.trending_up,
                      color: AppTheme.secondaryColor,
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
                              hintText: 'Rechercher une matière...',
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
                                  value: _selectedDepartement,
                                  decoration: const InputDecoration(
                                    labelText: 'Département (optionnel)',
                                    border: OutlineInputBorder(),
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
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Réinitialiser',
                                  onPressed: () {
                                    setState(() {
                                      _searchQuery = '';
                                      _selectedDepartement = null;
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
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Nouvelle matière',
                                onPressed: () {
                                  // TODO: Naviguer vers création de matière
                                },
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (filteredMatieres.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'Aucune matière ne correspond aux critères',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            )
                          else
                            ...filteredMatieres.map((matiere) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _getMatiereColor(matiere.nom),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getMatiereInitials(matiere.nom),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    matiere.nom,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.scale, size: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Coefficient: ${matiere.coefficient}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _getDepartementForMatiere(matiere.id),
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 13,
                                        ),
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
                                          // TODO: Éditer la matière
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            size: 20),
                                        onPressed: () {
                                          _showDeleteDialog(context, matiere);
                                        },
                                        color: AppTheme.errorColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // TODO: Voir détails de la matière
                                  },
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Coefficients Distribution
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Répartition des coefficients',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._matieres.map((matiere) {
                            final percentage = (matiere.coefficient / totalCoefficient * 100);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          matiere.nom,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${matiere.coefficient} (${percentage.toStringAsFixed(1)}%)',
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: matiere.coefficient / totalCoefficient,
                                    backgroundColor: AppTheme.backgroundColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getMatiereColor(matiere.nom),
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
                            childAspectRatio: 3,
                            children: [
                              _buildActionTile(
                                icon: Icons.people,
                                title: 'Affecter enseignants',
                                onTap: () {
                                  // TODO: Affecter enseignants
                                },
                              ),
                              _buildActionTile(
                                icon: Icons.school,
                                title: 'Associer aux classes',
                                onTap: () {
                                  // TODO: Associer aux classes
                                },
                              ),
                              _buildActionTile(
                                icon: Icons.download,
                                title: 'Exporter la liste',
                                onTap: () {
                                  // TODO: Exporter
                                },
                              ),
                              _buildActionTile(
                                icon: Icons.upload,
                                title: 'Importer matières',
                                onTap: () {
                                  // TODO: Importer
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Department Statistics
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Matières par département',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._departements.entries.map((departement) {
                            final matieresCount = _matieresParDepartement[departement.key]?.length ?? 0;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      departement.value,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      '$matieresCount matière(s)',
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
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
                    
                    // Management Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Réorganiser coefficients',
                            onPressed: () {
                              // TODO: Réorganiser coefficients
                            },
                            icon: Icons.tune,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Sauvegarder changements',
                            onPressed: () {
                              // TODO: Sauvegarder
                            },
                            icon: Icons.save,
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
              Icon(icon, color: AppTheme.primaryColor, size: 20),
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
              const Icon(Icons.chevron_right, size: 20, color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Matiere matiere) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la matière'),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer "${matiere.nom}" ? '
          'Cette action est irréversible et affectera toutes les notes associées.',
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