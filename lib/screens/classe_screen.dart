import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/classe_model.dart';
// ignore: unused_import
import 'package:parametragesschool/models/departement_model.dart';

// TODO: Transformer en StatefulWidget avec Provider
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
      bool matchesNiveau = _selectedNiveau == null || 
          classe.niveau == _selectedNiveau;
      
      bool matchesDepartement = _selectedDepartement == null || 
          classe.departementId == _selectedDepartement;
      
      return matchesNiveau && matchesDepartement;
    }).toList();

    // Calcul des statistiques (à déplacer dans ViewModel)
    final totalEtudiants = _effectifs.values.fold(0, (sum, effectif) => sum + effectif);
    final classesParNiveau = {
      'Terminale': _classes.where((c) => c.niveau == 'Terminale').length,
      'Première': _classes.where((c) => c.niveau == 'Première').length,
      'Seconde': _classes.where((c) => c.niveau == 'Seconde').length,
    };

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des classes',
              subtitle: 'Organisation des groupes d\'étudiants',
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
                            title: 'Classes totales',
                            value: _classes.length.toString(),
                            icon: Icons.class_,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Étudiants total',
                            value: totalEtudiants.toString(),
                            icon: Icons.people,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Moyenne par classe',
                      value: (totalEtudiants / _classes.length).toStringAsFixed(1),
                      icon: Icons.calculate,
                      color: AppTheme.secondaryColor,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filtres',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String?>(
                                  value: _selectedNiveau,
                                  decoration: const InputDecoration(
                                    labelText: 'Niveau (optionnel)',
                                    border: OutlineInputBorder(),
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
                              ),
                              const SizedBox(width: 12),
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
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Réinitialiser',
                                  onPressed: () {
                                    setState(() {
                                      _selectedNiveau = null;
                                      _selectedDepartement = null;
                                    });
                                  },
                                  icon: Icons.filter_alt_off,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Nouvelle classe',
                                  onPressed: () {
                                    // TODO: Naviguer vers création de classe
                                  },
                                  icon: Icons.add,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
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
                                style: const TextStyle(
                                  fontSize: 18,
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
                          const SizedBox(height: 16),
                          if (filteredClasses.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'Aucune classe ne correspond aux filtres',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            )
                          else
                            ...filteredClasses.map((classe) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _getClasseColor(classe.niveau),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getClasseInitials(classe.nom),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    classe.nom,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        '${classe.niveau} • ${_departements[classe.departementId] ?? 'Département inconnu'}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Effectif: ${_effectifs[classe.id] ?? 0} étudiants',
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
                                        icon: const Icon(Icons.people,
                                            size: 20),
                                        onPressed: () {
                                          // TODO: Voir étudiants de la classe
                                        },
                                        color: AppTheme.primaryColor,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            size: 20),
                                        onPressed: () {
                                          // TODO: Éditer la classe
                                        },
                                        color: AppTheme.accentColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // TODO: Voir détails de la classe
                                  },
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics by Level
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Répartition par niveau',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...classesParNiveau.entries.map((entry) {
                            final percentage = (entry.value / _classes.length * 100);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: entry.value / _classes.length,
                                    backgroundColor: AppTheme.backgroundColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getNiveauColor(entry.key),
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
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildQuickAction(
                                icon: Icons.schedule,
                                label: 'Emploi du temps',
                                onTap: () {
                                  // TODO: Voir emploi du temps
                                },
                              ),
                              _buildQuickAction(
                                icon: Icons.assignment,
                                label: 'Programmes',
                                onTap: () {
                                  // TODO: Voir programmes
                                },
                              ),
                              _buildQuickAction(
                                icon: Icons.people_alt,
                                label: 'Affecter enseignants',
                                onTap: () {
                                  // TODO: Affecter enseignants
                                },
                              ),
                              _buildQuickAction(
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
                    
                    const SizedBox(height: 32),
                    
                    // Export Options
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
                          child: SecondaryButton(
                            text: 'Importer classes',
                            onPressed: () {
                              // TODO: Importer depuis fichier
                            },
                            icon: Icons.upload,
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
    return nom.length >= 2 ? nom.substring(0, 2).toUpperCase() : nom.toUpperCase();
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryColor, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}