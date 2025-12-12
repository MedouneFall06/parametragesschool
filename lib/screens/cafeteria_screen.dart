import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter CafeteriaViewModel
                    // TODO: Connecter à l'API cantine
                    
                    // Date and Meal Selection
                    InfoCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
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
                                      ),
                                      const Icon(Icons.calendar_today, size: 18),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SecondaryButton(
                                text: 'Aujourd\'hui',
                                onPressed: () {
                                  setState(() {
                                    _selectedDate = DateTime.now();
                                  });
                                },
                                fullWidth: false,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildMealButton('Petit-déjeuner', 'breakfast'),
                              const SizedBox(width: 8),
                              _buildMealButton('Déjeuner', 'lunch'),
                              const SizedBox(width: 8),
                              _buildMealButton('Goûter', 'snack'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
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
                                style: const TextStyle(
                                  fontSize: 18,
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
                          const SizedBox(height: 16),
                          // TODO: Remplacer par données dynamiques
                          _buildMenuItem(
                            name: 'Salade composée',
                            description: 'Salade verte, tomates, concombres',
                            type: 'vegetarian',
                            calories: '180 cal',
                          ),
                          const Divider(),
                          _buildMenuItem(
                            name: 'Poulet rôti',
                            description: 'Poulet fermier avec légumes de saison',
                            type: 'main',
                            calories: '350 cal',
                          ),
                          const Divider(),
                          _buildMenuItem(
                            name: 'Purée de pommes de terre',
                            description: 'Purée maison',
                            type: 'side',
                            calories: '200 cal',
                          ),
                          const Divider(),
                          _buildMenuItem(
                            name: 'Fruit de saison',
                            description: 'Pomme ou banane',
                            type: 'dessert',
                            calories: '80 cal',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Nutrition Information
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informations nutritionnelles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.5,
                            children: [
                              _buildNutritionInfo(
                                label: 'Calories totales',
                                value: '810 cal',
                                color: AppTheme.primaryColor,
                              ),
                              _buildNutritionInfo(
                                label: 'Protéines',
                                value: '42g',
                                color: AppTheme.accentColor,
                              ),
                              _buildNutritionInfo(
                                label: 'Glucides',
                                value: '85g',
                                color: AppTheme.secondaryColor,
                              ),
                              _buildNutritionInfo(
                                label: 'Lipides',
                                value: '28g',
                                color: AppTheme.warningColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Ce menu respecte les recommandations nutritionnelles pour les élèves.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Reservations
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mes réservations',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                'Cette semaine: 3/5',
                                style: TextStyle(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // TODO: Remplacer par ListView.builder
                          _buildReservationItem(
                            date: 'Lundi 15 Janv',
                            meal: 'Déjeuner',
                            status: 'confirmed',
                            students: '2 élèves',
                          ),
                          const Divider(),
                          _buildReservationItem(
                            date: 'Mardi 16 Janv',
                            meal: 'Déjeuner',
                            status: 'pending',
                            students: '1 élève',
                          ),
                          const Divider(),
                          _buildReservationItem(
                            date: 'Mercredi 17 Janv',
                            meal: 'Petit-déjeuner',
                            status: 'cancelled',
                            students: '0 élève',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Allergies and Preferences
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Allergies et préférences',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildDietaryTag('Sans gluten', true),
                              _buildDietaryTag('Végétarien', false),
                              _buildDietaryTag('Sans lactose', true),
                              _buildDietaryTag('Halal', false),
                              _buildDietaryTag('Sans porc', true),
                            ],
                          ),
                          const SizedBox(height: 16),
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
                    
                    const SizedBox(height: 24),
                    
                    // Cafeteria Statistics
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        _buildCafeteriaStat(
                          label: 'Repas servis',
                          value: '156',
                          period: 'aujourd\'hui',
                        ),
                        _buildCafeteriaStat(
                          label: 'Taux de remplissage',
                          value: '78%',
                          period: 'ce midi',
                        ),
                        _buildCafeteriaStat(
                          label: 'Satisfaction',
                          value: '4.2/5',
                          period: 'moyenne',
                        ),
                        _buildCafeteriaStat(
                          label: 'Gaspillage',
                          value: '12%',
                          period: 'réduit de 5%',
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Meal Planning
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Planning des menus',
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
                                  text: 'Voir semaine',
                                  onPressed: () {
                                    // TODO: Voir planning semaine
                                  },
                                  icon: Icons.calendar_view_week,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Télécharger menu',
                                  onPressed: () {
                                    // TODO: Télécharger menu
                                  },
                                  icon: Icons.download,
                                ),
                              ),
                            ],
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

  Widget _buildMealButton(String label, String meal) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedMeal == meal,
      onSelected: (selected) {
        setState(() {
          _selectedMeal = meal;
        });
      },
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: _selectedMeal == meal ? Colors.white : AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildMenuItem({
    required String name,
    required String description,
    required String type,
    required String calories,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getMealTypeColor(type).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getMealTypeIcon(type),
          color: _getMealTypeColor(type),
          size: 20,
        ),
      ),
      title: Text(name),
      subtitle: Text(description),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            calories,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getMealTypeColor(type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _getMealTypeLabel(type),
              style: TextStyle(
                fontSize: 10,
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
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
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
    );
  }

  Widget _buildReservationItem({
    required String date,
    required String meal,
    required String status,
    required String students,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getReservationColor(status).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.restaurant,
          color: _getReservationColor(status),
        ),
      ),
      title: Text('$date - $meal'),
      subtitle: Text(students),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getReservationColor(status).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _getReservationLabel(status),
          style: TextStyle(
            fontSize: 12,
            color: _getReservationColor(status),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDietaryTag(String label, bool active) {
    return FilterChip(
      label: Text(label),
      selected: active,
      onSelected: (selected) {
        // TODO: Modifier préférence
      },
      selectedColor: active ? AppTheme.successColor : Colors.grey[300],
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildCafeteriaStat({
    required String label,
    required String value,
    required String period,
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
            period,
            style: const TextStyle(
              fontSize: 12,
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