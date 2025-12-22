import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/form_text_field.dart';
import 'package:parametragesschool/models/etudiant_model.dart';

class EtudiantEditScreen extends StatefulWidget {
  final Etudiant? etudiant; // null pour création, non-null pour édition
  final String mode; // 'create' ou 'edit'

  const EtudiantEditScreen({
    super.key,
    this.etudiant,
    required this.mode,
  });

  @override
  State<EtudiantEditScreen> createState() => _EtudiantEditScreenState();
}

class _EtudiantEditScreenState extends State<EtudiantEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _classeIdController = TextEditingController();
  final TextEditingController _parentIdController = TextEditingController();
  bool _isSubmitting = false;

  // Données fictives pour les listes (à remplacer par ViewModel)
  final List<Map<String, String>> _classes = [
    {'id': 'CLS001', 'nom': 'Terminale S1'},
    {'id': 'CLS002', 'nom': 'Première L1'},
    {'id': 'CLS003', 'nom': 'Seconde G'},
  ];
  
  final List<Map<String, String>> _parents = [
    {'id': 'PAR001', 'nom': 'Papa Fall'},
    {'id': 'PAR002', 'nom': 'Maman Diop'},
    {'id': 'PAR003', 'nom': 'Parent Sarr'},
  ];

  String? _selectedClasseId;
  String? _selectedParentId;

  @override
  void initState() {
    super.initState();
    
    // Initialisation pour mode édition
    if (widget.mode == 'edit' && widget.etudiant != null) {
      _prenomController.text = widget.etudiant!.prenom;
      _nomController.text = widget.etudiant!.nom;
      _matriculeController.text = widget.etudiant!.matricule;
      _classeIdController.text = widget.etudiant!.classeId;
      _parentIdController.text = widget.etudiant!.parentId ?? '';
      _selectedClasseId = widget.etudiant!.classeId;
      _selectedParentId = widget.etudiant!.parentId;
    } else {
      // Valeurs par défaut pour création
      _selectedClasseId = _classes.isNotEmpty ? _classes.first['id'] : null;
    }
  }

  @override
  void dispose() {
    _prenomController.dispose();
    _nomController.dispose();
    _matriculeController.dispose();
    _classeIdController.dispose();
    _parentIdController.dispose();
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

      // Retour à la liste des étudiants
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.mode == 'edit' 
                ? 'Étudiant mis à jour' 
                : 'Étudiant créé avec succès',
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
              subtitle: widget.mode == 'edit' ? 'Mettre à jour les informations' : 'Créer une nouvelle fiche étudiante',
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
                              FormTextField(
                                controller: _prenomController,
                                label: 'Prénom',
                                hintText: 'Ex: Medoune',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le prénom est obligatoire';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              FormTextField(
                                controller: _nomController,
                                label: 'Nom',
                                hintText: 'Ex: Fall',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le nom est obligatoire';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              FormTextField(
                                controller: _matriculeController,
                                label: 'Matricule',
                                hintText: 'Ex: ETU2024001',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le matricule est obligatoire';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Classe et Parent
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Affectation',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String?>(
                                value: _selectedClasseId,
                                decoration: const InputDecoration(
                                  labelText: 'Classe',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Sélectionner une classe'),
                                  ),
                                  ..._classes.map((classe) {
                                    return DropdownMenuItem(
                                      value: classe['id'],
                                      child: Text(classe['nom']!),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedClasseId = value;
                                    _classeIdController.text = value ?? '';
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La classe est obligatoire';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<String?>(
                                value: _selectedParentId,
                                decoration: const InputDecoration(
                                  labelText: 'Parent (optionnel)',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text('Aucun parent'),
                                  ),
                                  ..._parents.map((parent) {
                                    return DropdownMenuItem(
                                      value: parent['id'],
                                      child: Text(parent['nom']!),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedParentId = value;
                                    _parentIdController.text = value ?? '';
                                  });
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
                                  ? (widget.mode == 'edit' ? 'Mise à jour...' : 'Création...')
                                  : (widget.mode == 'edit' ? 'Mettre à jour' : 'Créer'),
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