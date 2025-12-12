import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'fr';
  
  final List<Map<String, dynamic>> _languages = [
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'ar', 'name': 'العربية', 'flag': '🇸🇦'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇵🇹'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Langue'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sélectionnez la langue',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Choisissez la langue d\'affichage de l\'application',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            children: _languages.map((language) {
                              return _buildLanguageTile(
                                flag: language['flag'],
                                name: language['name'],
                                code: language['code'],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Current Language Info
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Langue actuelle',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                _getCurrentLanguage()['flag'],
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getCurrentLanguage()['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Langue sélectionnée',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.check_circle,
                                color: AppTheme.successColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    PrimaryButton(
                      text: 'Appliquer la langue',
                      onPressed: () {
                        // Appliquer la langue
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Langue changée en ${_getCurrentLanguage()['name']}'),
                          ),
                        );
                      },
                      fullWidth: true,
                      icon: Icons.translate,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    PrimaryButton(
                      text: 'Détecter automatiquement',
                      onPressed: () {
                        // Détection automatique
                        setState(() {
                          _selectedLanguage = 'fr'; // Par défaut français
                        });
                      },
                      fullWidth: true,
                      icon: Icons.auto_awesome,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Language Help
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Besoin d\'aide ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Si votre langue n\'est pas disponible, contactez-nous pour une demande de traduction.',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Suggérer une langue',
                            onPressed: () {
                              // Ouvrir formulaire de suggestion
                            },
                            fullWidth: true,
                            icon: Icons.flag,
                          ),
                        ],
                      ),
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

  Widget _buildLanguageTile({
    required String flag,
    required String name,
    required String code,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: RadioListTile(
        title: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Text(name),
          ],
        ),
        value: code,
        groupValue: _selectedLanguage,
        onChanged: (value) {
          setState(() {
            _selectedLanguage = value!;
          });
        },
        activeColor: AppTheme.primaryColor,
        secondary: code == 'fr' 
            ? const Icon(Icons.star, color: Colors.amber)
            : null,
      ),
    );
  }

  Map<String, dynamic> _getCurrentLanguage() {
    return _languages.firstWhere(
      (lang) => lang['code'] == _selectedLanguage,
      orElse: () => _languages[0],
    );
  }
}