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
              showBackButton: false, // ← DÉSACTIVER LE BOUTON RETOUR
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Modules principaux',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        // CORRECTION : 'context,' a été retiré de chaque appel
                        _buildModuleCard(
                          icon: Icons.class_,
                          title: 'Classes',
                          subtitle: 'Gérer les classes et les niveaux',
                          color: AppTheme.primaryColor,
                          onTap: () {

                            // ==================== CORRECTION ICI ====================
                            // Remplacez 'goNamed' par 'pushNamed' pour ajouter la page
                            // à la pile de navigation et permettre le retour.
                            context.pushNamed('classes');
                          },
                        ),

                        _buildModuleCard(
                          icon: Icons.menu_book,
                          title: 'Matières',
                          subtitle: 'Configurer les matières et coefficients',
                          color: AppTheme.accentColor,
                          onTap: () {
                            context.pushNamed('matieres');
                          },
                        ),

                        _buildModuleCard(
                          icon: Icons.school,
                          title: 'Enseignants',
                          subtitle: 'Gérer le personnel enseignant',
                          color: AppTheme.secondaryColor,
                          onTap: () {
                            context.pushNamed('enseignants');
                          },
                        ),

                        _buildModuleCard(
                          icon: Icons.people_alt,
                          title: 'Étudiants',
                          subtitle: 'Gérer les fiches des étudiants',
                          color: AppTheme.successColor,
                          onTap: () {
                            context.push('/etudiants');
                          },
                        ),

                        _buildModuleCard(
                          icon: Icons.calendar_today,
                          title: 'Emploi du temps',
                          subtitle: 'Planifier les cours',
                          color: AppTheme.warningColor,
                          onTap: () {
                            context.pushNamed('schedule');
                          },
                        ),

                        _buildModuleCard(
                          icon: Icons.bar_chart,
                          title: 'Rapports',
                          subtitle: 'Consulter les statistiques',
                          color: AppTheme.infoColor,
                          onTap: () {
                            context.pushNamed('reports');
                          },
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

  // CORRECTION : 'context' a été retiré des paramètres de la fonction
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
