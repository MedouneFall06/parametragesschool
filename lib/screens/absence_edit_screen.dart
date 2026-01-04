import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/form_text_field.dart';
import 'package:parametragesschool/models/absence_model.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
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
                            padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                            child: Row(
                              children: [
                                Container(
                                  width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
                                  height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
                                  ),
                                ),
                                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Étudiant',
                                        style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                        ),
                                      ),
                                      Text(
                                        widget.etudiantNom!,
                                        style: TextStyle(
                                          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
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
                      
                      if (widget.etudiantNom != null) SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                      
                      // Date
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                              TextFormField(
                                controller: _dateController,
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Date de l\'absence',
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.calendar_today, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
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
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                      
                      // Motif
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Motif',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                      
                      // Statut
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Statut',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SizedBox(height: AppConstants.fixedHeightSmall),
                              SwitchListTile(
                                title: Text(
                                  'Absence justifiée',
                                  style: TextStyle(
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  ),
                                ),
                                subtitle: Text(
                                  'Cochez si l\'absence est justifiée',
                                  style: TextStyle(
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                  ),
                                ),
                                value: _justifie,
                                onChanged: (value) {
                                  setState(() {
                                    _justifie = value;
                                  });
                                },
                                activeColor: AppTheme.successColor,
                              ),
                              SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                              Container(
                                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                                decoration: BoxDecoration(
                                  color: _justifie
                                      ? AppTheme.successColor.withOpacity(0.1)
                                      : AppTheme.errorColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
                                    fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                      
                      // Boutons d'action
                      ResponsiveGrid(
                        customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                        children: [
                          SecondaryButton(
                            text: 'Annuler',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icons.cancel,
                            fullWidth: true,
                          ),
                          PrimaryButton(
                            text: _isSubmitting
                                ? (widget.absence != null ? 'Mise à jour...' : 'Enregistrement...')
                                : (widget.absence != null ? 'Mettre à jour' : 'Enregistrer'),
                            onPressed: _isSubmitting ? null : _submitForm,
                            icon: widget.absence != null ? Icons.update : Icons.save,
                            fullWidth: true,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
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
