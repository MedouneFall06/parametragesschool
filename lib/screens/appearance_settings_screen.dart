import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

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
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Theme Toggle
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thème',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SwitchListTile(
                            title: Text(
                              'Mode sombre',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              ),
                            ),
                            subtitle: Text(
                              'Activer le thème sombre',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                              ),
                            ),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Color Palette
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Palette de couleurs',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Choisissez la couleur principale de l\'application',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          SizedBox(
                            height: AppConstants.heightPercentage(context, AppConstants.avatarSize),
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
                                    margin: EdgeInsets.only(right: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
                                          height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
                                          decoration: BoxDecoration(
                                            color: _colorPalette[index],
                                            shape: BoxShape.circle,
                                            border: _selectedColorIndex == index
                                                ? Border.all(
                                                    color: AppTheme.primaryColor,
                                                    width: AppConstants.borderWidth,
                                                  )
                                                : null,
                                          ),
                                        ),
                                        SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                                        Text(
                                          _colorNames[index],
                                          style: TextStyle(
                                            fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
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
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Font Size
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Taille de police',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Row(
                            children: [
                              Icon(Icons.text_decrease, color: AppTheme.textSecondary, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
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
                              Icon(Icons.text_increase, color: AppTheme.textSecondary, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Petit', style: TextStyle(color: AppTheme.textSecondary, fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize))),
                              Text('Moyen', style: TextStyle(color: AppTheme.textSecondary, fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize))),
                              Text('Grand', style: TextStyle(color: AppTheme.textSecondary, fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Preview Card
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aperçu',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          _buildPreviewCard(context),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Apply Button
                    PrimaryButton(
                      text: 'Appliquer les changements',
                      onPressed: () {
                        // Appliquer les préférences
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Préférences d\'apparence enregistrées',
                              style: TextStyle(
                                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                              ),
                            ),
                          ),
                        );
                      },
                      fullWidth: true,
                      icon: Icons.check_circle,
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                    
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

  Widget _buildPreviewCard(BuildContext context) {
    return Card(
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
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
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Text(
              'Ceci est un texte d\'exemple pour montrer la taille de police sélectionnée.',
              style: TextStyle(
                fontSize: _fontSize,
                color: _isDarkMode ? Colors.grey[300] : AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                    vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                  ),
                  decoration: BoxDecoration(
                    color: _colorPalette[_selectedColorIndex],
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  child: Text(
                    'Bouton',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _fontSize,
                    ),
                  ),
                ),
                SizedBox(width: AppConstants.widthPercentage(context, AppConstants.spacingSmall)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
                    vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: _colorPalette[_selectedColorIndex]),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
