import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/scrollable_content.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'À propos'),
            Expanded(
              child: ScrollableContent(
                child: Column(
                  children: [
                    // App Info Card
                    InfoCard(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.school,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Paramétrages School',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Version 1.0.0',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Application de gestion scolaire complète pour les établissements éducatifs.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Étudiants',
                            value: '250+',
                            icon: Icons.group,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Classes',
                            value: '15',
                            icon: Icons.school,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Enseignants',
                      value: '30',
                      icon: Icons.person,
                      color: AppTheme.secondaryColor,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Developer Team Section
                    _buildSectionTitle('Équipe de développement'),
                    const SizedBox(height: 16),
                    
                    InfoCard(
                      child: Column(
                        children: [
                          _buildTeamMember(
                            name: 'Équipe Technique',
                            role: 'Développement & Design',
                          ),
                          const Divider(),
                          _buildTeamMember(
                            name: 'Équipe Pédagogique',
                            role: 'Experts Éducation',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Features Section
                    _buildSectionTitle('Fonctionnalités principales'),
                    const SizedBox(height: 16),
                    
                    Column(
                      children: [
                        _buildFeatureItem(
                          icon: Icons.people,
                          title: 'Gestion des élèves',
                          description: 'Suivi complet des étudiants',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          icon: Icons.assignment,
                          title: 'Notes et évaluations',
                          description: 'Saisie et analyse des résultats',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          icon: Icons.calendar_today,
                          title: 'Emploi du temps',
                          description: 'Planification des cours',
                        ),
                        const SizedBox(height: 12),
                        _buildFeatureItem(
                          icon: Icons.cloud_off,
                          title: 'Mode hors ligne',
                          description: 'Travaillez sans connexion',
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Noter l\'application',
                            onPressed: () {
                              // Ouvrir store
                            },
                            icon: Icons.star,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SecondaryButton(
                            text: 'Partager',
                            onPressed: () {
                              // Partage
                            },
                            icon: Icons.share,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      '© 2024 Paramétrages School. Tous droits réservés.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          height: 2,
          width: 30,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamMember({
    required String name,
    required String role,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.person,
          color: AppTheme.primaryColor,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(role),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(description),
      ),
    );
  }
}