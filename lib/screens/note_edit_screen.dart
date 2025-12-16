import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/form_text_field.dart';
import 'package:parametragesschool/models/note_model.dart';
import 'package:parametragesschool/models/etudiant_model.dart';
import 'package:parametragesschool/models/matiere_model.dart';

class NoteEditScreen extends StatefulWidget {
  final Note? note; // null pour création, non-null pour édition
  final List<Etudiant> etudiants;
  final List<Matiere> matieres;
  
  const NoteEditScreen({
    super.key,
    this.note,
    required this.etudiants,
    required this.matieres,
  });

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedEtudiantId;
  late String _selectedMatiereId;
  final TextEditingController _valeurController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    
    // TODO: Remplacer par initialisation via ViewModel
    if (widget.note != null) {
      // Mode édition
      _selectedEtudiantId = widget.note!.etudiantId;
      _selectedMatiereId = widget.note!.matiereId;
      _valeurController.text = widget.note!.valeur.toString();
    } else {
      // Mode création
      _selectedEtudiantId = widget.etudiants.isNotEmpty ? widget.etudiants.first.id : '';
      _selectedMatiereId = widget.matieres.isNotEmpty ? widget.matieres.first.id : '';
    }
  }

  @override
  void dispose() {
    _valeurController.dispose();
    _commentaireController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // TODO: Remplacer par appel ViewModel/API
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isSubmitting = false;
      });

      // TODO: Navigation via ViewModel
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.note != null 
                ? 'Note mise à jour' 
                : 'Note ajoutée',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: widget.note != null ? 'Modifier la note' : 'Nouvelle note',
              subtitle: widget.note != null ? 'Éditer une note existante' : 'Saisir une nouvelle note',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Student Selection
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Élève',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: _selectedEtudiantId,
                              decoration: const InputDecoration(
                                labelText: 'Sélectionner un élève',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: widget.etudiants.map((etudiant) {
                                return DropdownMenuItem(
                                  value: etudiant.id,
                                  child: Text('${etudiant.prenom} ${etudiant.nom} (${etudiant.matricule})'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedEtudiantId = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner un élève';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Subject Selection
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Matière',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: _selectedMatiereId,
                              decoration: const InputDecoration(
                                labelText: 'Sélectionner une matière',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: widget.matieres.map((matiere) {
                                return DropdownMenuItem(
                                  value: matiere.id,
                                  child: Text('${matiere.nom} (coef. ${matiere.coefficient})'),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMatiereId = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez sélectionner une matière';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Grade Input
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Note',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            FormTextField(
                              controller: _valeurController,
                              label: 'Valeur (sur 20)',
                              hintText: 'Ex: 15.5',
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer une note';
                                }
                                final doubleValue = double.tryParse(value);
                                if (doubleValue == null) {
                                  return 'Veuillez entrer un nombre valide';
                                }
                                if (doubleValue < 0 || doubleValue > 20) {
                                  return 'La note doit être entre 0 et 20';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Comment
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Commentaire (optionnel)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            FormTextField(
                              controller: _commentaireController,
                              label: 'Commentaire',
                              hintText: 'Remarques sur la note...',
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Grade Scale Reference
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Référence des notes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildGradeReference(),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: 'Annuler',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icons.cancel,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: PrimaryButton(
                              text: _isSubmitting
                                  ? (widget.note != null ? 'Mise à jour...' : 'Enregistrement...')
                                  : (widget.note != null ? 'Mettre à jour' : 'Enregistrer'),
                              onPressed: _isSubmitting ? null : _submitForm,
                              icon: widget.note != null ? Icons.update : Icons.save,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
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

  Widget _buildGradeReference() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
          ),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Intervalle', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Note', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text('Appréciation', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        _buildGradeRow('16-20', 'TB', AppTheme.successColor),
        _buildGradeRow('14-15.9', 'B', AppTheme.accentColor),
        _buildGradeRow('12-13.9', 'AB', Colors.orange),
        _buildGradeRow('10-11.9', 'P', Colors.yellow[700]!),
        _buildGradeRow('0-9.9', 'I', AppTheme.errorColor),
      ],
    );
  }

  TableRow _buildGradeRow(String interval, String grade, Color color) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(interval),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color),
            ),
            child: Text(
              grade,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            _getAppreciation(grade),
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
      ],
    );
  }

  String _getAppreciation(String grade) {
    switch (grade) {
      case 'TB': return 'Très bien';
      case 'B': return 'Bien';
      case 'AB': return 'Assez bien';
      case 'P': return 'Passable';
      case 'I': return 'Insuffisant';
      default: return '';
    }
  }
}