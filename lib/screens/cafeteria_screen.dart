import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';
import 'package:parametragesschool/core/responsive/responsive_grid.dart';

class CafeteriaScreen extends StatefulWidget {
  const CafeteriaScreen({super.key});

  @override
  State<CafeteriaScreen> createState() => _CafeteriaScreenState();
}

class _CafeteriaScreenState extends State<CafeteriaScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedMeal = 'lunch'; // 'breakfast', 'lunch', 'snack'
  final Map<String, String> _mealLabels = {
    'breakfast': 'Petit-déjeuner',
    'lunch': 'Déjeuner',
    'snack': 'Goûter',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Cantine scolaire',
              subtitle: 'Menus et gestion des repas',
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.paddingAll)),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter CafeteriaViewModel
                    // TODO: Connecter à l'API cantine
                    
                    // Date and Meal Selection
                    InfoCard(
                      child: Column(
                        children: [
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: _selectedDate,
                                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                                    lastDate: DateTime.now().add(const Duration(days: 30)),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _selectedDate = picked;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.textPrimary,
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                      style: TextStyle(
                                        fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                      ),
                                    ),
                                    Icon(Icons.calendar_today, size: AppConstants.widthPercentage(context, AppConstants.smallIconSize)),
                                  ],
                                ),
                              ),
                              SecondaryButton(
                                text: 'Aujourd\'hui',
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = DateTime.now();
                                  });
                                },
                                fullWidth: true,
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          ResponsiveGrid(
                            customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenItems),
                            children: [
                              _buildMealButton(context, 'Petit-déjeuner', 'breakfast'),
                              _buildMealButton(context, 'Déjeuner', 'lunch'),
                              _buildMealButton(context, 'Goûter', 'snack'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Today's Menu
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Menu du ${_mealLabels[_selectedMeal]!}',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              PrimaryButton(
                                text: 'Réserver',
                                onPressed: () {
                                  // TODO: Réserver repas
                                },
                                fullWidth: false,
                                icon: Icons.restaurant,
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          // TODO: Remplacer par données dynamiques
                          _buildMenuItem(
                            context: context,
                            name: 'Salade composée',
                            description: 'Salade verte, tomates, concombres',
                            type: 'vegetarian',
                            calories: '180 cal',
                          ),
                          const Divider(),
                          _buildMenuItem(
                            context: context,
                            name: 'Poulet rôti',
                            description: 'Poulet fermier avec légumes de saison',
                            type: 'main',
                            calories: '350 cal',
                          ),
                          const Divider(),
                          _buildMenuItem(
                            context: context,
                            name: 'Purée de pommes de terre',
                            description: 'Purée maison',
                            type: 'side',
                            calories: '200 cal',
                          ),
                          const Divider(),
                          _buildMenuItem(
                            context: context,
                            name: 'Fruit de saison',
                            description: 'Pomme ou banane',
                            type: 'dessert',
                            calories: '80 cal',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Nutrition Information
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informations nutritionnelles',
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
                              _buildNutritionInfo(
                                context: context,
                                label: 'Calories totales',
                                value: '810 cal',
                                color: AppTheme.primaryColor,
                              ),
                              _buildNutritionInfo(
                                context: context,
                                label: 'Protéines',
                                value: '42g',
                                color: AppTheme.accentColor,
                              ),
                              _buildNutritionInfo(
                                context: context,
                                label: 'Glucides',
                                value: '85g',
                                color: AppTheme.secondaryColor,
                              ),
                              _buildNutritionInfo(
                                context: context,
                                label: 'Lipides',
                                value: '28g',
                                color: AppTheme.warningColor,
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          Text(
                            'Ce menu respecte les recommandations nutritionnelles pour les élèves.',
                            style: TextStyle(
                              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                              color: AppTheme.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Reservations
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mes réservations',
                                style: TextStyle(
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                'Cette semaine: 3/5',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          // TODO: Remplacer par ListView.builder
                          _buildReservationItem(
                            context: context,
                            date: 'Lundi 15 Janv',
                            meal: 'Déjeuner',
                            status: 'confirmed',
                            students: '2 élèves',
                          ),
                          const Divider(),
                          _buildReservationItem(
                            context: context,
                            date: 'Mardi 16 Janv',
                            meal: 'Déjeuner',
                            status: 'pending',
                            students: '1 élève',
                          ),
                          const Divider(),
                          _buildReservationItem(
                            context: context,
                            date: 'Mercredi 17 Janv',
                            meal: 'Petit-déjeuner',
                            status: 'cancelled',
                            students: '0 élève',
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Allergies and Preferences
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Allergies et préférences',
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
                              _buildDietaryTag(context, 'Sans gluten', true),
                              _buildDietaryTag(context, 'Végétarien', false),
                              _buildDietaryTag(context, 'Sans lactose', true),
                              _buildDietaryTag(context, 'Halal', false),
                              _buildDietaryTag(context, 'Sans porc', true),
                            ],
                          ),
                          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
                          PrimaryButton(
                            text: 'Gérer les restrictions',
                            onPressed: () {
                              // TODO: Gérer restrictions
                            },
                            fullWidth: true,
                            icon: Icons.medical_services,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Cafeteria Statistics
                    ResponsiveGrid(
                      customSpacing: AppConstants.widthPercentage(context, AppConstants.paddingBetweenStats),
                      children: [
                        _buildCafeteriaStat(
                          context: context,
                          label: 'Repas servis',
                          value: '156',
                          period: 'aujourd\'hui',
                        ),
                        _buildCafeteriaStat(
                          context: context,
                          label: 'Taux de remplissage',
                          value: '78%',
                          period: 'ce midi',
                        ),
                        _buildCafeteriaStat(
                          context: context,
                          label: 'Satisfaction',
                          value: '4.2/5',
                          period: 'moyenne',
                        ),
                        _buildCafeteriaStat(
                          context: context,
                          label: 'Gaspillage',
                          value: '12%',
                          period: 'réduit de 5%',
                        ),
                      ],
                    ),
                    
                    SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingExtraLarge)),
                    
                    // Meal Planning
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Planning des menus',
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
                              SecondaryButton(
                                text: 'Voir semaine',
                                onPressed: () {
                                  // TODO: Voir planning semaine
                                },
                                icon: Icons.calendar_view_week,
                                fullWidth: true,
                              ),
                              PrimaryButton(
                                text: 'Télécharger menu',
                                onPressed: () {
                                  // TODO: Télécharger menu
                                },
                                icon: Icons.download,
                                fullWidth: true,
                              ),
                            ],
                          ),
                        ],
                      ),
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

  Widget _buildMealButton(BuildContext context, String label, String meal) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
      selected: _selectedMeal == meal,
      onSelected: (selected) {
        setState(() {
          _selectedMeal = meal;
        });
      },
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: _selectedMeal == meal ? Colors.white : AppTheme.textPrimary,
        fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String name,
    required String description,
    required String type,
    required String calories,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
        decoration: BoxDecoration(
          color: _getMealTypeColor(type).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getMealTypeIcon(type),
          color: _getMealTypeColor(type),
          size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        description,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.subtitleFontSize),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            calories,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.widthPercentage(context, AppConstants.spacingSmall),
              vertical: AppConstants.heightPercentage(context, AppConstants.spacingSmall),
            ),
            decoration: BoxDecoration(
              color: _getMealTypeColor(type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            child: Text(
              _getMealTypeLabel(type),
              style: TextStyle(
                fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
                color: _getMealTypeColor(type),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo({
    required BuildContext context,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            value,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationItem({
    required BuildContext context,
    required String date,
    required String meal,
    required String status,
    required String students,
  }) {
    return ListTile(
      leading: Container(
        width: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
        height: AppConstants.widthPercentage(context, AppConstants.avatarSize * 0.5),
        decoration: BoxDecoration(
          color: _getReservationColor(status).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.restaurant,
          color: _getReservationColor(status),
          size: AppConstants.widthPercentage(context, AppConstants.smallIconSize),
        ),
      ),
      title: Text(
        '$date - $meal',
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
        ),
      ),
      subtitle: Text(
        students,
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
          color: _getReservationColor(status).withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Text(
          _getReservationLabel(status),
          style: TextStyle(
            fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
            color: _getReservationColor(status),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDietaryTag(BuildContext context, String label, bool active) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
        ),
      ),
      selected: active,
      onSelected: (selected) {
        // TODO: Modifier préférence
      },
      selectedColor: active ? AppTheme.successColor : Colors.grey[300],
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildCafeteriaStat({
    required BuildContext context,
    required String label,
    required String value,
    required String period,
  }) {
    return Container(
      padding: EdgeInsets.all(AppConstants.widthPercentage(context, AppConstants.cardPadding)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
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
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            value,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.titleFontSize),
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: AppConstants.heightPercentage(context, AppConstants.spacingSmall)),
          Text(
            period,
            style: TextStyle(
              fontSize: AppConstants.responsiveFontSize(context, AppConstants.infoFontSize),
              color: AppTheme.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealTypeColor(String type) {
    switch (type) {
      case 'main':
        return AppTheme.primaryColor;
      case 'vegetarian':
        return AppTheme.accentColor;
      case 'side':
        return AppTheme.secondaryColor;
      case 'dessert':
        return AppTheme.warningColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getMealTypeIcon(String type) {
    switch (type) {
      case 'main':
        return Icons.restaurant;
      case 'vegetarian':
        return Icons.eco;
      case 'side':
        return Icons.bakery_dining;
      case 'dessert':
        return Icons.cake;
      default:
        return Icons.fastfood;
    }
  }

  String _getMealTypeLabel(String type) {
    switch (type) {
      case 'main':
        return 'Plat principal';
      case 'vegetarian':
        return 'Végétarien';
      case 'side':
        return 'Accompagnement';
      case 'dessert':
        return 'Dessert';
      default:
        return type;
    }
  }

  Color _getReservationColor(String status) {
    switch (status) {
      case 'confirmed':
        return AppTheme.successColor;
      case 'pending':
        return AppTheme.warningColor;
      case 'cancelled':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getReservationLabel(String status) {
    switch (status) {
      case 'confirmed':
        return 'Confirmé';
      case 'pending':
        return 'En attente';
      case 'cancelled':
        return 'Annulé';
      default:
        return status;
    }
  }
}
