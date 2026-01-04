import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/scrollable_content.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

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
                            width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                            height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.school,
                              size: AppConstants.widthPercentage(context, AppConstants.iconSize),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Paramétrages School',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Version 1.0.0',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Application de gestion scolaire complète pour les établissements éducatifs.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                              height: AppConstants.textHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Statistics
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Étudiants',
                          value: '250+',
                          icon: Icons.group,
                          color: AppTheme.primaryColor,
                        ),
                        StatCard(
                          title: 'Classes',
                          value: '15',
                          icon: Icons.school,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    StatCard(
                      title: 'Enseignants',
                      value: '30',
                      icon: Icons.person,
                      color: AppTheme.secondaryColor,
                    ),
                    
                    SizedBox(height: AppConstants.fixedHeightSmall),
                    
                    // Developer Team Section
                    _buildSectionTitle(context, 'Équipe de développement'),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    InfoCard(
                      child: Column(
                        children: [
                          _buildTeamMember(
                            context: context,
                            name: 'Équipe Technique',
                            role: 'Développement & Design',
                          ),
                          const Divider(),
                          _buildTeamMember(
                            context: context,
                            name: 'Équipe Pédagogique',
                            role: 'Experts Éducation',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.fixedHeightSmall),
                    
                    // Features Section
                    _buildSectionTitle(context, 'Fonctionnalités principales'),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    Column(
                      children: [
                        _buildFeatureItem(
                          context: context,
                          icon: Icons.people,
                          title: 'Gestion des élèves',
                          description: 'Suivi complet des étudiants',
                        ),
                        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                        _buildFeatureItem(
                          context: context,
                          icon: Icons.assignment,
                          title: 'Notes et évaluations',
                          description: 'Saisie et analyse des résultats',
                        ),
                        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                        _buildFeatureItem(
                          context: context,
                          icon: Icons.calendar_today,
                          title: 'Emploi du temps',
                          description: 'Planification des cours',
                        ),
                        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                        _buildFeatureItem(
                          context: context,
                          icon: Icons.cloud_off,
                          title: 'Mode hors ligne',
                          description: 'Travaillez sans connexion',
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.fixedHeightLarge),
                    
                    // Action Buttons
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        PrimaryButton(
                          text: 'Noter l\'application',
                          onPressed: () {
                            // Ouvrir store
                          },
                          icon: Icons.star,
                          fullWidth: true,
                        ),
                        SecondaryButton(
                          text: 'Partager',
                          onPressed: () {
                            // Partage
                          },
                          icon: Icons.share,
                          fullWidth: true,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    Text(
                      '© 2024 Paramétrages School. Tous droits réservés.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          height: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
          width: AppConstants.widthPercentage(context, AppConstants.spacingLarge),
          color: AppTheme.primaryColor,
        ),
        SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
        Text(
          title,
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamMember({
    required BuildContext context,
    required String name,
    required String role,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.person,
          color: AppTheme.primaryColor,
          size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        role,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      child: ListTile(
        leading: Container(
          width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
          height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
          ),
        ),
      ),
    );
  }
}
