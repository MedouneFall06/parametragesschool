import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedRecipientType = 'individual';
  bool _showNewMessage = false;

  final List<String> _recipientTypes = [
    'individual',
    'class',
    'all_parents',
    'all_teachers',
    'all_students',
  ];

  final Map<String, String> _recipientTypeLabels = {
    'individual': 'Individuel',
    'class': 'Classe',
    'all_parents': 'Tous les parents',
    'all_teachers': 'Tous les enseignants',
    'all_students': 'Tous les élèves',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Messagerie',
              subtitle: 'Communiquer avec la communauté',
              trailing: PrimaryButton(
                text: 'Nouveau',
                onPressed: () {
                  setState(() {
                    _showNewMessage = true;
                  });
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
                    // TODO: Implémenter MessagingViewModel
                    // TODO: Connecter à l'API messagerie
                    
                    // New Message Form
                    if (_showNewMessage) ...[
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Nouveau message',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _showNewMessage = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Destinataire',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: _recipientTypes.map((type) {
                                return ChoiceChip(
                                  label: Text(_recipientTypeLabels[type] ?? type),
                                  selected: _selectedRecipientType == type,
                                  onSelected: (selected) {
                                    setState(() {
                                      _selectedRecipientType = type;
                                    });
                                  },
                                  selectedColor: AppTheme.primaryColor,
                                  labelStyle: TextStyle(
                                    color: _selectedRecipientType == type
                                        ? Colors.white
                                        : AppTheme.textPrimary,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _messageController,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                hintText: 'Tapez votre message ici...',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: SecondaryButton(
                                    text: 'Annuler',
                                    onPressed: () {
                                      setState(() {
                                        _showNewMessage = false;
                                        _messageController.clear();
                                      });
                                    },
                                    icon: Icons.close,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: PrimaryButton(
                                    text: 'Envoyer',
                                    onPressed: () {
                                      if (_messageController.text.isNotEmpty) {
                                        // TODO: Envoyer message
                                        setState(() {
                                          _showNewMessage = false;
                                          _messageController.clear();
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Message envoyé'),
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
                    ],
                    
                    // Conversation List
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Conversations récentes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildConversationItem(
                            name: 'Classe Terminale S',
                            lastMessage: 'Rappel : réunion parents vendredi',
                            time: '10:30',
                            unread: 3,
                            isGroup: true,
                          ),
                          const Divider(),
                          _buildConversationItem(
                            name: 'Marie Martin (Parent)',
                            lastMessage: 'Merci pour les informations',
                            time: 'Hier',
                            unread: 0,
                            isGroup: false,
                          ),
                          const Divider(),
                          _buildConversationItem(
                            name: 'Équipe enseignante',
                            lastMessage: 'Planning de la semaine prochaine',
                            time: 'Il y a 2 jours',
                            unread: 1,
                            isGroup: true,
                          ),
                          const Divider(),
                          _buildConversationItem(
                            name: 'Jean Dupont',
                            lastMessage: 'Question sur les notes',
                            time: 'Il y a 3 jours',
                            unread: 0,
                            isGroup: false,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Message Templates
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Modèles de messages',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SecondaryButton(
                                text: 'Ajouter',
                                onPressed: () {
                                  // TODO: Ajouter modèle
                                },
                                fullWidth: false,
                                icon: Icons.add,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildMessageTemplate(
                                title: 'Absence',
                                content: 'Votre enfant était absent aujourd\'hui...',
                              ),
                              _buildMessageTemplate(
                                title: 'Réunion',
                                content: 'Réunion parents prévue le...',
                              ),
                              _buildMessageTemplate(
                                title: 'Notes',
                                content: 'Les nouvelles notes sont disponibles...',
                              ),
                              _buildMessageTemplate(
                                title: 'Rappel',
                                content: 'Rappel : devoirs pour demain...',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sent Messages
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Messages envoyés récemment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildSentMessage(
                            recipient: 'Parents de Terminale S',
                            message: 'Information réunion parents',
                            time: 'Aujourd\'hui 09:15',
                            status: 'delivered',
                          ),
                          const Divider(),
                          _buildSentMessage(
                            recipient: 'Marie Martin',
                            message: 'Réponse concernant les absences',
                            time: 'Hier 16:30',
                            status: 'read',
                          ),
                          const Divider(),
                          _buildSentMessage(
                            recipient: 'Tous les enseignants',
                            message: 'Mise à jour emploi du temps',
                            time: 'Il y a 2 jours',
                            status: 'sent',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Statistics
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildMessageStat(
                          label: 'Messages envoyés',
                          value: '128',
                          change: 'ce mois',
                        ),
                        _buildMessageStat(
                          label: 'Taux de lecture',
                          value: '85%',
                          change: '+5% cette semaine',
                        ),
                        _buildMessageStat(
                          label: 'Destinataires actifs',
                          value: '95',
                          change: 'utilisateurs',
                        ),
                        _buildMessageStat(
                          label: 'Messages groupés',
                          value: '42',
                          change: 'ce mois',
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

  Widget _buildConversationItem({
    required String name,
    required String lastMessage,
    required String time,
    required int unread,
    required bool isGroup,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isGroup ? AppTheme.accentColor : AppTheme.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isGroup ? Icons.group : Icons.person,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(name),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          if (unread > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unread.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        // TODO: Ouvrir conversation
      },
    );
  }

  Widget _buildMessageTemplate({
    required String title,
    required String content,
  }) {
    return InkWell(
      onTap: () {
        _messageController.text = content;
        setState(() {
          _showNewMessage = true;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentMessage({
    required String recipient,
    required String message,
    required String time,
    required String status,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.send, color: AppTheme.primaryColor, size: 20),
      ),
      title: Text(recipient),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Icon(
            _getStatusIcon(status),
            size: 16,
            color: _getStatusColor(status),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageStat({
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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'delivered':
        return Icons.done_all;
      case 'read':
        return Icons.done_all;
      case 'sent':
        return Icons.done;
      default:
        return Icons.schedule;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return AppTheme.textSecondary;
      case 'read':
        return AppTheme.successColor;
      case 'sent':
        return AppTheme.primaryColor;
      default:
        return AppTheme.warningColor;
    }
  }
}