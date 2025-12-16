import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/models/emploi_du_temps_model.dart';
// ignore: unused_import
import 'package:parametragesschool/models/classe_model.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer EmploiDuTempsViewModel
// TODO: Récupérer emploi du temps depuis l'API/BDD
// TODO: Implémenter CRUD des séances
// TODO: Gérer états loading/error
// TODO: Ajouter vue semaine/mois

class EmploiDuTempsScreen extends StatefulWidget {
  const EmploiDuTempsScreen({super.key});

  @override
  State<EmploiDuTempsScreen> createState() => _EmploiDuTempsScreenState();
}

class _EmploiDuTempsScreenState extends State<EmploiDuTempsScreen> {
  // Données fictives pour l'affichage statique
  final List<EmploiDuTemps> _seances = [
    EmploiDuTemps(
      id: "1",
      classeId: "CLS001",
      matiereId: "MAT001",
      enseignantId: "ENS001",
      jour: "Lundi",
      heure: "08:00 - 10:00",
    ),
    EmploiDuTemps(
      id: "2",
      classeId: "CLS001",
      matiereId: "MAT002",
      enseignantId: "ENS002",
      jour: "Lundi",
      heure: "10:15 - 12:15",
    ),
    EmploiDuTemps(
      id: "3",
      classeId: "CLS001",
      matiereId: "MAT003",
      enseignantId: "ENS003",
      jour: "Mardi",
      heure: "08:00 - 10:00",
    ),
    EmploiDuTemps(
      id: "4",
      classeId: "CLS001",
      matiereId: "MAT004",
      enseignantId: "ENS004",
      jour: "Mardi",
      heure: "14:00 - 16:00",
    ),
    EmploiDuTemps(
      id: "5",
      classeId: "CLS002",
      matiereId: "MAT001",
      enseignantId: "ENS001",
      jour: "Mercredi",
      heure: "08:00 - 10:00",
    ),
    EmploiDuTemps(
      id: "6",
      classeId: "CLS002",
      matiereId: "MAT005",
      enseignantId: "ENS005",
      jour: "Jeudi",
      heure: "10:15 - 12:15",
    ),
    EmploiDuTemps(
      id: "7",
      classeId: "CLS003",
      matiereId: "MAT006",
      enseignantId: "ENS006",
      jour: "Vendredi",
      heure: "14:00 - 16:00",
    ),
  ];

  final Map<String, String> _classes = {
    "CLS001": "Terminale S1",
    "CLS002": "Terminale S2",
    "CLS003": "Première L1",
  };

  final Map<String, String> _matieres = {
    "MAT001": "Mathématiques",
    "MAT002": "Physique",
    "MAT003": "Français",
    "MAT004": "Anglais",
    "MAT005": "Histoire",
    "MAT006": "SVT",
  };

  final Map<String, String> _enseignants = {
    "ENS001": "M. Diallo",
    "ENS002": "Mme. Ndiaye",
    "ENS003": "M. Sow",
    "ENS004": "Mme. Traoré",
    "ENS005": "M. Ba",
    "ENS006": "Mme. Fall",
  };

  String? _selectedClasse = "CLS001";
  String _selectedJour = "Lundi";
  bool _vueSemaine = true;

