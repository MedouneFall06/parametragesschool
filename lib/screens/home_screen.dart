import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
import 'package:parametragesschool/core/constant/constants.dart';

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
                    _buildSectionTitle(context, '📊 ACADÉMIQUE'),
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                      children: [
                        _buildModuleCard(
                          context: context,
                          icon: Icons.people_alt,
                          title: 'Étudiants',
                          subtitle: 'Gérer les étudiants',
                          color: AppTheme.successColor,
                          onTap: () => context.pushNamed('etudiants'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.grade,
                          title: 'Notes',
                          subtitle: 'Saisie et consultation',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('notes'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.class_,
                          title: 'Classes',
                          subtitle: 'Classes et niveaux',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('classes'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.description,
                          title: 'Bulletin',
                          subtitle: 'Bulletins scolaires',
                          color: AppTheme.infoColor,
                          onTap: () => context.pushNamed('bulletin'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.menu_book,
                          title: 'Matières',
                          subtitle: 'Matières enseignées',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('matieres'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.person_off,
                          title: 'Absences',
                          subtitle: 'Gestion des absences',
                          color: AppTheme.warningColor,
                          onTap: () => context.pushNamed('absences'),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingLarge)),
                    
                    // Section PLANNING
                    _buildSectionTitle(context, '📅 PLANNING'),
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                      children: [
                        _buildModuleCard(
                          context: context,
                          icon: Icons.calendar_today,
                          title: 'Emploi du temps',
                          subtitle: 'Planning des cours',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('schedule'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.event,
                          title: 'Calendrier scolaire',
                          subtitle: 'Événements et vacances',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('schoolCalendar'),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingLarge)),
                    
                    // Section PERSONNEL
                    _buildSectionTitle(context, '👥 PERSONNEL'),
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                      children: [
                        _buildModuleCard(
                          context: context,
                          icon: Icons.school,
                          title: 'Enseignants',
                          subtitle: 'Gestion du personnel',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('enseignants'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.assessment,
                          title: 'Évaluation',
                          subtitle: 'Évaluation enseignants',
                          color: AppTheme.infoColor,
                          onTap: () => context.pushNamed('teacherEvaluation'),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingLarge)),
                    
                    // Section RAPPORTS & ANALYSE
                    _buildSectionTitle(context, '📈 RAPPORTS & ANALYSE'),
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                      children: [
                        _buildModuleCard(
                          context: context,
                          icon: Icons.bar_chart,
                          title: 'Rapports',
                          subtitle: 'Rapports généraux',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('reports'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.analytics,
                          title: 'Statistiques',
                          subtitle: 'Statistiques avancées',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('advancedStats'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.auto_awesome,
                          title: 'Rapports auto',
                          subtitle: 'Rapports automatiques',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('autoReports'),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingLarge)),
                    
                    // Section ADMINISTRATION
                    _buildSectionTitle(context, '⚙️ ADMINISTRATION'),
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                      children: [
                        _buildModuleCard(
                          context: context,
                          icon: Icons.settings,
                          title: 'Paramètres',
                          subtitle: 'Paramètres système',
                          color: AppTheme.infoColor,
                          onTap: () => context.pushNamed('settings'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.backup,
                          title: 'Backup',
                          subtitle: 'Sauvegarde des données',
                          color: AppTheme.warningColor,
                          onTap: () => context.pushNamed('backup'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.people_outline,
                          title: 'Utilisateurs',
                          subtitle: 'Gestion des comptes',
                          color: AppTheme.primaryColor,
                          onTap: () => context.pushNamed('userManagement'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.sync,
                          title: 'Sync',
                          subtitle: 'Synchronisation',
                          color: AppTheme.successColor,
                          onTap: () => context.pushNamed('sync'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.dashboard,
                          title: 'Admin Dashboard',
                          subtitle: 'Tableau de bord admin',
                          color: AppTheme.secondaryColor,
                          onTap: () => context.pushNamed('adminDashboard'),
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: Icons.history,
                          title: 'Audit Log',
                          subtitle: 'Journal d\'audit',
                          color: AppTheme.accentColor,
                          onTap: () => context.pushNamed('auditLog'),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.borderRadius)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
          child: Row(
            children: [
              Container(
                width: AppConstants.widthPercentage(context, AppConstants.iconSize),
                height: AppConstants.widthPercentage(context, AppConstants.iconSize),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
                ),
              ),
              SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(icon, color: color, size: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize)),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        
                      ],
                    ),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingTiny)),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, size: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize), color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
