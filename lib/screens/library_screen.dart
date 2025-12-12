import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';
  String _viewMode = 'grid'; // 'grid' or 'list'

  final List<Map<String, dynamic>> _categories = [
    {'id': 'all', 'name': 'Tous', 'count': 45},
    {'id': 'textbooks', 'name': 'Manuels', 'count': 18},
    {'id': 'novels', 'name': 'Romans', 'count': 12},
    {'id': 'reference', 'name': 'Ouvrages de référence', 'count': 8},
    {'id': 'digital', 'name': 'Ressources numériques', 'count': 7},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Bibliothèque',
              subtitle: 'Ressources pédagogiques',
              trailing: PrimaryButton(
                text: 'Ajouter',
                onPressed: () {
                  // TODO: Ajouter ressource
                },
                fullWidth: false,
                icon: Icons.add,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter LibraryViewModel
                    // TODO: Connecter à l'API bibliothèque
                    
                    // Search and Filters
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText: 'Rechercher une ressource...',
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
                              IconButton(
                                icon: Icon(
                                  _viewMode == 'grid' 
                                      ? Icons.grid_view 
                                      : Icons.list,
                                  color: AppTheme.primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _viewMode = _viewMode == 'grid' ? 'list' : 'grid';
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Catégories',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _categories.length,
                              itemBuilder: (context, index) {
                                final category = _categories[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text('${category['name']} (${category['count']})'),
                                    selected: _selectedCategory == category['id'],
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedCategory = category['id'];
                                      });
                                    },
                                    selectedColor: AppTheme.primaryColor,
                                    labelStyle: TextStyle(
                                      color: _selectedCategory == category['id']
                                          ? Colors.white
                                          : AppTheme.textPrimary,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistics
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildLibraryStat(
                          label: 'Ressources totales',
                          value: '245',
                          icon: Icons.library_books,
                        ),
                        _buildLibraryStat(
                          label: 'Emprunts actifs',
                          value: '38',
                          icon: Icons.bookmark,
                        ),
                        _buildLibraryStat(
                          label: 'Nouveautés ce mois',
                          value: '12',
                          icon: Icons.new_releases,
                        ),
                        _buildLibraryStat(
                          label: 'Retours en retard',
                          value: '3',
                          icon: Icons.warning,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Resources Grid/List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Ressources disponibles',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                '${_getCategoryCount()} ressources',
                                style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (_viewMode == 'grid') ...[
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.7,
                              children: [
                                _buildResourceCard(
                                  title: 'Physique Terminale',
                                  author: 'Éditions Hachette',
                                  type: 'Manuel',
                                  available: true,
                                ),
                                _buildResourceCard(
                                  title: 'Les Misérables',
                                  author: 'Victor Hugo',
                                  type: 'Roman',
                                  available: false,
                                ),
                                _buildResourceCard(
                                  title: 'Dictionnaire Larousse',
                                  author: 'Éditions Larousse',
                                  type: 'Référence',
                                  available: true,
                                ),
                                _buildResourceCard(
                                  title: 'Cours de mathématiques',
                                  author: 'Professeur Martin',
                                  type: 'Numérique',
                                  available: true,
                                ),
                              ],
                            ),
                          ] else ...[
                            Column(
                              children: [
                                _buildResourceListItem(
                                  title: 'Physique Terminale',
                                  author: 'Éditions Hachette',
                                  type: 'Manuel',
                                  available: true,
                                ),
                                const Divider(),
                                _buildResourceListItem(
                                  title: 'Les Misérables',
                                  author: 'Victor Hugo',
                                  type: 'Roman',
                                  available: false,
                                ),
                                const Divider(),
                                _buildResourceListItem(
                                  title: 'Dictionnaire Larousse',
                                  author: 'Éditions Larousse',
                                  type: 'Référence',
                                  available: true,
                                ),
                                const Divider(),
                                _buildResourceListItem(
                                  title: 'Cours de mathématiques',
                                  author: 'Professeur Martin',
                                  type: 'Numérique',
                                  available: true,
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Borrowing Section
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mes emprunts',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildBorrowItem(
                            title: 'Chimie Première',
                            dueDate: '25 Janv 2024',
                            status: 'active',
                          ),
                          const Divider(),
                          _buildBorrowItem(
                            title: 'Histoire de l\'art',
                            dueDate: '15 Janv 2024',
                            status: 'overdue',
                          ),
                          const Divider(),
                          _buildBorrowItem(
                            title: 'Géographie mondiale',
                            dueDate: 'Retourné',
                            status: 'returned',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Digital Resources
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Ressources numériques',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SecondaryButton(
                                text: 'Explorer',
                                onPressed: () {
                                  // TODO: Explorer ressources numériques
                                },
                                fullWidth: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildDigitalResource(
                                title: 'Vidéos éducatives',
                                count: '24 vidéos',
                                icon: Icons.video_library,
                              ),
                              _buildDigitalResource(
                                title: 'Quiz interactifs',
                                count: '15 quiz',
                                icon: Icons.quiz,
                              ),
                              _buildDigitalResource(
                                title: 'Présentations',
                                count: '32 présentations',
                                icon: Icons.slideshow,
                              ),
                              _buildDigitalResource(
                                title: 'Exercices',
                                count: '100+ exercices',
                                icon: Icons.assignment,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Library Actions
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Scanner code-barres',
                            onPressed: () {
                              // TODO: Scanner code-barres
                            },
                            icon: Icons.qr_code_scanner,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Rapport bibliothèque',
                            onPressed: () {
                              // TODO: Générer rapport
                            },
                            icon: Icons.assessment,
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

  Widget _buildLibraryStat({
    required String label,
    required String value,
    required IconData icon,
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
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
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
        ],
      ),
    );
  }

  Widget _buildResourceCard({
    required String title,
    required String author,
    required String type,
    required bool available,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.book, size: 50, color: AppTheme.primaryColor),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              author,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: available 
                        ? AppTheme.successColor.withOpacity(0.1)
                        : AppTheme.errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    available ? 'Disponible' : 'Emprunté',
                    style: TextStyle(
                      fontSize: 10,
                      color: available ? AppTheme.successColor : AppTheme.errorColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceListItem({
    required String title,
    required String author,
    required String type,
    required bool available,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.book, color: AppTheme.primaryColor),
      ),
      title: Text(title),
      subtitle: Text(author),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: available 
                  ? AppTheme.successColor.withOpacity(0.1)
                  : AppTheme.errorColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              available ? 'Disponible' : 'Emprunté',
              style: TextStyle(
                fontSize: 10,
                color: available ? AppTheme.successColor : AppTheme.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        // TODO: Voir détails ressource
      },
    );
  }

  Widget _buildBorrowItem({
    required String title,
    required String dueDate,
    required String status,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getStatusColor(status).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.book,
          color: _getStatusColor(status),
        ),
      ),
      title: Text(title),
      subtitle: Text('Échéance: $dueDate'),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getStatusColor(status).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _getStatusLabel(status),
          style: TextStyle(
            fontSize: 12,
            color: _getStatusColor(status),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDigitalResource({
    required String title,
    required String count,
    required IconData icon,
  }) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: AppTheme.primaryColor),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  int _getCategoryCount() {
    final category = _categories.firstWhere(
      (c) => c['id'] == _selectedCategory,
      orElse: () => _categories[0],
    );
    return category['count'] as int;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return AppTheme.successColor;
      case 'overdue':
        return AppTheme.errorColor;
      case 'returned':
        return AppTheme.textSecondary;
      default:
        return AppTheme.primaryColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'active':
        return 'Actif';
      case 'overdue':
        return 'En retard';
      case 'returned':
        return 'Retourné';
      default:
        return status;
    }
  }
}