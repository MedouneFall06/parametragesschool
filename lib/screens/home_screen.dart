import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Tableau de bord',
              subtitle: 'Accès rapide aux modules de gestion',
              showBackButton: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section ACADÉMIQUE
                    _buildSectionTitle('📊 ACADÉMIQUE'),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.8,
                      children: [
                        _buildModuleCard(
                          icon: Icons.people_alt,
                          title: 'Étudiants',
                          subtitle: 'Gérer les étudiants',
                          color: AppTheme.successColor,
                          onTap: () => context.pushNamed('etudiants'),
                        ),
                        _buildModuleCard(
                          icon: Icons.grade,
                          title: 'Notes',
                          subtitle: 'Saisie et consultation',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('notes'),
                        ),
                        _buildModuleCard(
                          icon: Icons.class_,
                          title: 'Classes',
                          subtitle: 'Classes et niveaux',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('classes'),
                        ),
                        _buildModuleCard(
                          icon: Icons.description,
                          title: 'Bulletin',
                          subtitle: 'Bulletins scolaires',
                          color: AppTheme.infoColor,
                          onTap: () => context.pushNamed('bulletin'),
                        ),
                        _buildModuleCard(
                          icon: Icons.menu_book,
                          title: 'Matières',
                          subtitle: 'Matières enseignées',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('matieres'),
                        ),
                        _buildModuleCard(
                          icon: Icons.person_off,
                          title: 'Absences',
                          subtitle: 'Gestion des absences',
                          color: AppTheme.warningColor,
                          onTap: () => context.pushNamed('absences'),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Section PLANNING
                    _buildSectionTitle('📅 PLANNING'),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.8,
                      children: [
                        _buildModuleCard(
                          icon: Icons.calendar_today,
                          title: 'Emploi du temps',
                          subtitle: 'Planning des cours',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('schedule'),
                        ),
                        _buildModuleCard(
                          icon: Icons.event,
                          title: 'Calendrier scolaire',
                          subtitle: 'Événements et vacances',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('school-calendar'),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Section PERSONNEL
                    _buildSectionTitle('👥 PERSONNEL'),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.8,
                      children: [
                        _buildModuleCard(
                          icon: Icons.school,
                          title: 'Enseignants',
                          subtitle: 'Gestion du personnel',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('enseignants'),
                        ),
                        _buildModuleCard(
                          icon: Icons.assessment,
                          title: 'Évaluation',
                          subtitle: 'Évaluation enseignants',
                          color: AppTheme.infoColor,
                          onTap: () => context.pushNamed('teacher-evaluation'),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Section RAPPORTS & ANALYSE
                    _buildSectionTitle('📈 RAPPORTS & ANALYSE'),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.8,
                      children: [
                        _buildModuleCard(
                          icon: Icons.bar_chart,
                          title: 'Rapports',
                          subtitle: 'Rapports généraux',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('reports'),
                        ),
                        _buildModuleCard(
                          icon: Icons.analytics,
                          title: 'Statistiques',
                          subtitle: 'Statistiques avancées',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('advanced-stats'),
                        ),
                        _buildModuleCard(
                          icon: Icons.auto_awesome,
                          title: 'Rapports auto',
                          subtitle: 'Rapports automatiques',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('auto-reports'),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Section ADMINISTRATION
                    _buildSectionTitle('⚙️ ADMINISTRATION'),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.8,
                      children: [
                        _buildModuleCard(
                          icon: Icons.settings,
                          title: 'Paramètres',
                          subtitle: 'Paramètres système',
                          color: AppTheme.infoColor,
                          onTap: () => context.pushNamed('settings'),
                        ),
                        _buildModuleCard(
                          icon: Icons.backup,
                          title: 'Backup',
                          subtitle: 'Sauvegarde des données',
                          color: AppTheme.warningColor,
                          onTap: () => context.pushNamed('backup'),
                        ),
                        _buildModuleCard(
                          icon: Icons.people_outline,
                          title: 'Utilisateurs',
                          subtitle: 'Gestion des comptes',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('user-management'),
                        ),
                        _buildModuleCard(
                          icon: Icons.sync,
                          title: 'Sync',
                          subtitle: 'Synchronisation',
                          color: AppTheme.successColor,
                          onTap: () => context.pushNamed('sync'),
                        ),
                        _buildModuleCard(
                          icon: Icons.dashboard,
                          title: 'Admin Dashboard',
                          subtitle: 'Tableau de bord admin',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('admin-dashboard'),
                        ),
                        _buildModuleCard(
                          icon: Icons.history,
                          title: 'Audit Log',
                          subtitle: 'Journal d\'audit',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('audit-log'),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}