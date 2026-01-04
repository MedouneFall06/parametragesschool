import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/form_text_field.dart';
import 'package:parametragesschool/models/etudiant_model.dart';

class EtudiantEditScreen extends StatefulWidget {
  final Etudiant? etudiant;
  final String mode; // 'create' or 'edit'

  const EtudiantEditScreen({
    super.key,
    required this.mode,
    this.etudiant,
  });

  @override
  State<EtudiantEditScreen> createState() => _EtudiantEditScreenState();
}

class _EtudiantEditScreenState extends State<EtudiantEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _dateNaissanceController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  String _sexe = 'M';
  String _classeId = '';
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.etudiant != null) {
      // Mode édition
      _nomController.text = widget.etudiant!.nom;
      _prenomController.text = widget.etudiant!.prenom;
      // Les champs supplémentaires ne sont pas dans le modèle actuel
      // mais on les laisse pour l'extension future
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
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

      // Retour à l'écran précédent
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.mode == 'edit' 
                ? 'Étudiant mis à jour' 
                : 'Étudiant enregistré',
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
              title: widget.mode == 'edit' ? 'Modifier l\'étudiant' : 'Nouvel étudiant',
              subtitle: widget.mode == 'edit' 
                  ? 'Mettre à jour les informations' 
                  : 'Enregistrer un nouvel étudiant',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informations personnelles
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Informations personnelles',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // Nom
                              FormTextField(
                                controller: _nomController,
                                label: 'Nom',
                                hintText: 'Nom de famille',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez saisir le nom';
                                  }
                                  if (value.length < 2) {
                                    return 'Le nom doit contenir au moins 2 caractères';
                                  }
                                  return null;
                                },
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Prénom
                              FormTextField(
                                controller: _prenomController,
                                label: 'Prénom',
                                hintText: 'Prénom(s)',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez saisir le prénom';
                                  }
                                  if (value.length < 2) {
                                    return 'Le prénom doit contenir au moins 2 caractères';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Boutons d'action
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
                                  ? (widget.mode == 'edit' ? 'Mise à jour...' : 'Enregistrement...')
                                  : (widget.mode == 'edit' ? 'Mettre à jour' : 'Enregistrer'),
                              onPressed: _isSubmitting ? null : _submitForm,
                              icon: widget.mode == 'edit' ? Icons.update : Icons.save,
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
}
