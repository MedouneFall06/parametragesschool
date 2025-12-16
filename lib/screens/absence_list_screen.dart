import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/empty_state_widget.dart';
import 'package:parametragesschool/models/absence_model.dart';
import 'package:parametragesschool/models/etudiant_model.dart';

class AbsenceListScreen extends StatefulWidget {
  const AbsenceListScreen({super.key});

  @override
  State<AbsenceListScreen> createState() => _AbsenceListScreenState();
}

class _AbsenceListScreenState extends State<AbsenceListScreen> {
  // TODO: Remplacer par ViewModel/Provider
  List<Absence> _absences = [];
  List<Etudiant> _etudiants = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';
  DateTime _selectedDate = DateTime.now();

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
        Etudiant(id: "3", nom: "Ndoye", prenom: "Moussa", matricule: "ETU003", classeId: "CLS002"),
      ];
      
      _absences = [
        Absence(
          id: "1",
          etudiantId: "1",
          date: DateTime.now().subtract(const Duration(days: 5)),
          motif: "Maladie",
          justifie: true,
        ),
        Absence(
          id: "2",
          etudiantId: "2",
          date: DateTime.now().subtract(const Duration(days: 3)),
          motif: "Rendez-vous médical",
          justifie: true,
        ),
        Absence(
          id: "3",
          etudiantId: "3",
          date: DateTime.now().subtract(const Duration(days: 2)),
          motif: "Absence non justifiée",
          justifie: false,
        ),
        Absence(
          id: "4",
          etudiantId: "1",
          date: DateTime.now().subtract(const Duration(days: 1)),
          motif: "Problème familial",
          justifie: false,
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

  List<Absence> _getFilteredAbsences() {
    switch (_selectedFilter) {
      case 'justified':
        return _absences.where((a) => a.justifie).toList();
      case 'unjustified':
        return _absences.where((a) => !a.justifie).toList();
      case 'today':
        return _absences.where((a) => 
          a.date.year == DateTime.now().year &&
          a.date.month == DateTime.now().month &&
          a.date.day == DateTime.now().day
        ).toList();
      default:
        return _absences;
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
              title: 'Gestion des absences',
              subtitle: 'Suivi des présences et absences',
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
    final filteredAbsences = _getFilteredAbsences();
    final justifiedCount = _absences.where((a) => a.justifie).length;
    final unjustifiedCount = _absences.where((a) => !a.justifie).length;
    
    return Column(
      children: [
        // Filters and Stats
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
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
                        DropdownMenuItem(value: 'all', child: Text('Toutes les absences')),
                        DropdownMenuItem(value: 'justified', child: Text('Justifiées')),
                        DropdownMenuItem(value: 'unjustified', child: Text('Non justifiées')),
                        DropdownMenuItem(value: 'today', child: Text('Aujourd\'hui')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedFilter = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  PrimaryButton(
                    text: 'Nouvelle',
                    onPressed: () {
                      // TODO: Naviguer vers ajout d'absence
                    },
                    icon: Icons.add,
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  _buildStatCard('Total', _absences.length.toString(), Icons.list),
                  const SizedBox(width: 12),
                  _buildStatCard('Justifiées', justifiedCount.toString(), Icons.check_circle),
                  const SizedBox(width: 12),
                  _buildStatCard('Non justifiées', unjustifiedCount.toString(), Icons.cancel),
                ],
              ),
            ],
          ),
        ),
        
        // Date Picker
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InfoCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sélectionner une date',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedDate = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.textPrimary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SecondaryButton(
                      text: 'Aujourd\'hui',
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      fullWidth: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Absences List
        Expanded(
          child: filteredAbsences.isEmpty
              ? EmptyStateWidget(
                  title: 'Aucune absence',
                  message: _selectedFilter == 'today' 
                      ? 'Aucune absence enregistrée pour aujourd\'hui.'
                      : 'Aucune absence correspondant aux critères sélectionnés.',
                  icon: Icons.person_off,
                  buttonText: 'Ajouter une absence',
                  onButtonPressed: () {
                    // TODO: Naviguer vers ajout
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredAbsences.length,
                  itemBuilder: (context, index) {
                    final absence = filteredAbsences[index];
                    return _buildAbsenceCard(absence);
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

  Widget _buildAbsenceCard(Absence absence) {
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
                        _getEtudiantName(absence.etudiantId),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${absence.date.day}/${absence.date.month}/${absence.date.year}',
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
                    color: absence.justifie 
                        ? AppTheme.successColor.withOpacity(0.1)
                        : AppTheme.errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: absence.justifie 
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                    ),
                  ),
                  child: Text(
                    absence.justifie ? 'Justifiée' : 'Non justifiée',
                    style: TextStyle(
                      color: absence.justifie 
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Text(
              'Motif: ${absence.motif}',
              style: const TextStyle(
                color: AppTheme.textSecondary,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: absence.justifie ? 'Marquer non justifiée' : 'Justifier',
                    onPressed: () {
                      _toggleJustification(absence);
                    },
                    fullWidth: true,
                    icon: absence.justifie ? Icons.cancel : Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 8),
                SecondaryButton(
                  text: 'Éditer',
                  onPressed: () {
                    // TODO: Éditer l'absence
                  },
                  fullWidth: true,
                  icon: Icons.edit,
                ),
                const SizedBox(width: 8),
                SecondaryButton(
                  text: 'Supprimer',
                  onPressed: () {
                    _showDeleteDialog(absence);
                  },
                  fullWidth: true,
                  icon: Icons.delete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _toggleJustification(Absence absence) {
    setState(() {
      final index = _absences.indexWhere((a) => a.id == absence.id);
      if (index != -1) {
        _absences[index] = Absence(
          id: absence.id,
          etudiantId: absence.etudiantId,
          date: absence.date,
          motif: absence.motif,
          justifie: !absence.justifie,
        );
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          absence.justifie 
              ? 'Absence marquée comme non justifiée'
              : 'Absence justifiée',
        ),
      ),
    );
  }

  void _showDeleteDialog(Absence absence) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer l\'absence'),
        content: Text(
          'Êtes-vous sûr de vouloir supprimer l\'absence de ${_getEtudiantName(absence.etudiantId)} ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Supprimer',
            onPressed: () {
              setState(() {
                _absences.removeWhere((a) => a.id == absence.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Absence supprimée'),
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