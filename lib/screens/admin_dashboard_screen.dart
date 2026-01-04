import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter AdminDashboardViewModel
                    // TODO: Connecter à l'API admin
                    
                    // Statistics Grid
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // System Status
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'État du système',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildStatusItem(
                            context: context,
                            label: 'Serveur API',
                            status: 'En ligne',
                            isOnline: true,
                          ),
                          const Divider(),
                          _buildStatusItem(
                            context: context,
                            label: 'Base de données',
                            status: 'Opérationnel',
                            isOnline: true,
                          ),
                          const Divider(),
                          _buildStatusItem(
                            context: context,
                            label: 'Stockage fichiers',
                            status: '92% utilisé',
                            isOnline: true,
                          ),
                          const Divider(),
                          _buildStatusItem(
                            context: context,
                            label: 'Sauvegarde',
                            status: 'Hier 02:00',
                            isOnline: true,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Quick Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Actions rapides',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              _buildQuickAction(
                                context: context,
                                icon: Icons.person_add,
                                label: 'Nouvel utilisateur',
                                onTap: () {
                                  // TODO: Naviguer vers création utilisateur
                                },
                              ),
                              _buildQuickAction(
                                context: context,
                                icon: Icons.backup,
                                label: 'Sauvegarde',
                                onTap: () {
                                  // TODO: Lancer sauvegarde
                                },
                              ),
                              _buildQuickAction(
                                context: context,
                                icon: Icons.bar_chart,
                                label: 'Rapports',
                                onTap: () {
                                  // TODO: Naviguer vers rapports
                                },
                              ),
                              _buildQuickAction(
                                context: context,
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Recent Activity
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Activité récente',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
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
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          // TODO: Remplacer par ListView.builder avec données dynamiques
                          _buildActivityItem(
                            context: context,
                            user: 'Admin System',
                            action: 'Sauvegarde automatique',
                            time: 'Il y a 2 heures',
                          ),
                          const Divider(),
                          _buildActivityItem(
                            context: context,
                            user: 'Jean Dupont',
                            action: 'Création d\'une nouvelle classe',
                            time: 'Il y a 3 heures',
                          ),
                          const Divider(),
                          _buildActivityItem(
                            context: context,
                            user: 'Marie Martin',
                            action: 'Importation d\'étudiants',
                            time: 'Il y a 5 heures',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // System Actions
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        PrimaryButton(
                          text: 'Maintenance système',
                          onPressed: () {
                            // TODO: Ouvrir modal maintenance
                          },
                          icon: Icons.engineering,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Analytics',
                          onPressed: () {
                            // TODO: Naviguer vers analytics
                          },
                          icon: Icons.analytics,
                          fullWidth: true,
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

  Widget _buildStatusItem({
    required BuildContext context,
    required String label,
    required String status,
    required bool isOnline,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
        height: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
        decoration: BoxDecoration(
          color: isOnline ? AppTheme.successColor : AppTheme.errorColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        status,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      child: Container(
        width: AppConstants.widthPercentage(context, AppConstants.minCardWidth),
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.iconSize)),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required BuildContext context,
    required String user,
    required String action,
    required String time,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.person, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
      ),
      title: Text(
        user,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        action,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
      trailing: Text(
        time,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
          color: AppTheme.textSecondary,
        ),
      ),
    );
  }
}
