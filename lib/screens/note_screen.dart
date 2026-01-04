import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/responsive/responsive_wrapper.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
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
              child: ResponsiveWrapper(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * 0.04 : 
                                 MediaQuery.of(context).size.width < 1200 ? MediaQuery.of(context).size.width * 0.02 : MediaQuery.of(context).size.width * 0.015,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Column(
                    children: [
                      // Statistics
                      ResponsiveGrid(
                        children: [
                          StatCard(
                            title: 'Moyenne générale',
                            value: moyenneGenerale.toStringAsFixed(2),
                            icon: Icons.assessment,
                            color: AppTheme.primaryColor,
                          ),
                          StatCard(
                            title: 'Notes totales',
                            value: _notes.length.toString(),
                            icon: Icons.grade,
                            color: AppTheme.accentColor,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      
                      StatCard(
                        title: 'Moyenne ${_matieres[_selectedMatiere]}',
                        value: moyenneMatiere.toStringAsFixed(2),
                        icon: Icons.school,
                        color: AppTheme.secondaryColor,
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
                      // Filters
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Filtres',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.025,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                            ResponsiveGrid(
                              children: [
                                DropdownButtonFormField<String>(
                                  value: _selectedMatiere,
                                  decoration: InputDecoration(
                                    labelText: 'Matière',
                                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.014),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.02,
                                      vertical: MediaQuery.of(context).size.height * 0.015,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
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
                                DropdownButtonFormField<String?>(
                                  value: _selectedEtudiant,
                                  decoration: InputDecoration(
                                    labelText: 'Étudiant (optionnel)',
                                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.014),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery.of(context).size.width * 0.02,
                                      vertical: MediaQuery.of(context).size.height * 0.015,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
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
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
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
                                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
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
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
                      // Notes List
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Liste des notes',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.025,
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
                            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
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
                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: MediaQuery.of(context).size.width * 0.05,
                                        backgroundColor: _getNoteColor(note.valeur),
                                        child: Text(
                                          note.valeur.toStringAsFixed(1),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.width * 0.015,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        _etudiants[note.etudiantId] ?? 'Étudiant inconnu',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: MediaQuery.of(context).size.width * 0.016,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        '${note.date.day}/${note.date.month}/${note.date.year}',
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: MediaQuery.of(context).size.width * 0.012,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit,
                                                size: MediaQuery.of(context).size.width * 0.02),
                                            onPressed: () {
                                              // TODO: Éditer la note
                                            },
                                            color: AppTheme.primaryColor,
                                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete,
                                                size: MediaQuery.of(context).size.width * 0.02),
                                            onPressed: () {
                                              _showDeleteDialog(context, note);
                                            },
                                            color: AppTheme.errorColor,
                                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
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
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      
                      // Statistics by Subject
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Statistiques par matière',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.025,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                            ResponsiveGrid(
                              children: _matieres.entries.map((matiere) {
                                final matiereNotes = _notes
                                    .where((n) => n.matiereId == matiere.key)
                                    .toList();
                                final moyenne = matiereNotes.isNotEmpty
                                    ? matiereNotes.map((n) => n.valeur).reduce((a, b) => a + b) / matiereNotes.length
                                    : 0.0;
                                
                                return Container(
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
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
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        matiere.value,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.018,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Moyenne',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.011,
                                                color: AppTheme.textSecondary,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context).size.width * 0.015,
                                              vertical: MediaQuery.of(context).size.height * 0.004,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getNoteColor(moyenne),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              moyenne > 0 ? moyenne.toStringAsFixed(1) : '-',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.width * 0.011,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      
                      // Export Options
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Supprimer la note',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.025,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                            ResponsiveGrid(
                              children: [
                                SecondaryButton(
                                  text: 'Exporter en PDF',
                                  onPressed: () {
                                    // TODO: Exporter en PDF
                                  },
                                  icon: Icons.picture_as_pdf,
                                  fullWidth: MediaQuery.of(context).size.width < 600,
                                ),
                                SecondaryButton(
                                  text: 'Exporter en Excel',
                                  onPressed: () {
                                    // TODO: Exporter en Excel
                                  },
                                  icon: Icons.table_chart,
                                  fullWidth: MediaQuery.of(context).size.width < 600,
                                ),
                                SecondaryButton(
                                  text: 'Exporter en CSV',
                                  onPressed: () {
                                    // TODO: Exporter en CSV
                                  },
                                  icon: Icons.download,
                                  fullWidth: MediaQuery.of(context).size.width < 600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                    ],
                  ),
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
