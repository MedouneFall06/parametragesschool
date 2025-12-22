import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/form_text_field.dart';
import 'package:parametragesschool/models/absence_model.dart';

class AbsenceEditScreen extends StatefulWidget {
  final Absence? absence;
  final String? etudiantId;
  final String? etudiantNom;

  const AbsenceEditScreen({
    super.key,
    this.absence,
    this.etudiantId,
    this.etudiantNom,
  });

  @override
  State<AbsenceEditScreen> createState() => _AbsenceEditScreenState();
}

class _AbsenceEditScreenState extends State<AbsenceEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _motifController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _justifie = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    
    if (widget.absence != null) {
      // Mode édition
      _motifController.text = widget.absence!.motif;
      _dateController.text = _formatDate(widget.absence!.date);
      _selectedDate = widget.absence!.date;
      _justifie = widget.absence!.justifie;
    } else {
      // Mode création
      _dateController.text = _formatDate(DateTime.now());
    }
  }

  @override
  void dispose() {
    _motifController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
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
            widget.absence != null 
                ? 'Absence mise à jour' 
                : 'Absence enregistrée',
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
              title: widget.absence != null ? 'Modifier l\'absence' : 'Nouvelle absence',
              subtitle: widget.absence != null 
                  ? 'Mettre à jour une absence' 
                  : 'Enregistrer une nouvelle absence',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informations étudiant (si fourni)
                      if (widget.etudiantNom != null)
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Étudiant',
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        widget.etudiantNom!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                      if (widget.etudiantNom != null) const SizedBox(height: 16),
                      
                      // Date
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Date de l\'absence',
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () => _selectDate(context),
                                  ),
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez sélectionner une date';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Motif
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Motif',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              FormTextField(
                                controller: _motifController,
                                label: 'Motif de l\'absence',
                                hintText: 'Ex: Maladie, rendez-vous médical...',
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez saisir un motif';
                                  }
                                  if (value.length < 3) {
                                    return 'Le motif doit contenir au moins 3 caractères';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Statut
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Statut',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SwitchListTile(
                                title: const Text('Absence justifiée'),
                                subtitle: const Text('Cochez si l\'absence est justifiée'),
                                value: _justifie,
                                onChanged: (value) {
                                  setState(() {
                                    _justifie = value;
                                  });
                                },
                                activeColor: AppTheme.successColor,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: _justifie
                                      ? AppTheme.successColor.withOpacity(0.1)
                                      : AppTheme.errorColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _justifie
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                  ),
                                ),
                                child: Text(
                                  _justifie
                                      ? '✓ Cette absence sera marquée comme justifiée'
                                      : '⚠️ Cette absence sera marquée comme non justifiée',
                                  style: TextStyle(
                                    color: _justifie
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                  ),
                                ),
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
                                  ? (widget.absence != null ? 'Mise à jour...' : 'Enregistrement...')
                                  : (widget.absence != null ? 'Mettre à jour' : 'Enregistrer'),
                              onPressed: _isSubmitting ? null : _submitForm,
                              icon: widget.absence != null ? Icons.update : Icons.save,
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