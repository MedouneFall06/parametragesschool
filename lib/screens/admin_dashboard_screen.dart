import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Tableau de bord Admin',
              subtitle: 'Vue d\'ensemble du système',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter AdminDashboardViewModel
                    // TODO: Connecter à l'API admin
                    
                    // Statistics Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        StatCard(
                          title: 'Utilisateurs',
                          value: '150',
                          icon: Icons.people,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Étudiants',
                          value: '320',
                          icon: Icons.school,
                          color: AppTheme.accentColor,
                        ),
                        StatCard(
                          title: 'Classes',
                          value: '18',
                          icon: Icons.class_,
                          color: AppTheme.secondaryColor,
                        ),
                        StatCard(
                          title: 'Enseignants',
                          value: '45',
                          icon: Icons.person,
                          color: AppTheme.infoColor,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // System Status
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'État du système',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildStatusItem(
                            label: 'Serveur API',
                            status: 'En ligne',
                            isOnline: true,
                          ),
                          const Divider(),
                          _buildStatusItem(
                            label: 'Base de données',
                            status: 'Opérationnel',
                            isOnline: true,
                          ),
                          const Divider(),
                          _buildStatusItem(
                            label: 'Stockage fichiers',
                            status: '92% utilisé',
                            isOnline: true,
                          ),
                          const Divider(),
                          _buildStatusItem(
                            label: 'Sauvegarde',
                            status: 'Hier 02:00',
                            isOnline: true,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Quick Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actions rapides',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildQuickAction(
                                icon: Icons.person_add,
                                label: 'Nouvel utilisateur',
                                onTap: () {
                                  // TODO: Naviguer vers création utilisateur
                                },
                              ),
                              _buildQuickAction(
                                icon: Icons.backup,
                                label: 'Sauvegarde',
                                onTap: () {
                                  // TODO: Lancer sauvegarde
                                },
                              ),
                              _buildQuickAction(
                                icon: Icons.bar_chart,
                                label: 'Rapports',
                                onTap: () {
                                  // TODO: Naviguer vers rapports
                                },
                              ),
                              _buildQuickAction(
                                icon: Icons.settings,
                                label: 'Configuration',
                                onTap: () {
                                  // TODO: Naviguer vers config système
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Recent Activity
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Activité récente',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Voir tout',
                                onPressed: () {
                                  // TODO: Naviguer vers journal d'activité
                                },
                                fullWidth: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder avec données dynamiques
                          _buildActivityItem(
                            user: 'Admin System',
                            action: 'Sauvegarde automatique',
                            time: 'Il y a 2 heures',
                          ),
                          const Divider(),
                          _buildActivityItem(
                            user: 'Jean Dupont',
                            action: 'Création d\'une nouvelle classe',
                            time: 'Il y a 3 heures',
                          ),
                          const Divider(),
                          _buildActivityItem(
                            user: 'Marie Martin',
                            action: 'Importation d\'étudiants',
                            time: 'Il y a 5 heures',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // System Actions
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Maintenance système',
                            onPressed: () {
                              // TODO: Ouvrir modal maintenance
                            },
                            icon: Icons.engineering,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Analytics',
                            onPressed: () {
                              // TODO: Naviguer vers analytics
                            },
                            icon: Icons.analytics,
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

  Widget _buildStatusItem({
    required String label,
    required String status,
    required bool isOnline,
  }) {
    return ListTile(
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: isOnline ? AppTheme.successColor : AppTheme.errorColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(label),
      subtitle: Text(status),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required String user,
    required String action,
    required String time,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.person, color: AppTheme.primaryColor),
      ),
      title: Text(user),
      subtitle: Text(action),
      trailing: Text(
        time,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }
}