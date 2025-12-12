import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class TeacherEvaluationScreen extends StatefulWidget {
  const TeacherEvaluationScreen({super.key});

  @override
  State<TeacherEvaluationScreen> createState() => _TeacherEvaluationScreenState();
}

class _TeacherEvaluationScreenState extends State<TeacherEvaluationScreen> {
  String _selectedTeacher = 'all';
  String _selectedPeriod = 'current';
  final Map<String, int> _ratings = {
    'Préparation des cours': 4,
    'Clarté des explications': 5,
    'Disponibilité': 4,
    'Relation avec les élèves': 5,
    'Qualité des évaluations': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Évaluation enseignants',
              subtitle: 'Suivi pédagogique et feedback',
              trailing: PrimaryButton(
                text: 'Nouvelle évaluation',
                onPressed: () {
                  // TODO: Créer évaluation
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
                    // TODO: Implémenter TeacherEvaluationViewModel
                    // TODO: Connecter à l'API évaluations
                    
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
                                child: DropdownButtonFormField<String>(
                                  value: _selectedTeacher,
                                  decoration: const InputDecoration(
                                    labelText: 'Enseignant',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'all',
                                      child: Text('Tous les enseignants'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'teacher1',
                                      child: Text('Jean Dupont - Mathématiques'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'teacher2',
                                      child: Text('Marie Martin - Physique'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'teacher3',
                                      child: Text('Pierre Bernard - Histoire'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTeacher = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: _selectedPeriod,
                                  decoration: const InputDecoration(
                                    labelText: 'Période',
                                    border: OutlineInputBorder(),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'current',
                                      child: Text('Trimestre actuel'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'previous',
                                      child: Text('Trimestre précédent'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'year',
                                      child: Text('Année scolaire'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPeriod = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Overall Statistics
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _buildEvaluationStat(
                          label: 'Moyenne générale',
                          value: '4.2/5',
                          change: '+0.3 vs trimestre précédent',
                          color: AppTheme.primaryColor,
                        ),
                        _buildEvaluationStat(
                          label: 'Évaluations complétées',
                          value: '85%',
                          change: '45 sur 53 enseignants',
                          color: AppTheme.accentColor,
                        ),
                        _buildEvaluationStat(
                          label: 'Satisfaction élèves',
                          value: '4.5/5',
                          change: '+0.2 points',
                          color: AppTheme.successColor,
                        ),
                        _buildEvaluationStat(
                          label: 'Retours en attente',
                          value: '8',
                          change: 'Action requise',
                          color: AppTheme.warningColor,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Teacher List with Ratings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enseignants évalués',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildTeacherEvaluationItem(
                            name: 'Jean Dupont',
                            subject: 'Mathématiques',
                            rating: 4.2,
                            evaluations: 24,
                            trend: 'up',
                          ),
                          const Divider(),
                          _buildTeacherEvaluationItem(
                            name: 'Marie Martin',
                            subject: 'Physique-Chimie',
                            rating: 4.5,
                            evaluations: 18,
                            trend: 'stable',
                          ),
                          const Divider(),
                          _buildTeacherEvaluationItem(
                            name: 'Pierre Bernard',
                            subject: 'Histoire-Géographie',
                            rating: 3.8,
                            evaluations: 22,
                            trend: 'down',
                          ),
                          const Divider(),
                          _buildTeacherEvaluationItem(
                            name: 'Sophie Leroy',
                            subject: 'Anglais',
                            rating: 4.7,
                            evaluations: 20,
                            trend: 'up',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Detailed Ratings
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Détail des évaluations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._ratings.entries.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.key,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${entry.value}/5',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: entry.value / 5,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getRatingColor(entry.value),
                                    ),
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Insuffisant',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        _getRatingLabel(entry.value),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: _getRatingColor(entry.value),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Text(
                                        'Excellent',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Comments and Feedback
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Commentaires récents',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildCommentItem(
                            teacher: 'Jean Dupont',
                            comment: 'Excellent professeur, très clair dans ses explications.',
                            author: 'Élève de Terminale S',
                            date: '15 Janv 2024',
                            rating: 5,
                          ),
                          const Divider(),
                          _buildCommentItem(
                            teacher: 'Marie Martin',
                            comment: 'Pourrait améliorer la disponibilité en dehors des cours.',
                            author: 'Parent d\'élève',
                            date: '14 Janv 2024',
                            rating: 3,
                          ),
                          const Divider(),
                          _buildCommentItem(
                            teacher: 'Pierre Bernard',
                            comment: 'Cours très intéressants, bonne pédagogie.',
                            author: 'Élève de Première',
                            date: '12 Janv 2024',
                            rating: 4,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Evaluation Form
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Formulaire d\'évaluation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Clarté des explications',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  index < 3 ? Icons.star : Icons.star_border,
                                  color: AppTheme.warningColor,
                                  size: 30,
                                ),
                                onPressed: () {
                                  // TODO: Mettre à jour note
                                },
                              );
                            }),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Votre commentaire (optionnel)',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintText: 'Partagez vos observations...',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Soumettre l\'évaluation',
                            onPressed: () {
                              // TODO: Soumettre évaluation
                            },
                            fullWidth: true,
                            icon: Icons.send,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Reports and Analysis
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Exporter données',
                            onPressed: () {
                              // TODO: Exporter évaluations
                            },
                            icon: Icons.download,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Rapport d\'analyse',
                            onPressed: () {
                              // TODO: Générer rapport
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

  Widget _buildEvaluationStat({
    required String label,
    required String value,
    required String change,
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
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w600,
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
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherEvaluationItem({
    required String name,
    required String subject,
    required double rating,
    required int evaluations,
    required String trend,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.person, color: AppTheme.primaryColor),
      ),
      title: Text(name),
      subtitle: Text(subject),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '/5',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                _getTrendIcon(trend),
                color: _getTrendColor(trend),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$evaluations évaluations',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem({
    required String teacher,
    required String comment,
    required String author,
    required String date,
    required int rating,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: AppTheme.primaryColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teacher,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$author • $date',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  size: 16,
                  color: AppTheme.warningColor,
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          comment,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Color _getRatingColor(int rating) {
    if (rating >= 4) return AppTheme.successColor;
    if (rating >= 3) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  String _getRatingLabel(int rating) {
    if (rating >= 4.5) return 'Excellent';
    if (rating >= 4) return 'Très bon';
    if (rating >= 3) return 'Bon';
    if (rating >= 2) return 'Moyen';
    return 'Insuffisant';
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case 'up':
        return AppTheme.successColor;
      case 'down':
        return AppTheme.errorColor;
      default:
        return AppTheme.warningColor;
    }
  }
}