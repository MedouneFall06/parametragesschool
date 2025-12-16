import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/empty_state_widget.dart';
import 'package:parametragesschool/models/emploi_du_temps_model.dart';
import 'package:parametragesschool/models/classe_model.dart';
import 'package:parametragesschool/models/matiere_model.dart';
import 'package:parametragesschool/models/enseignant_model.dart';

class ScheduleScreen extends StatefulWidget {
  final String? classeId;
  
  const ScheduleScreen({
    super.key,
    this.classeId,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // TODO: Remplacer par ViewModel/Provider
  List<EmploiDuTemps> _schedule = [];
  List<Classe> _classes = [];
  List<Matiere> _matieres = [];
  List<Enseignant> _enseignants = [];
  bool _isLoading = true;
  String _selectedClasseId = '';
  String _selectedDay = 'Lundi';
  
  final List<String> _days = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
  ];
  
  final List<String> _timeSlots = [
    '08:00 - 09:00',
    '09:00 - 10:00',
    '10:15 - 11:15',
    '11:15 - 12:15',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:15 - 17:15',
  ];

  @override
  void initState() {
    super.initState();
    _selectedClasseId = widget.classeId ?? '';
    _loadDemoData();
  }

  Future<void> _loadDemoData() async {
    // TODO: Remplacer par appel API/ViewModel
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _classes = [
        Classe(id: "CLS001", nom: "Terminale S", niveau: "Terminale", departementId: "DEPT001"),
        Classe(id: "CLS002", nom: "Première L", niveau: "Première", departementId: "DEPT002"),
        Classe(id: "CLS003", nom: "Seconde G", niveau: "Seconde", departementId: "DEPT003"),
      ];
      
      _matieres = [
        Matiere(id: "1", nom: "Mathématiques", coefficient: 4),
        Matiere(id: "2", nom: "Physique", coefficient: 3),
        Matiere(id: "3", nom: "Français", coefficient: 2),
        Matiere(id: "4", nom: "Anglais", coefficient: 2),
        Matiere(id: "5", nom: "Histoire-Géo", coefficient: 2),
        Matiere(id: "6", nom: "SVT", coefficient: 2),
      ];
      
      _enseignants = [
        Enseignant(userId: "USR001", specialite: "Mathématiques"),
        Enseignant(userId: "USR002", specialite: "Physique"),
        Enseignant(userId: "USR003", specialite: "Français"),
      ];
      
      _schedule = [
        EmploiDuTemps(
          id: "1",
          classeId: "CLS001",
          matiereId: "1",
          enseignantId: "USR001",
          jour: "Lundi",
          heure: "08:00 - 10:00",
        ),
        EmploiDuTemps(
          id: "2",
          classeId: "CLS001",
          matiereId: "2",
          enseignantId: "USR002",
          jour: "Lundi",
          heure: "10:15 - 11:15",
        ),
        EmploiDuTemps(
          id: "3",
          classeId: "CLS001",
          matiereId: "3",
          enseignantId: "USR003",
          jour: "Lundi",
          heure: "11:15 - 12:15",
        ),
        EmploiDuTemps(
          id: "4",
          classeId: "CLS001",
          matiereId: "4",
          enseignantId: "USR003",
          jour: "Mardi",
          heure: "08:00 - 09:00",
        ),
        EmploiDuTemps(
          id: "5",
          classeId: "CLS001",
          matiereId: "5",
          enseignantId: "USR001",
          jour: "Mardi",
          heure: "09:00 - 10:00",
        ),
        EmploiDuTemps(
          id: "6",
          classeId: "CLS002",
          matiereId: "6",
          enseignantId: "USR002",
          jour: "Lundi",
          heure: "14:00 - 16:00",
        ),
      ];
      
      if (_selectedClasseId.isEmpty && _classes.isNotEmpty) {
        _selectedClasseId = _classes.first.id;
      }
      
      _isLoading = false;
    });
  }

  String _getClasseName(String classeId) {
    final classe = _classes.firstWhere(
      (c) => c.id == classeId,
      orElse: () => Classe(id: "", nom: "Inconnue", niveau: "", departementId: ""),
    );
    return classe.nom;
  }

  String _getMatiereName(String matiereId) {
    final matiere = _matieres.firstWhere(
      (m) => m.id == matiereId,
      orElse: () => Matiere(id: "", nom: "Inconnue", coefficient: 1),
    );
    return matiere.nom;
  }

  String _getEnseignantSpecialite(String enseignantId) {
    final enseignant = _enseignants.firstWhere(
      (e) => e.userId == enseignantId,
      orElse: () => Enseignant(userId: "", specialite: "Inconnu"),
    );
    return enseignant.specialite;
  }

  List<EmploiDuTemps> _getScheduleForDay(String classeId, String day) {
    return _schedule.where((s) => 
      s.classeId == classeId && s.jour == day
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Emploi du temps',
              subtitle: 'Planning des cours',
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
    final scheduleForDay = _getScheduleForDay(_selectedClasseId, _selectedDay);
    
    return Column(
      children: [
        // Class Selection and Day Selector
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedClasseId,
                      decoration: const InputDecoration(
                        labelText: 'Sélectionner une classe',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: _classes.map((classe) {
                        return DropdownMenuItem(
                          value: classe.id,
                          child: Text(classe.nom),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedClasseId = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  PrimaryButton(
                    text: 'Générer PDF',
                    onPressed: () {
                      // TODO: Générer PDF de l'emploi du temps
                    },
                    icon: Icons.picture_as_pdf,
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Day Selector
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    final day = _days[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = day;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _selectedDay == day 
                              ? AppTheme.primaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedDay == day 
                                ? AppTheme.primaryColor
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day,
                              style: TextStyle(
                                color: _selectedDay == day 
                                    ? Colors.white
                                    : AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getDayScheduleCount(day).toString(),
                              style: TextStyle(
                                color: _selectedDay == day 
                                    ? Colors.white
                                    : AppTheme.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        
        // Schedule Info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InfoCard(
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppTheme.infoColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Emploi du temps de ${_getClasseName(_selectedClasseId)} - $_selectedDay',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${scheduleForDay.length} cours',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Schedule Grid
        Expanded(
          child: scheduleForDay.isEmpty
              ? EmptyStateWidget(
                  title: 'Aucun cours',
                  message: 'Aucun cours programmé pour ce jour.',
                  icon: Icons.calendar_today,
                  buttonText: 'Ajouter un cours',
                  onButtonPressed: () {
                    // TODO: Naviguer vers ajout de cours
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: scheduleForDay.length,
                  itemBuilder: (context, index) {
                    final cours = scheduleForDay[index];
                    return _buildCourseCard(cours);
                  },
                ),
        ),
        
        // Time Slots View (Alternative View)
        if (scheduleForDay.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.all(16),
            child: InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vue par créneaux horaires',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _timeSlots.length,
                      itemBuilder: (context, index) {
                        final timeSlot = _timeSlots[index];
                        final coursInSlot = scheduleForDay.where((c) => 
                          c.heure == timeSlot
                        ).toList();
                        
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: coursInSlot.isNotEmpty 
                                ? AppTheme.primaryColor.withOpacity(0.1)
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: coursInSlot.isNotEmpty 
                                  ? AppTheme.primaryColor
                                  : Colors.grey[300]!,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                timeSlot,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: coursInSlot.isNotEmpty 
                                      ? AppTheme.primaryColor
                                      : AppTheme.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (coursInSlot.isNotEmpty)
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: coursInSlot.length,
                                    itemBuilder: (context, i) {
                                      final cours = coursInSlot[i];
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Text(
                                          _getMatiereName(cours.matiereId),
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                )
                              else
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Libre',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        
        // Action Buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: 'Vue semaine',
                  onPressed: () {
                    // TODO: Naviguer vers vue semaine
                  },
                  icon: Icons.view_week,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  text: 'Ajouter cours',
                  onPressed: () {
                    // TODO: Naviguer vers ajout de cours
                  },
                  icon: Icons.add_circle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(EmploiDuTemps cours) {
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
                        _getMatiereName(cours.matiereId),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getEnseignantSpecialite(cours.enseignantId),
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cours.heure,
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Icon(Icons.school, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    _getClasseName(cours.classeId),
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
                Icon(Icons.access_time, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 6),
                Text(
                  _getDuration(cours.heure),
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Éditer',
                    onPressed: () {
                      // TODO: Éditer le cours
                    },
                    fullWidth: true,
                    icon: Icons.edit,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SecondaryButton(
                    text: 'Annuler cours',
                    onPressed: () {
                      _showCancelDialog(cours);
                    },
                    fullWidth: true,
                    icon: Icons.cancel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getDayScheduleCount(String day) {
    return _schedule.where((s) => 
      s.classeId == _selectedClasseId && s.jour == day
    ).length;
  }

  String _getDuration(String timeSlot) {
    // Convertir "08:00 - 10:00" en "2h"
    final parts = timeSlot.split(' - ');
    if (parts.length != 2) return '';
    
    try {
      final start = _parseTime(parts[0]);
      final end = _parseTime(parts[1]);
      final duration = end.difference(start);
      return '${duration.inHours}h${duration.inMinutes.remainder(60) > 0 ? '${duration.inMinutes.remainder(60)}min' : ''}';
    } catch (e) {
      return '';
    }
  }

  DateTime _parseTime(String time) {
    final parts = time.split(':');
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 
        int.parse(parts[0]), int.parse(parts[1]));
  }

  void _showCancelDialog(EmploiDuTemps cours) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Annuler le cours'),
        content: Text(
          'Êtes-vous sûr de vouloir annuler le cours de ${_getMatiereName(cours.matiereId)} '
          'programmé le ${cours.jour} de ${cours.heure} ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Confirmer',
            onPressed: () {
              setState(() {
                _schedule.removeWhere((s) => s.id == cours.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cours annulé'),
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