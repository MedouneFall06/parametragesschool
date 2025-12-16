import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/models/note_model.dart';

// TODO: Transformer en StatefulWidget avec Provider
// TODO: Créer NoteViewModel
// TODO: Récupérer notes depuis l'API/BDD
// TODO: Implémenter CRUD des notes
// TODO: Ajouter statistiques dynamiques
// TODO: Gérer états loading/error

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  // Données fictives pour l'affichage statique
  final List<Note> _notes = [
    Note(
      id: "1",
      etudiantId: "1",
      matiereId: "1",
      valeur: 16.0,
      date: DateTime(2024, 1, 15),
    ),
    Note(
      id: "2",
      etudiantId: "1",
      matiereId: "2",
      valeur: 14.5,
      date: DateTime(2024, 1, 14),
    ),
    Note(
      id: "3",
      etudiantId: "2",
      matiereId: "1",
      valeur: 12.0,
      date: DateTime(2024, 1, 13),
    ),
    Note(
      id: "4",
      etudiantId: "3",
      matiereId: "3",
      valeur: 18.0,
      date: DateTime(2024, 1, 12),
    ),
  ];

  final Map<String, String> _etudiants = {
    "1": "Medoune Fall",
    "2": "Awa Diop",
    "3": "Moussa Ndoye",
  };

  final Map<String, String> _matieres = {
    "1": "Mathématiques",
    "2": "Physique",
    "3": "Français",
    "4": "Anglais",
  };

  String _selectedMatiere;
  String? _selectedEtudiant;
  DateTimeRange? _dateRange;

  _NoteScreenState() : _selectedMatiere = "1";

  @override
  Widget build(BuildContext context) {
    // Calcul des statistiques (à déplacer dans ViewModel)
    final double moyenneGenerale = _notes.isNotEmpty
        ? _notes.map((n) => n.valeur).reduce((a, b) => a + b) / _notes.length
        : 0.0;

    final notesMatiere = _notes
        .where((n) => n.matiereId == _selectedMatiere)
        .toList();

    final double moyenneMatiere = notesMatiere.isNotEmpty
        ? notesMatiere.map((n) => n.valeur).reduce((a, b) => a + b) / notesMatiere.length
        : 0.0;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Gestion des notes',
              subtitle: 'Saisie et consultation',
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
                            title: 'Moyenne générale',
                            value: moyenneGenerale.toStringAsFixed(2),
                            icon: Icons.assessment,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Notes totales',
                            value: _notes.length.toString(),
                            icon: Icons.grade,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Moyenne ${_matieres[_selectedMatiere]}',
                      value: moyenneMatiere.toStringAsFixed(2),
                      icon: Icons.school,
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
                                child: DropdownButtonFormField<String>(
                                  value: _selectedMatiere,
                                  decoration: const InputDecoration(
                                    labelText: 'Matière',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: _matieres.entries.map((entry) {
                                    return DropdownMenuItem(
                                      value: entry.key,
                                      child: Text(entry.value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMatiere = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String?>(
                                  value: _selectedEtudiant,
                                  decoration: const InputDecoration(
                                    labelText: 'Étudiant (optionnel)',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                      value: null,
                                      child: Text('Tous les étudiants'),
                                    ),
                                    ..._etudiants.entries.map((entry) {
                                      return DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value),
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedEtudiant = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final DateTimeRange? picked = await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2023, 1, 1),
                                      lastDate: DateTime(2024, 12, 31),
                                      currentDate: DateTime.now(),
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        _dateRange = picked;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppTheme.textPrimary,
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    _dateRange != null
                                        ? '${_dateRange!.start.day}/${_dateRange!.start.month} - ${_dateRange!.end.day}/${_dateRange!.end.month}'
                                        : 'Période (optionnel)',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SecondaryButton(
                                text: 'Réinitialiser',
                                onPressed: () {
                                  setState(() {
                                    _selectedEtudiant = null;
                                    _dateRange = null;
                                  });
                                },
                                icon: Icons.filter_alt_off,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Notes List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Liste des notes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Nouvelle note',
                                onPressed: () {
                                  // TODO: Naviguer vers ajout de note
                                },
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (notesMatiere.isEmpty)
                            const Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                'Aucune note pour cette matière',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            )
                          else
                            ...notesMatiere.map((note) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: _getNoteColor(note.valeur),
                                      child: Text(
                                        note.valeur.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      _etudiants[note.etudiantId] ?? 'Étudiant inconnu',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${note.date.day}/${note.date.month}/${note.date.year}',
                                      style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              size: 20),
                                          onPressed: () {
                                            // TODO: Éditer la note
                                          },
                                          color: AppTheme.primaryColor,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              size: 20),
                                          onPressed: () {
                                            _showDeleteDialog(context, note);
                                          },
                                          color: AppTheme.errorColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics by Subject
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Statistiques par matière',
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Répartition des notes',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    ..._matieres.entries.map((matiere) {
                                      final matiereNotes = _notes
                                          .where((n) => n.matiereId == matiere.key)
                                          .toList();
                                      final moyenne = matiereNotes.isNotEmpty
                                          ? matiereNotes.map((n) => n.valeur).reduce((a, b) => a + b) / matiereNotes.length
                                          : 0.0;
                                      
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                matiere.value,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: _getNoteColor(moyenne),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                moyenne > 0 ? moyenne.toStringAsFixed(1) : '-',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
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
                            text: 'Exporter en PDF',
                            onPressed: () {
                              // TODO: Exporter en PDF
                            },
                            icon: Icons.picture_as_pdf,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SecondaryButton(
                            text: 'Exporter en Excel',
                            onPressed: () {
                              // TODO: Exporter en Excel
                            },
                            icon: Icons.table_chart,
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

  Color _getNoteColor(double note) {
    if (note >= 16) return AppTheme.successColor;
    if (note >= 14) return AppTheme.accentColor;
    if (note >= 10) return AppTheme.infoColor;
    return AppTheme.errorColor;
  }

  void _showDeleteDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la note'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cette note ? Cette action est irréversible.'),
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
                const SnackBar(
                  content: Text('Note supprimée'),
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