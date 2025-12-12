import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Gestion des utilisateurs',
              subtitle: 'Gérer les comptes et permissions',
              trailing: PrimaryButton(
                text: 'Nouveau',
                onPressed: () {
                  // TODO: Naviguer vers création utilisateur
                },
                fullWidth: false,
                icon: Icons.person_add,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter UserManagementViewModel
                    // TODO: Connecter à l'API users
                    
                    // Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filtres',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Rechercher un utilisateur...',
                                    prefixIcon: Icon(Icons.search),
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  onChanged: (value) {
                                    // TODO: Implémenter recherche
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              SecondaryButton(
                                text: 'Filtrer',
                                onPressed: () {
                                  // TODO: Ouvrir modal filtres
                                },
                                icon: Icons.filter_list,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildFilterChip('Tous', true),
                              _buildFilterChip('Enseignants', false),
                              _buildFilterChip('Parents', false),
                              _buildFilterChip('Administrateurs', false),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Users List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Utilisateurs (15)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                '3 actifs maintenant',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildUserItem(
                            name: 'Jean Dupont',
                            email: 'jean.dupont@ecole.com',
                            role: 'Enseignant',
                            isActive: true,
                            lastLogin: 'Aujourd\'hui 10:30',
                          ),
                          const Divider(),
                          _buildUserItem(
                            name: 'Marie Martin',
                            email: 'marie.martin@ecole.com',
                            role: 'Parent',
                            isActive: false,
                            lastLogin: 'Hier 15:45',
                          ),
                          const Divider(),
                          _buildUserItem(
                            name: 'Pierre Bernard',
                            email: 'pierre.bernard@ecole.com',
                            role: 'Administrateur',
                            isActive: true,
                            lastLogin: 'Aujourd\'hui 09:15',
                          ),
                          const Divider(),
                          _buildUserItem(
                            name: 'Sophie Leroy',
                            email: 'sophie.leroy@ecole.com',
                            role: 'Enseignant',
                            isActive: true,
                            lastLogin: 'Aujourd\'hui 11:20',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Bulk Actions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Actions groupées',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Exporter CSV',
                                  onPressed: () {
                                    // TODO: Exporter utilisateurs
                                  },
                                  icon: Icons.download,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Désactiver sélection',
                                  onPressed: () {
                                    // TODO: Désactiver utilisateurs
                                  },
                                  icon: Icons.block,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          PrimaryButton(
                            text: 'Envoyer notification',
                            onPressed: () {
                              // TODO: Envoyer notification groupée
                            },
                            fullWidth: true,
                            icon: Icons.notifications,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // User Statistics
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildUserStat(
                          label: 'Utilisateurs actifs',
                          value: '12',
                          change: '+2 cette semaine',
                        ),
                        _buildUserStat(
                          label: 'Nouveaux ce mois',
                          value: '3',
                          change: '+1 vs dernier mois',
                        ),
                        _buildUserStat(
                          label: 'Taux d\'activité',
                          value: '85%',
                          change: '+5% cette semaine',
                        ),
                        _buildUserStat(
                          label: 'En attente',
                          value: '2',
                          change: 'Validation requise',
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

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) {
        // TODO: Implémenter filtre
      },
      selectedColor: AppTheme.primaryColor,
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildUserItem({
    required String name,
    required String email,
    required String role,
    required bool isActive,
    required String lastLogin,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getRoleColor(role),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            name.substring(0, 1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Text(name),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getRoleColor(role).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              role,
              style: TextStyle(
                fontSize: 10,
                color: _getRoleColor(role),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(email),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? AppTheme.successColor : AppTheme.errorColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                isActive ? 'En ligne' : 'Hors ligne',
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? AppTheme.successColor : AppTheme.errorColor,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.schedule, size: 12, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
              Text(
                lastLogin,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text('Modifier'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'reset',
            child: Row(
              children: [
                Icon(Icons.lock_reset, size: 18),
                SizedBox(width: 8),
                Text('Réinitialiser mot de passe'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'disable',
            child: Row(
              children: [
                Icon(Icons.block, size: 18),
                SizedBox(width: 8),
                Text('Désactiver'),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          // TODO: Implémenter actions
        },
      ),
    );
  }

  Widget _buildUserStat({
    required String label,
    required String value,
    required String change,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'administrateur':
        return AppTheme.warningColor;
      case 'enseignant':
        return AppTheme.accentColor;
      case 'parent':
        return AppTheme.secondaryColor;
      default:
        return AppTheme.primaryColor;
    }
  }
}