  final List<String> _jours = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "Jeudi",
    "Vendredi",
    "Samedi",
  ];

  final List<String> _creneaux = [
    "08:00 - 10:00",
    "10:15 - 12:15",
    "14:00 - 16:00",
    "16:15 - 18:15",
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrage des séances (à déplacer dans ViewModel)
    List<EmploiDuTemps> seancesFiltrees = _seances.where((seance) {
      bool matchesClasse = _selectedClasse == null ||
          seance.classeId == _selectedClasse;
      
      bool matchesJour = !_vueSemaine || seance.jour == _selectedJour;
      
      return matchesClasse && matchesJour;
    }).toList();

    // Organisation par jour et créneau (à déplacer dans ViewModel)
    Map<String, Map<String, EmploiDuTemps?>> emploiParJour = {};
    
    for (final jour in _vueSemaine ? [_selectedJour] : _jours) {
      emploiParJour[jour] = {};
      for (final creneau in _creneaux) {
        final seance = seancesFiltrees.firstWhere(
          (s) => s.jour == jour && s.heure == creneau,
          orElse: () => EmploiDuTemps(
            id: "",
            classeId: "",
            matiereId: "",
            enseignantId: "",
            jour: jour,
            heure: creneau,
          ),
        );
        emploiParJour[jour]![creneau] = seance.id.isNotEmpty ? seance : null;
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Emploi du temps',
              subtitle: 'Planning des cours',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Sélection et filtres
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sélection',
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
                                  value: _selectedClasse,
                                  decoration: const InputDecoration(
                                    labelText: 'Classe',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: [
                                    ..._classes.entries.map((entry) {
                                      return DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value),
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedClasse = value;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (_vueSemaine)
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedJour,
                                    decoration: const InputDecoration(
                                      labelText: 'Jour',
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    items: _jours.map((jour) {
                                      return DropdownMenuItem(
                                        value: jour,
                                        child: Text(jour),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedJour = value!;
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
                                  text: _vueSemaine ? 'Vue semaine' : 'Vue jour',
                                  onPressed: () {
                                    setState(() {
                                      _vueSemaine = !_vueSemaine;
                                    });
                                  },
                                  icon: _vueSemaine
                                      ? Icons.calendar_view_week
                                      : Icons.calendar_today,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Nouvelle séance',
                                  onPressed: () {
                                    // TODO: Ajouter séance
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
                    
                    // Emploi du temps
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _vueSemaine
                                    ? 'Emploi du temps - $_selectedJour'
                                    : 'Semaine du 15 Jan 2024',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // TODO: Exporter emploi du temps
                                },
                                icon: const Icon(Icons.download),
                                tooltip: 'Exporter',
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          if (_vueSemaine)
                            _buildDayView(emploiParJour[_selectedJour]!)
                          else
                            _buildWeekView(emploiParJour),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistiques
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Statistiques',
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
                                child: _buildStatItem(
                                  label: 'Heures totales',
                                  value: '${seancesFiltrees.length * 2}h',
                                  icon: Icons.access_time,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatItem(
                                  label: 'Matières',
                                  value: '${_getMatieresUniques(seancesFiltrees)}',
                                  icon: Icons.menu_book,
                                  color: AppTheme.accentColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildStatItem(
                                  label: 'Enseignants',
                                  value: '${_getEnseignantsUniques(seancesFiltrees)}',
                                  icon: Icons.people,
                                  color: AppTheme.secondaryColor,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildStatItem(
                                  label: 'Séances/semaine',
                                  value: '${seancesFiltrees.length}',
                                  icon: Icons.event,
                                  color: AppTheme.infoColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Séances à venir
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Séances à venir',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...seancesFiltrees.take(3).map((seance) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _getJourColor(seance.jour),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getJourInitial(seance.jour),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    _matieres[seance.matiereId] ?? 'Matière inconnue',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        '${seance.jour} ${seance.heure}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _enseignants[seance.enseignantId] ?? 'Enseignant inconnu',
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                  onTap: () {
                                    // TODO: Voir détails séance
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                          if (seancesFiltrees.length > 3)
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  // TODO: Voir toutes les séances
                                },
                                child: const Text('Voir toutes les séances'),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Générer PDF',
                            onPressed: () {
                              // TODO: Générer PDF
                            },
                            icon: Icons.picture_as_pdf,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Partager',
                            onPressed: () {
                              // TODO: Partager emploi du temps
                            },
                            icon: Icons.share,
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

  Widget _buildDayView(Map<String, EmploiDuTemps?> seancesJour) {
    return Column(
      children: _creneaux.map((creneau) {
        final seance = seancesJour[creneau];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: Card(
            child: ListTile(
              leading: Container(
                width: 60,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: seance != null
                      ? _getMatiereColor(seance.matiereId)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    creneau.split(' ')[0],
                    style: TextStyle(
                      color: seance != null ? Colors.white : AppTheme.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: seance != null
                  ? Text(
                      _matieres[seance.matiereId] ?? 'Matière inconnue',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const Text(
                      'Libre',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
              subtitle: seance != null
                  ? Text(_enseignants[seance.enseignantId] ?? '')
                  : null,
              trailing: seance != null
                  ? IconButton(
                      icon: const Icon(Icons.info_outline, size: 20),
                      onPressed: () {
                        // TODO: Voir détails
                      },
                      color: AppTheme.primaryColor,
                    )
                  : IconButton(
                      icon: const Icon(Icons.add, size: 20),
                      onPressed: () {
                        // TODO: Ajouter séance
                      },
                      color: AppTheme.primaryColor,
                    ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildWeekView(Map<String, Map<String, EmploiDuTemps?>> emploiSemaine) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('Créneau')),
          ..._jours.map((jour) {
            return DataColumn(
              label: SizedBox(
                width: 120,
                child: Text(
                  jour,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            );
          }).toList(),
        ],
        rows: _creneaux.map((creneau) {
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 80,
                  child: Text(
                    creneau,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ..._jours.map((jour) {
                final seance = emploiSemaine[jour]![creneau];
                return DataCell(
                  seance != null
                      ? Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _getMatiereColor(seance.matiereId),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _matieres[seance.matiereId] ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _enseignants[seance.enseignantId] ?? '',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getMatiereColor(String matiereId) {
    final hash = matiereId.hashCode;
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

  Color _getJourColor(String jour) {
    switch (jour) {
      case 'Lundi':
        return AppTheme.primaryColor;
      case 'Mardi':
        return AppTheme.accentColor;
      case 'Mercredi':
        return AppTheme.secondaryColor;
      case 'Jeudi':
        return AppTheme.infoColor;
      case 'Vendredi':
        return AppTheme.successColor;
      case 'Samedi':
        return AppTheme.warningColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getJourInitial(String jour) {
    return jour.substring(0, 1);
  }

  int _getMatieresUniques(List<EmploiDuTemps> seances) {
    final matieres = seances.map((s) => s.matiereId).toSet();
    return matieres.length;
  }

  int _getEnseignantsUniques(List<EmploiDuTemps> seances) {
    final enseignants = seances.map((s) => s.enseignantId).toSet();
    return enseignants.length;
  }
}