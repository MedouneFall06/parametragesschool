import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final User user;
  
  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Mon profil',
              subtitle: 'Gérer vos informations personnelles',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile Header
                    InfoCard(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                _getInitials(user.prenom, user.nom),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${user.prenom} ${user.nom}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getRoleColor(user.role),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              user.role.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            user.email,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Personal Information
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informations personnelles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoItem(
                            icon: Icons.person,
                            label: 'Nom complet',
                            value: '${user.prenom} ${user.nom}',
                          ),
                          const Divider(),
                          _buildInfoItem(
                            icon: Icons.email,
                            label: 'Adresse email',
                            value: user.email,
                          ),
                          const Divider(),
                          _buildInfoItem(
                            icon: Icons.work,
                            label: 'Rôle',
                            value: user.role,
                          ),
                          const Divider(),
                          _buildInfoItem(
                            icon: Icons.badge,
                            label: 'ID utilisateur',
                            value: user.id,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Account Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actions du compte',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SecondaryButton(
                            text: 'Modifier le profil',
                            onPressed: () {
                              // Éditer profil
                            },
                            fullWidth: true,
                            icon: Icons.edit,
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Changer le mot de passe',
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgot-password');
                            },
                            fullWidth: true,
                            icon: Icons.lock,
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Sécurité du compte',
                            onPressed: () {
                              // Sécurité
                            },
                            fullWidth: true,
                            icon: Icons.security,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Statistiques',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildStatItem(
                                label: 'Jours actifs',
                                value: '128',
                                icon: Icons.calendar_today,
                              ),
                              const SizedBox(width: 16),
                              _buildStatItem(
                                label: 'Élèves suivis',
                                value: '25',
                                icon: Icons.people,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildStatItem(
                                label: 'Notes saisies',
                                value: '320',
                                icon: Icons.assignment,
                              ),
                              const SizedBox(width: 16),
                              _buildStatItem(
                                label: 'Notifications',
                                value: '45',
                                icon: Icons.notifications,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Logout Button
                    PrimaryButton(
                      text: 'Déconnexion',
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      fullWidth: true,
                      icon: Icons.logout,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Delete Account
                    TextButton(
                      onPressed: () {
                        // Supprimer compte
                      },
                      child: const Text(
                        'Supprimer mon compte',
                        style: TextStyle(
                          color: AppTheme.errorColor,
                        ),
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

  String _getInitials(String prenom, String nom) {
    String initials = "";
    if (prenom.isNotEmpty) initials += prenom[0];
    if (nom.isNotEmpty) initials += nom[0];
    return initials;
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'enseignant':
        return AppTheme.accentColor;
      case 'parent':
        return AppTheme.secondaryColor;
      case 'agent':
        return AppTheme.infoColor;
      case 'admin':
        return AppTheme.warningColor;
      default:
        return AppTheme.primaryColor;
    }
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Déconnexion',
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }
}