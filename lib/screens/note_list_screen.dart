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
import 'package:parametragesschool/core/constant/constants.dart';

// Constantes modifiables pour le responsive design
class NoteListConstants {
  // Padding général
  static const double paddingAll = 0.02;
  static const double paddingHorizontal = 0.02;
  static const double paddingVertical = 0.013;
  static const double paddingBetweenItems = 0.02;
  static const double paddingBetweenStats = 0.02;
  static const double paddingBetweenNotes = 0.01;
  
  // Filtre dropdown
  static const double filterLabelFontSize = 0.05;
  static const double filterContentPaddingHorizontal = 0.01;
  static const double filterContentPaddingVertical = 0.02;
  static const double filterItemFontSize = 0.03;
  static const double filterMinHeight = 0.12; // Hauteur minimale pour écrans grands
  
  // Statistiques
  static const double statTitleFontSize = 0.04;//0.025;
  static const double statIconSize = 0.04;
  static const double statValueFontSize = 0.05;//0.045;
  static const double statSpacing = 0.015;
  
  // Cartes de notes
  static const double noteCardPadding = 0.02;
  static const double noteMatiereFontSize = 0.05;//0.035;
  static const double noteEtudiantFontSize = 0.05;//0.03;
  static const double noteValueFontSize = 0.05;//0.035;
  static const double noteDateFontSize = 0.05;//0.03;
  static const double noteIconSize = 0.05;//0.018;
  static const double noteIconSpacing = 0.01;
  static const double editButtonIconSize = 0.04;
  static const double deleteButtonIconSize = 0.04;
  static const double editButtonTextSize = 0.04;
  static const double deleteButtonTextSize = 0.04;
  
  // Espacements
  static const double spacingSmall = 0.01;
  static const double spacingMedium = 0.006;
  static const double spacingLarge = 0.01;
  static const double spacingExtraLarge = 0.015;
}

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
        // Filters and Add Button aligned
        SizedBox(height: MediaQuery.of(context).size.height * NoteListConstants.spacingSmall),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * NoteListConstants.paddingHorizontal),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedFilter,
                  decoration: InputDecoration(
                    labelText: 'Filtrer par',
                    labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.width * NoteListConstants.filterLabelFontSize),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * NoteListConstants.filterContentPaddingHorizontal,
                      vertical: MediaQuery.of(context).size.height * NoteListConstants.filterContentPaddingVertical,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * NoteListConstants.filterMinHeight,
                    ),
                  ),
                  items: [
                    DropdownMenuItem(value: 'all', child: Text('Toutes les notes', style: TextStyle(fontSize: MediaQuery.of(context).size.width * NoteListConstants.filterItemFontSize))),
                    DropdownMenuItem(value: 'recent', child: Text('Notes récentes', style: TextStyle(fontSize: MediaQuery.of(context).size.width * NoteListConstants.filterItemFontSize))),
                    DropdownMenuItem(value: 'high', child: Text('Notes élevées', style: TextStyle(fontSize: MediaQuery.of(context).size.width * NoteListConstants.filterItemFontSize))),
                    DropdownMenuItem(value: 'low', child: Text('Notes basses', style: TextStyle(fontSize: MediaQuery.of(context).size.width * NoteListConstants.filterItemFontSize))),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                      // TODO: Implémenter le filtrage via ViewModel
                    });
                  },
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * NoteListConstants.paddingBetweenItems),
              Container(
                margin: EdgeInsets.only(top: AppConstants.heightPercentage(context, AppConstants.paddingVertical)),
                child: PrimaryButton(
                  text: 'Ajouter',
                  onPressed: () {
                    // TODO: Naviguer vers écran d'ajout de note
                  },
                  icon: Icons.add,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * NoteListConstants.spacingSmall),
        
        // Notes List with Statistics
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
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * NoteListConstants.paddingAll),
                  itemCount: _notes.length + 1, // +1 pour les statistiques en haut de la liste
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Afficher les statistiques en haut de la liste défilante
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppConstants.widthPercentage(context, NoteListConstants.paddingHorizontal)),
                            child: Row(
                              children: [
                                _buildStatCard('Notes', _notes.length.toString(), Icons.assignment),
                                SizedBox(width: AppConstants.widthPercentage(context, NoteListConstants.paddingBetweenStats)),
                                _buildStatCard('Moyenne', '15.2', Icons.trending_up),
                                SizedBox(width: AppConstants.widthPercentage(context, NoteListConstants.paddingBetweenStats)),
                                _buildStatCard('Élèves', _etudiants.length.toString(), Icons.people),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * NoteListConstants.spacingSmall),
                        ],
                      );
                    }
                    final note = _notes[index - 1];
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
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * NoteListConstants.statTitleFontSize,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Icon(icon, color: AppTheme.primaryColor, size: MediaQuery.of(context).size.width * NoteListConstants.statIconSize),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * NoteListConstants.statSpacing),
            Text(
              value,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * NoteListConstants.statValueFontSize,
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
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * NoteListConstants.paddingBetweenNotes),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * NoteListConstants.paddingAll),
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
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * NoteListConstants.noteMatiereFontSize,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * NoteListConstants.spacingLarge),
                    Text(
                      _getEtudiantName(note.etudiantId),
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: MediaQuery.of(context).size.width * NoteListConstants.noteEtudiantFontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * NoteListConstants.noteCardPadding,
                  vertical: MediaQuery.of(context).size.height * NoteListConstants.spacingMedium,
                ),
                decoration: BoxDecoration(
                  color: _getNoteColor(note.valeur),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  note.valeur.toStringAsFixed(1),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * NoteListConstants.noteValueFontSize,
                  ),
                ),
              ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * NoteListConstants.spacingLarge),
            Row(
              children: [
                Icon(Icons.calendar_today, size: MediaQuery.of(context).size.width * NoteListConstants.noteDateFontSize, color: AppTheme.textSecondary),
                SizedBox(width: MediaQuery.of(context).size.width * NoteListConstants.noteIconSpacing),
                Text(
                  '${note.date.day}/${note.date.month}/${note.date.year}',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: MediaQuery.of(context).size.width * NoteListConstants.noteDateFontSize,
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
                      iconSize: MediaQuery.of(context).size.width * NoteListConstants.editButtonIconSize,
                      fontSize: MediaQuery.of(context).size.width * NoteListConstants.editButtonTextSize,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * NoteListConstants.spacingSmall),
                    SecondaryButton(
                      text: 'Supprimer',
                      onPressed: () {
                        _showDeleteDialog(note);
                      },
                      fullWidth: false,
                      icon: Icons.delete,
                      iconSize: MediaQuery.of(context).size.width * NoteListConstants.deleteButtonIconSize,
                      fontSize: MediaQuery.of(context).size.width * NoteListConstants.deleteButtonTextSize,
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
