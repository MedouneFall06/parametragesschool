import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
// TODO: Importer les modèles et services de statistiques

class AdvancedStatsScreen extends StatefulWidget {
  const AdvancedStatsScreen({super.key});

  @override
  State<AdvancedStatsScreen> createState() => _AdvancedStatsScreenState();
}

class _AdvancedStatsScreenState extends State<AdvancedStatsScreen> {
  String _selectedPeriod = 'month';
  String _selectedStatType = 'grades';
  
  // TODO: Remplacer par des données réelles depuis ViewModel
  //final Map<String, List<double>> _gradeTrend = [14.5, 15.2, 14.8, 16.0, 15.5, 16.2];
  final List<double> _gradeTrend = [14.5, 15.2, 14.8, 16.0, 15.5, 16.2];
  final Map<String, int> _attendanceStats = {
    'Présent': 85,
    'Absent': 10,
    'Retard': 5,
  };
  
  final List<Map<String, dynamic>> _topStudents = [
    {'name': 'Fall Medoune', 'average': 17.2, 'improvement': '+1.5'},
    {'name': 'Diop Awa', 'average': 16.8, 'improvement': '+0.8'},
    {'name': 'Ndoye Moussa', 'average': 16.5, 'improvement': '+2.1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Statistiques avancées'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filtres
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Filtres',
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Période',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    DropdownButtonFormField<String>(
                                      value: _selectedPeriod,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'week',
                                          child: Text('Cette semaine'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'month',
                                          child: Text('Ce mois'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'quarter',
                                          child: Text('Ce trimestre'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'year',
                                          child: Text('Cette année'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPeriod = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Type de statistiques',
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    DropdownButtonFormField<String>(
                                      value: _selectedStatType,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'grades',
                                          child: Text('Notes'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'attendance',
                                          child: Text('Présences'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'performance',
                                          child: Text('Performance'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedStatType = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Appliquer les filtres',
                            onPressed: () {
                              // TODO: Recharger les statistiques
                            },
                            fullWidth: true,
                            icon: Icons.filter_alt,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistiques globales
                    const Text(
                      'Vue d\'ensemble',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Moyenne générale',
                            value: '15.8',
                            icon: Icons.trending_up,
                            color: AppTheme.successColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Taux de présence',
                            value: '92%',
                            icon: Icons.people,
                            color: AppTheme.infoColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Meilleure moyenne',
                            value: '17.2',
                            icon: Icons.emoji_events,
                            color: AppTheme.warningColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Évolution',
                            value: '+2.1%',
                            icon: Icons.show_chart,
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Graphique des tendances
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Évolution des moyennes',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 200,
                            child: _buildTrendChart(),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sep', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Oct', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Nov', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Dec', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Jan', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Feb', style: TextStyle(color: AppTheme.textSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Répartition des présences
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Répartition des présences',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 150,
                            child: _buildAttendanceChart(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildLegendItem(Colors.green, 'Présent (85%)'),
                              _buildLegendItem(Colors.red, 'Absent (10%)'),
                              _buildLegendItem(Colors.orange, 'Retard (5%)'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Meilleurs étudiants
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Top 3 des étudiants',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ..._topStudents.map((student) {
                            return Column(
                              children: [
                                _buildTopStudentCard(student),
                                if (_topStudents.indexOf(student) < _topStudents.length - 1)
                                  const Divider(),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Analyses détaillées
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Analyses détaillées',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SecondaryButton(
                            text: 'Analyse par matière',
                            onPressed: () {
                              // TODO: Naviguer vers analyse par matière
                            },
                            fullWidth: true,
                            icon: Icons.subject,
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Analyse par classe',
                            onPressed: () {
                              // TODO: Naviguer vers analyse par classe
                            },
                            fullWidth: true,
                            icon: Icons.school,
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Rapport détaillé',
                            onPressed: () {
                              // TODO: Générer rapport
                            },
                            fullWidth: true,
                            icon: Icons.assessment,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: 'Exporter les statistiques',
                            onPressed: () {
                              // TODO: Exporter
                            },
                            icon: Icons.download,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Partager',
                            onPressed: () {
                              // TODO: Partager
                            },
                            icon: Icons.share,
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

  Widget _buildTrendChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        size: const Size(double.infinity, 150),
        painter: _TrendChartPainter(data: _gradeTrend),
      ),
    );
  }

  Widget _buildAttendanceChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: CustomPaint(
        size: const Size(double.infinity, 150),
        painter: _PieChartPainter(data: _attendanceStats),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTopStudentCard(Map<String, dynamic> student) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${_topStudents.indexOf(student) + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ),
      title: Text(student['name']),
      subtitle: Text('Moyenne: ${student['average']}/20'),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          student['improvement'],
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// TODO: Déplacer dans widgets/stateless_widgets/
class _TrendChartPainter extends CustomPainter {
  final List<double> data;
  
  _TrendChartPainter({required this.data});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    
    final points = <Offset>[];
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;
    
    for (int i = 0; i < data.length; i++) {
      final x = (size.width / (data.length - 1)) * i;
      final y = size.height - ((data[i] - minValue) / range) * size.height;
      points.add(Offset(x, y));
    }
    
    // Dessiner la ligne
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
    
    // Dessiner les points
    final pointPaint = Paint()
      ..color = AppTheme.primaryColor
      ..style = PaintingStyle.fill;
    
    for (final point in points) {
      canvas.drawCircle(point, 4, pointPaint);
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _PieChartPainter extends CustomPainter {
  final Map<String, int> data;
  
  _PieChartPainter({required this.data});
  
  @override
  void paint(Canvas canvas, Size size) {
    final total = data.values.reduce((a, b) => a + b);
    final colors = [Colors.green, Colors.red, Colors.orange];
    
    double startAngle = -90 * (3.1415926535 / 180);
    int colorIndex = 0;
    
    for (final entry in data.entries) {
      final sweepAngle = (entry.value / total) * 360 * (3.1415926535 / 180);
      
      final paint = Paint()
        ..color = colors[colorIndex % colors.length]
        ..style = PaintingStyle.fill;
      
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width - 20,
          height: size.height - 20,
        ),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      
      startAngle += sweepAngle;
      colorIndex++;
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}