import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class TechnicalSupportScreen extends StatefulWidget {
  const TechnicalSupportScreen({super.key});

  @override
  State<TechnicalSupportScreen> createState() => _TechnicalSupportScreenState();
}

class _TechnicalSupportScreenState extends State<TechnicalSupportScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'technical';
  String _selectedPriority = 'medium';
  List<String> _attachments = [];

  final List<String> _categories = [
    'technical',
    'bug',
    'feature_request',
    'account',
    'other',
  ];

  final Map<String, String> _categoryLabels = {
    'technical': 'Problème technique',
    'bug': 'Bug/Rapport d\'erreur',
    'feature_request': 'Demande de fonctionnalité',
    'account': 'Problème de compte',
    'other': 'Autre',
  };

  final Map<String, String> _priorityLabels = {
    'low': 'Basse',
    'medium': 'Moyenne',
    'high': 'Haute',
    'urgent': 'Urgent',
  };

  final Map<String, Color> _priorityColors = {
    'low': AppTheme.successColor,
    'medium': AppTheme.warningColor,
    'high': AppTheme.errorColor,
    'urgent': AppTheme.errorColor,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Support technique',
              subtitle: 'Assistance et dépannage',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter TechnicalSupportViewModel
                    // TODO: Connecter à l'API support
                    
                    // Quick Solutions
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Solutions rapides',
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
                              _buildQuickSolution(
                                icon: Icons.refresh,
                                title: 'Redémarrer l\'app',
                                description: 'Solution à 80% des problèmes',
                              ),
                              _buildQuickSolution(
                                icon: Icons.wifi,
                                title: 'Vérifier connexion',
                                description: 'Problèmes de synchronisation',
                              ),
                              _buildQuickSolution(
                                icon: Icons.update,
                                title: 'Mettre à jour',
                                description: 'Version la plus récente',
                              ),
                              _buildQuickSolution(
                                icon: Icons.clear_all,
                                title: 'Vider le cache',
                                description: 'Problèmes d\'affichage',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // New Ticket Form
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nouveau ticket',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Catégorie',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: _categories.map((category) {
                              return ChoiceChip(
                                label: Text(_categoryLabels[category] ?? category),
                                selected: _selectedCategory == category,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                                selectedColor: AppTheme.primaryColor,
                                labelStyle: TextStyle(
                                  color: _selectedCategory == category
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _subjectController,
                            decoration: const InputDecoration(
                              labelText: 'Sujet',
                              hintText: 'Décrivez brièvement le problème',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              labelText: 'Description détaillée',
                              hintText: 'Décrivez le problème en détail...',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Priorité',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildPriorityButton('Basse', 'low'),
                              const SizedBox(width: 8),
                              _buildPriorityButton('Moyenne', 'medium'),
                              const SizedBox(width: 8),
                              _buildPriorityButton('Haute', 'high'),
                              const SizedBox(width: 8),
                              _buildPriorityButton('Urgent', 'urgent'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Attachments
                          if (_attachments.isNotEmpty) ...[
                            const Text(
                              'Pièces jointes',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: _attachments.map((attachment) {
                                return Chip(
                                  label: Text(attachment),
                                  onDeleted: () {
                                    setState(() {
                                      _attachments.remove(attachment);
                                    });
                                  },
                                  deleteIconColor: AppTheme.errorColor,
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                          ],
                          Row(
                            children: [
                              SecondaryButton(
                                text: 'Ajouter fichier',
                                onPressed: () {
                                  // TODO: Ajouter pièce jointe
                                  setState(() {
                                    _attachments.add('capture_${_attachments.length + 1}.png');
                                  });
                                },
                                icon: Icons.attach_file,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Envoyer le ticket',
                                  onPressed: () {
                                    if (_subjectController.text.isNotEmpty &&
                                        _descriptionController.text.isNotEmpty) {
                                      // TODO: Envoyer ticket
                                      _subjectController.clear();
                                      _descriptionController.clear();
                                      _attachments.clear();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Ticket envoyé au support'),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icons.send,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // My Tickets
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mes tickets',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SecondaryButton(
                                text: 'Voir tout',
                                onPressed: () {
                                  // TODO: Voir tous les tickets
                                },
                                fullWidth: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildTicketItem(
                            id: 'TKT-2024-001',
                            subject: 'Problème de synchronisation',
                            category: 'technical',
                            status: 'open',
                            date: '15 Janv 2024',
                            priority: 'high',
                          ),
                          const Divider(),
                          _buildTicketItem(
                            id: 'TKT-2024-002',
                            subject: 'Demande de nouvelle fonctionnalité',
                            category: 'feature_request',
                            status: 'in_progress',
                            date: '10 Janv 2024',
                            priority: 'medium',
                          ),
                          const Divider(),
                          _buildTicketItem(
                            id: 'TKT-2023-045',
                            subject: 'Bug affichage notes',
                            category: 'bug',
                            status: 'resolved',
                            date: '5 Déc 2023',
                            priority: 'high',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Knowledge Base
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Base de connaissances',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildKnowledgeItem(
                            title: 'Guide d\'installation',
                            description: 'Comment installer et configurer l\'application',
                            views: '1,245 vues',
                          ),
                          const Divider(),
                          _buildKnowledgeItem(
                            title: 'FAQ Synchronisation',
                            description: 'Problèmes courants de synchronisation',
                            views: '892 vues',
                          ),
                          const Divider(),
                          _buildKnowledgeItem(
                            title: 'Guide utilisateur',
                            description: 'Manuel complet d\'utilisation',
                            views: '2,150 vues',
                          ),
                          const Divider(),
                          _buildKnowledgeItem(
                            title: 'Dépannage Wi-Fi',
                            description: 'Résoudre les problèmes de connexion',
                            views: '567 vues',
                          ),
                        ],
                      ),
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
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: AppTheme.successColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Tous les systèmes sont opérationnels',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Dernière vérification: Aujourd\'hui 10:30',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Contact Options
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _buildContactOption(
                          icon: Icons.phone,
                          title: 'Support téléphonique',
                          description: 'Lun-Ven 9h-18h',
                          color: AppTheme.primaryColor,
                        ),
                        _buildContactOption(
                          icon: Icons.email,
                          title: 'Email support',
                          description: 'Réponse sous 24h',
                          color: AppTheme.accentColor,
                        ),
                        _buildContactOption(
                          icon: Icons.chat,
                          title: 'Chat en direct',
                          description: 'Disponible maintenant',
                          color: AppTheme.secondaryColor,
                        ),
                        _buildContactOption(
                          icon: Icons.forum,
                          title: 'Communauté',
                          description: 'Forum d\'entraide',
                          color: AppTheme.infoColor,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Emergency Contact
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.errorColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: AppTheme.errorColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Urgence technique',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Pour les problèmes critiques affectant tout l\'établissement',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PrimaryButton(
                            text: 'Contacter',
                            onPressed: () {
                              // TODO: Contact urgence
                            },
                            fullWidth: false,
                          ),
                        ],
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

  Widget _buildQuickSolution({
    required IconData icon,
    required String title,
    required String description,
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
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityButton(String label, String priority) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedPriority == priority,
      onSelected: (selected) {
        setState(() {
          _selectedPriority = priority;
        });
      },
      selectedColor: _priorityColors[priority],
      labelStyle: TextStyle(
        color: _selectedPriority == priority ? Colors.white : AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildTicketItem({
    required String id,
    required String subject,
    required String category,
    required String status,
    required String date,
    required String priority,
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
          _getStatusIcon(status),
          color: _getStatusColor(status),
        ),
      ),
      title: Text(subject),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$id • $date'),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _priorityColors[priority]!.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _priorityLabels[priority]!,
                  style: TextStyle(
                    fontSize: 10,
                    color: _priorityColors[priority],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getStatusLabel(status),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
    );
  }

  Widget _buildKnowledgeItem({
    required String title,
    required String description,
    required String views,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.article, color: AppTheme.primaryColor),
      ),
      title: Text(title),
      subtitle: Text(description),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            views,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const Icon(Icons.download, size: 16, color: AppTheme.primaryColor),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return AppTheme.warningColor;
      case 'in_progress':
        return AppTheme.infoColor;
      case 'resolved':
        return AppTheme.successColor;
      case 'closed':
        return AppTheme.textSecondary;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'open':
        return Icons.pending;
      case 'in_progress':
        return Icons.build;
      case 'resolved':
        return Icons.check_circle;
      case 'closed':
        return Icons.archive;
      default:
        return Icons.help;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'open':
        return 'Ouvert';
      case 'in_progress':
        return 'En cours';
      case 'resolved':
        return 'Résolu';
      case 'closed':
        return 'Fermé';
      default:
        return status;
    }
  }
}