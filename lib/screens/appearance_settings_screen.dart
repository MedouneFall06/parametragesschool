import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  State<AppearanceSettingsScreen> createState() => _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
  bool _isDarkMode = false;
  double _fontSize = 16.0;
  int _selectedColorIndex = 0;

  final List<Color> _colorPalette = [
    AppTheme.primaryColor,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];

  final List<String> _colorNames = [
    'Bleu original',
    'Bleu vif',
    'Vert',
    'Violet',
    'Orange',
    'Turquoise',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Apparence'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Theme Toggle
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Thème',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SwitchListTile(
                            title: const Text('Mode sombre'),
                            subtitle: const Text('Activer le thème sombre'),
                            value: _isDarkMode,
                            onChanged: (value) {
                              setState(() {
                                _isDarkMode = value;
                              });
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Color Palette
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Palette de couleurs',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Choisissez la couleur principale de l\'application',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _colorPalette.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedColorIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: _colorPalette[index],
                                            shape: BoxShape.circle,
                                            border: _selectedColorIndex == index
                                                ? Border.all(
                                                    color: AppTheme.primaryColor,
                                                    width: 3,
                                                  )
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _colorNames[index],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: _selectedColorIndex == index
                                                ? AppTheme.primaryColor
                                                : AppTheme.textSecondary,
                                            fontWeight: _selectedColorIndex == index
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ],
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
                    
                    // Font Size
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Taille de police',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.text_decrease, color: AppTheme.textSecondary),
                              Expanded(
                                child: Slider(
                                  value: _fontSize,
                                  min: 12,
                                  max: 20,
                                  divisions: 8,
                                  label: _fontSize.round().toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _fontSize = value;
                                    });
                                  },
                                  activeColor: AppTheme.primaryColor,
                                ),
                              ),
                              const Icon(Icons.text_increase, color: AppTheme.textSecondary),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Petit', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Moyen', style: TextStyle(color: AppTheme.textSecondary)),
                              Text('Grand', style: TextStyle(color: AppTheme.textSecondary)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Preview Card
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Aperçu',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildPreviewCard(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Apply Button
                    PrimaryButton(
                      text: 'Appliquer les changements',
                      onPressed: () {
                        // Appliquer les préférences
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Préférences d\'apparence enregistrées'),
                          ),
                        );
                      },
                      fullWidth: true,
                      icon: Icons.check_circle,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Reset Button
                    PrimaryButton(
                      text: 'Réinitialiser',
                      onPressed: () {
                        setState(() {
                          _isDarkMode = false;
                          _fontSize = 16.0;
                          _selectedColorIndex = 0;
                        });
                      },
                      fullWidth: true,
                      icon: Icons.restart_alt,
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

  Widget _buildPreviewCard() {
    return Card(
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Titre d\'exemple',
              style: TextStyle(
                fontSize: _fontSize * 1.5,
                fontWeight: FontWeight.bold,
                color: _isDarkMode ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ceci est un texte d\'exemple pour montrer la taille de police sélectionnée.',
              style: TextStyle(
                fontSize: _fontSize,
                color: _isDarkMode ? Colors.grey[300] : AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _colorPalette[_selectedColorIndex],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Bouton',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _fontSize,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: _colorPalette[_selectedColorIndex]),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Secondaire',
                    style: TextStyle(
                      color: _colorPalette[_selectedColorIndex],
                      fontSize: _fontSize,
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
}