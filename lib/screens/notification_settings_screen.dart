import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _newGrades = true;
  bool _absences = true;
  bool _scheduleChanges = false;
  bool _announcements = true;
  bool _quietHoursEnabled = false;
  TimeOfDay _quietStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietEnd = const TimeOfDay(hour: 7, minute: 0);
  String _selectedSound = 'default';

  final List<String> _sounds = [
    'default',
    'chime',
    'bell',
    'ding',
    'pop',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Notifications'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Global Toggle
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifications générales',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: const Text('Activer les notifications'),
                            subtitle: const Text('Activer/désactiver toutes les notifications'),
                            value: _notificationsEnabled,
                            onChanged: (value) {
                              setState(() {
                                _notificationsEnabled = value;
                              });
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Notification Types
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Types de notifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Choisissez les types de notifications que vous souhaitez recevoir',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildNotificationToggle(
                            title: 'Nouvelles notes',
                            subtitle: 'Recevoir les nouvelles notes des élèves',
                            value: _newGrades,
                            onChanged: _notificationsEnabled ? (value) {
                              setState(() {
                                _newGrades = value ?? _newGrades;
                              });
                            } : null,
                          ),
                          const Divider(),
                          _buildNotificationToggle(
                            title: 'Absences',
                            subtitle: 'Notifications d\'absence des élèves',
                            value: _absences,
                            onChanged: _notificationsEnabled ? (value) {
                              setState(() {
                                _absences = value ?? _absences;
                              });
                            } : null,
                          ),
                          const Divider(),
                          _buildNotificationToggle(
                            title: 'Changements d\'emploi du temps',
                            subtitle: 'Modifications du planning',
                            value: _scheduleChanges,
                            onChanged: _notificationsEnabled ? (value) {
                              setState(() {
                                _scheduleChanges = value ?? _scheduleChanges;
                              });
                            } : null,
                          ),
                          const Divider(),
                          _buildNotificationToggle(
                            title: 'Annonces importantes',
                            subtitle: 'Communications de l\'administration',
                            value: _announcements,
                            onChanged: _notificationsEnabled ? (value) {
                              setState(() {
                                _announcements = value ?? _announcements;
                              });
                            } : null,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quiet Hours
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Heures silencieuses',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: const Text('Activer les heures silencieuses'),
                            subtitle: const Text('Désactiver les notifications pendant certaines heures'),
                            value: _quietHoursEnabled,
                            onChanged: (value) {
                              setState(() {
                                _quietHoursEnabled = value;
                              });
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          if (_quietHoursEnabled) ...[
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Début',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final TimeOfDay? picked = await showTimePicker(
                                            context: context,
                                            initialTime: _quietStart,
                                          );
                                          if (picked != null) {
                                            setState(() {
                                              _quietStart = picked;
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: AppTheme.textPrimary,
                                          elevation: 0,
                                        ),
                                        child: Text(
                                          _quietStart.format(context),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Fin',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final TimeOfDay? picked = await showTimePicker(
                                            context: context,
                                            initialTime: _quietEnd,
                                          );
                                          if (picked != null) {
                                            setState(() {
                                              _quietEnd = picked;
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: AppTheme.textPrimary,
                                          elevation: 0,
                                        ),
                                        child: Text(
                                          _quietEnd.format(context),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sound Selector
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Son des notifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: _selectedSound,
                            decoration: const InputDecoration(
                              labelText: 'Sélectionnez un son',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: _sounds.map((sound) {
                              return DropdownMenuItem(
                                value: sound,
                                child: Text(
                                  sound == 'default' ? 'Son par défaut' : 'Son $sound',
                                ),
                              );
                            }).toList(),
                            onChanged: _notificationsEnabled ? (value) {
                              setState(() {
                                _selectedSound = value!;
                              });
                            } : null,
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Tester le son',
                            onPressed: _notificationsEnabled ? () {
                              // Tester le son
                            } : null,
                            fullWidth: true,
                            icon: Icons.volume_up,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Action Buttons
                    PrimaryButton(
                      text: 'Enregistrer les paramètres',
                      onPressed: () {
                        // Sauvegarder
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Paramètres de notifications enregistrés'),
                          ),
                        );
                      },
                      fullWidth: true,
                      icon: Icons.save,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    PrimaryButton(
                      text: 'Réinitialiser aux valeurs par défaut',
                      onPressed: () {
                        setState(() {
                          _notificationsEnabled = true;
                          _newGrades = true;
                          _absences = true;
                          _scheduleChanges = false;
                          _announcements = true;
                          _quietHoursEnabled = false;
                          _quietStart = const TimeOfDay(hour: 22, minute: 0);
                          _quietEnd = const TimeOfDay(hour: 7, minute: 0);
                          _selectedSound = 'default';
                        });
                      },
                      fullWidth: true,
                      icon: Icons.restart_alt,
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

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?>? onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.primaryColor,
    );
  }
}