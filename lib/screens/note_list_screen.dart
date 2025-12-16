import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/empty_state_widget.dart';
import 'package:parametragesschool/models/note_model.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:parametragesschool/models/matiere_model.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  // TODO: Remplacer par ViewModel/Provider pour données dynamiques
  List<Note> _notes = [];
  List<Etudiant> _etudiants = [];
  List<Matiere> _matieres = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _loadDemoData();
  }

  Future<void> _loadDemoData() async {
    // TODO: Remplacer par appel API/ViewModel
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _etudiants = [
        Etudiant(id: "1", nom: "Fall", prenom: "Medoune", matricule: "ETU001", classeId: "CLS001"),
        Etudiant(id: "2", nom: "Diop", prenom: "Awa", matricule: "ETU002", classeId: "CLS001"),
      ];
      
      _matieres = [
        Matiere(id: "1", nom: "Mathématiques", coefficient: 4),
        Matiere(id: "2", nom: "Physique", coefficient: 3),
        Matiere(id: "3", nom: "Français", coefficient: 2),
      ];
      
      _notes = [
        Note(
          id: "1",
          etudiantId: "1",
          matiereId: "1",
          valeur: 16.5,
          date: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Note(
          id: "2",
          etudiantId: "2",
          matiereId: "1",
          valeur: 14.0,
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Note(
          id: "3",
          etudiantId: "1",
          matiereId: "2",
          valeur: 18.0,
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];
      
      _isLoading = false;
    });
  }

  String _getEtudiantName(String etudiantId) {
    final etudiant = _etudiants.firstWhere(
      (e) => e.id == etudiantId,
      orElse: () => Etudiant(
        id: "",
        nom: "Inconnu",
        prenom: "",
        matricule: "",
        classeId: "",
      ),
    );
    return "${etudiant.prenom} ${etudiant.nom}";
  }

  String _getMatiereName(String matiereId) {
    final matiere = _matieres.firstWhere(
      (m) => m.id == matiereId,
      orElse: () => Matiere(id: "", nom: "Inconnue", coefficient: 1),
    );
    return matiere.nom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Gestion des notes',
              subtitle: 'Saisie et consultation des notes',
            ),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Filters
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedFilter,
                  decoration: const InputDecoration(
                    labelText: 'Filtrer par',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('Toutes les notes')),
                    DropdownMenuItem(value: 'recent', child: Text('Notes récentes')),
                    DropdownMenuItem(value: 'high', child: Text('Notes élevées')),
                    DropdownMenuItem(value: 'low', child: Text('Notes basses')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                      // TODO: Implémenter le filtrage via ViewModel
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              PrimaryButton(
                text: 'Ajouter',
                onPressed: () {
                  // TODO: Naviguer vers écran d'ajout de note
                },
                icon: Icons.add,
              ),
            ],
          ),
        ),
        
        // Statistics
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildStatCard('Notes', _notes.length.toString(), Icons.assignment),
              const SizedBox(width: 12),
              _buildStatCard('Moyenne', '15.2', Icons.trending_up),
              const SizedBox(width: 12),
              _buildStatCard('Élèves', _etudiants.length.toString(), Icons.people),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Notes List
        Expanded(
          child: _notes.isEmpty
              ? EmptyStateWidget(
                  title: 'Aucune note',
                  message: 'Aucune note n\'a été saisie pour le moment.',
                  icon: Icons.assignment,
                  buttonText: 'Ajouter une note',
                  onButtonPressed: () {
                    // TODO: Naviguer vers ajout
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    final note = _notes[index];
                    return _buildNoteCard(note);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: InfoCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Icon(icon, color: AppTheme.primaryColor),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getMatiereName(note.matiereId),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getEtudiantName(note.etudiantId),
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getNoteColor(note.valeur),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    note.valeur.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: AppTheme.textSecondary),
                const SizedBox(width: 6),
                Text(
                  '${note.date.day}/${note.date.month}/${note.date.year}',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    SecondaryButton(
                      text: 'Éditer',
                      onPressed: () {
                        // TODO: Éditer la note
                      },
                      fullWidth: false,
                      icon: Icons.edit,
                    ),
                    const SizedBox(width: 8),
                    SecondaryButton(
                      text: 'Supprimer',
                      onPressed: () {
                        _showDeleteDialog(note);
                      },
                      fullWidth: false,
                      icon: Icons.delete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getNoteColor(double valeur) {
    if (valeur >= 16) return AppTheme.successColor;
    if (valeur >= 10) return AppTheme.accentColor;
    return AppTheme.errorColor;
  }

  void _showDeleteDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la note'),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer la note de ${_getEtudiantName(note.etudiantId)} ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Supprimer',
            onPressed: () {
              // TODO: Appeler ViewModel pour suppression
              setState(() {
                _notes.removeWhere((n) => n.id == note.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Note supprimée'),
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