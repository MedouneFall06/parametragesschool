import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class SchoolCalendarScreen extends StatefulWidget {
  const SchoolCalendarScreen({super.key});

  @override
  State<SchoolCalendarScreen> createState() => _SchoolCalendarScreenState();
}

class _SchoolCalendarScreenState extends State<SchoolCalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  String _viewMode = 'month'; // 'month', 'week', 'day'
  final List<String> _eventTypes = ['academic', 'holiday', 'meeting', 'exam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Calendrier scolaire',
              subtitle: 'Événements et planning',
              trailing: PrimaryButton(
                text: 'Nouvel événement',
                onPressed: () {
                  // TODO: Créer événement
                },
                fullWidth: false,
                icon: Icons.add,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter CalendarViewModel
                    // TODO: Connecter à l'API calendrier
                    
                    // Calendar Controls
                    InfoCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: () {
                                  // TODO: Mois précédent
                                },
                              ),
                              Column(
                                children: [
                                  Text(
                                    _getMonthName(_selectedDate.month),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    _selectedDate.year.toString(),
                                    style: const TextStyle(
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: () {
                                  // TODO: Mois suivant
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildViewModeButton('Mois', 'month'),
                              const SizedBox(width: 8),
                              _buildViewModeButton('Semaine', 'week'),
                              const SizedBox(width: 8),
                              _buildViewModeButton('Jour', 'day'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Calendar View
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Calendrier',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.calendar_today, size: 50, color: Colors.grey),
                                  SizedBox(height: 12),
                                  Text(
                                    'Vue calendrier',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Le calendrier s\'affichera ici',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Upcoming Events
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Événements à venir',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SecondaryButton(
                                text: 'Tout voir',
                                onPressed: () {
                                  // TODO: Voir tous les événements
                                },
                                fullWidth: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildEventItem(
                            title: 'Conseil de classe',
                            date: '15 Janv 2024',
                            time: '14:00 - 16:00',
                            type: 'meeting',
                            location: 'Salle de réunion',
                          ),
                          const Divider(),
                          _buildEventItem(
                            title: 'Vacances d\'hiver',
                            date: '19 Fév - 4 Mar 2024',
                            time: 'Toute la journée',
                            type: 'holiday',
                            location: '',
                          ),
                          const Divider(),
                          _buildEventItem(
                            title: 'Examen de mathématiques',
                            date: '22 Janv 2024',
                            time: '08:00 - 10:00',
                            type: 'exam',
                            location: 'Salle 204',
                          ),
                          const Divider(),
                          _buildEventItem(
                            title: 'Réunion parents',
                            date: '25 Janv 2024',
                            time: '18:00 - 20:00',
                            type: 'meeting',
                            location: 'Amphithéâtre',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Event Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filtres',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: _eventTypes.map((type) {
                              return FilterChip(
                                label: Text(_getEventTypeLabel(type)),
                                selected: true,
                                onSelected: (selected) {
                                  // TODO: Filtrer événements
                                },
                                selectedColor: _getEventTypeColor(type),
                                checkmarkColor: Colors.white,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Today's Events
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 20,
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Aujourd\'hui',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par données dynamiques
                          _buildTodayEvent(
                            time: '08:00',
                            title: 'Cours de physique',
                            classe: 'Terminale S',
                          ),
                          const Divider(),
                          _buildTodayEvent(
                            time: '10:00',
                            title: 'Réunion équipe',
                            classe: 'Enseignants',
                          ),
                          const Divider(),
                          _buildTodayEvent(
                            time: '14:00',
                            title: 'Soutien scolaire',
                            classe: 'Première',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Import/Export
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Importer calendrier',
                            onPressed: () {
                              // TODO: Importer calendrier
                            },
                            icon: Icons.upload,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Exporter planning',
                            onPressed: () {
                              // TODO: Exporter planning
                            },
                            icon: Icons.download,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewModeButton(String label, String mode) {
    return ChoiceChip(
      label: Text(label),
      selected: _viewMode == mode,
      onSelected: (selected) {
        setState(() {
          _viewMode = mode;
        });
      },
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: _viewMode == mode ? Colors.white : AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildEventItem({
    required String title,
    required String date,
    required String time,
    required String type,
    required String location,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getEventTypeColor(type).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          _getEventTypeIcon(type),
          color: _getEventTypeColor(type),
        ),
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$date • $time'),
          if (location.isNotEmpty) Text(location),
        ],
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
      onTap: () {
        // TODO: Voir détails événement
      },
    );
  }

  Widget _buildTodayEvent({
    required String time,
    required String title,
    required String classe,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              time,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  classe,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

String _getMonthName(int month) {
  final months = [
    'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];
  return months[month - 1];
}

String _getEventTypeLabel(String type) {
  switch (type) {
    case 'academic':
      return 'Académique';
    case 'holiday':
      return 'Vacances';
    case 'meeting':
      return 'Réunion';
    case 'exam':
      return 'Examen';
    default:
      return type;
  }
}

Color _getEventTypeColor(String type) {
  switch (type) {
    case 'academic':
      return AppTheme.primaryColor;
    case 'holiday':
      return AppTheme.accentColor;
    case 'meeting':
      return AppTheme.secondaryColor;
    case 'exam':
      return AppTheme.warningColor;
    default:
      return AppTheme.textSecondary;
  }
}

IconData _getEventTypeIcon(String type) {
  switch (type) {
    case 'academic':
      return Icons.school;
    case 'holiday':
      return Icons.beach_access;
    case 'meeting':
      return Icons.people;
    case 'exam':
      return Icons.assignment;
    default:
      return Icons.event;
  }
}
