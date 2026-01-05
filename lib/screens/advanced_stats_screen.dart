import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';
import 'package:parametragesschool/core/constant/constants.dart';
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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Filtres
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filtres',
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Période',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  DropdownButtonFormField<String>(
                                    value: _selectedPeriod,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Type de statistiques',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                                    ),
                                  ),
                                  SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                  DropdownButtonFormField<String>(
                                    value: _selectedStatType,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
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
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Statistiques globales
                    Text(
                      'Vue d\'ensemble',
                      style: TextStyle(
                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Moyenne générale',
                          value: '15.8',
                          icon: Icons.trending_up,
                          color: AppTheme.successColor,
                        ),
                        StatCard(
                          title: 'Taux de présence',
                          value: '92%',
                          icon: Icons.people,
                          color: AppTheme.infoColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        StatCard(
                          title: 'Meilleure moyenne',
                          value: '17.2',
                          icon: Icons.emoji_events,
                          color: AppTheme.warningColor,
                        ),
                        StatCard(
                          title: 'Évolution',
                          value: '+2.1%',
                          icon: Icons.show_chart,
                          color: AppTheme.accentColor,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Graphique des tendances
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Évolution des moyennes',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SizedBox(
                            height: AppConstants.heightPercentage(context, AppConstants.paddingBetweenStats * 12.5),
                            child: _buildTrendChart(),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Row(
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Répartition des présences
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Répartition des présences',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SizedBox(
                            height: AppConstants.heightPercentage(context, AppConstants.paddingBetweenStats * 10),
                            child: _buildAttendanceChart(),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              _buildLegendItem(Colors.green, 'Présent (85%)'),
                              _buildLegendItem(Colors.red, 'Absent (10%)'),
                              _buildLegendItem(Colors.orange, 'Retard (5%)'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Meilleurs étudiants
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top 3 des étudiants',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Analyses détaillées
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Analyses détaillées',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SecondaryButton(
                            text: 'Analyse par matière',
                            onPressed: () {
                              // TODO: Naviguer vers analyse par matière
                            },
                            fullWidth: true,
                            icon: Icons.subject,
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SecondaryButton(
                            text: 'Analyse par classe',
                            onPressed: () {
                              // TODO: Naviguer vers analyse par classe
                            },
                            fullWidth: true,
                            icon: Icons.school,
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Actions
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                      children: [
                        PrimaryButton(
                          text: 'Exporter les statistiques',
                          onPressed: () {
                            // TODO: Exporter
                          },
                          icon: Icons.download,
                          fullWidth: true,
                        ),
                        PrimaryButton(
                          text: 'Partager',
                          onPressed: () {
                            // TODO: Partager
                          },
                          icon: Icons.share,
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
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTopStudentCard(Map<String, dynamic> student) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '${_topStudents.indexOf(student) + 1}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              ),
          ),
        ),
      ),
      title: Text(
        student['name'],
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        'Moyenne: ${student['average']}/20',
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
          vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
        ),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          student['improvement'],
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
  bool shouldRepaint(CustomPainter oldDelegate) => true;
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
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
