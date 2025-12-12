import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});

  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  String _selectedView = 'buses'; // 'buses', 'routes', 'students'
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: 'Transport scolaire',
              subtitle: 'Gestion des bus et trajets',
              trailing: PrimaryButton(
                text: 'Nouveau bus',
                onPressed: () {
                  // TODO: Ajouter bus
                },
                fullWidth: false,
                icon: Icons.directions_bus,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // TODO: Remplacer par données dynamiques
                    // TODO: Implémenter TransportViewModel
                    // TODO: Connecter à l'API transport
                    
                    // View Selection
                    InfoCard(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildViewButton('Bus', 'buses'),
                              const SizedBox(width: 8),
                              _buildViewButton('Trajets', 'routes'),
                              const SizedBox(width: 8),
                              _buildViewButton('Élèves', 'students'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDate,
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2025),
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
                      childAspectRatio: 1.2,
                      children: [
                        _buildTransportStat(
                          label: 'Bus actifs',
                          value: '8',
                          icon: Icons.directions_bus,
                        ),
                        _buildTransportStat(
                          label: 'Élèves transportés',
                          value: '156',
                          icon: Icons.people,
                        ),
                        _buildTransportStat(
                          label: 'Trajets quotidiens',
                          value: '16',
                          icon: Icons.route,
                        ),
                        _buildTransportStat(
                          label: 'Ponctualité',
                          value: '92%',
                          icon: Icons.timer,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Bus List
                    if (_selectedView == 'buses') ...[
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Flotte de bus',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // TODO: Remplacer par ListView.builder
                            _buildBusItem(
                              number: 'BUS-001',
                              driver: 'Jean Dupont',
                              capacity: '48 places',
                              status: 'active',
                              currentRoute: 'Ligne A',
                            ),
                            const Divider(),
                            _buildBusItem(
                              number: 'BUS-002',
                              driver: 'Marie Martin',
                              capacity: '52 places',
                              status: 'maintenance',
                              currentRoute: 'Maintenance',
                            ),
                            const Divider(),
                            _buildBusItem(
                              number: 'BUS-003',
                              driver: 'Pierre Bernard',
                              capacity: '45 places',
                              status: 'active',
                              currentRoute: 'Ligne B',
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // Routes List
                    if (_selectedView == 'routes') ...[
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trajets programmés',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildRouteItem(
                              name: 'Ligne A - Matin',
                              time: '07:30 - 08:15',
                              stops: '5 arrêts',
                              students: '42 élèves',
                            ),
                            const Divider(),
                            _buildRouteItem(
                              name: 'Ligne B - Matin',
                              time: '07:45 - 08:30',
                              stops: '6 arrêts',
                              students: '38 élèves',
                            ),
                            const Divider(),
                            _buildRouteItem(
                              name: 'Ligne A - Soir',
                              time: '16:30 - 17:15',
                              stops: '5 arrêts',
                              students: '42 élèves',
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    // Students List
                    if (_selectedView == 'students') ...[
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Élèves transportés',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildStudentTransportItem(
                              name: 'Lucas Martin',
                              classe: 'Terminale S',
                              bus: 'BUS-001',
                              stop: 'Arrêt Centre-ville',
                            ),
                            const Divider(),
                            _buildStudentTransportItem(
                              name: 'Emma Bernard',
                              classe: 'Première L',
                              bus: 'BUS-003',
                              stop: 'Arrêt Gare',
                            ),
                            const Divider(),
                            _buildStudentTransportItem(
                              name: 'Thomas Leroy',
                              classe: 'Seconde',
                              bus: 'BUS-001',
                              stop: 'Arrêt Université',
                            ),
                          ],
                        ),
                      ),
                    ],
                    
                    const SizedBox(height: 24),
                    
                    // Live Tracking
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Suivi en temps réel',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.successColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: AppTheme.successColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      'Actif',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.map, size: 50, color: Colors.grey),
                                  SizedBox(height: 12),
                                  Text(
                                    'Carte des trajets',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Les positions des bus s\'affichent ici',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Actualiser',
                                  onPressed: () {
                                    // TODO: Actualiser positions
                                  },
                                  icon: Icons.refresh,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  text: 'Voir sur carte',
                                  onPressed: () {
                                    // TODO: Ouvrir carte complète
                                  },
                                  icon: Icons.open_in_new,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Notifications
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifications transport',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildTransportNotification(
                            message: 'Bus BUS-001 en retard de 10 minutes',
                            time: 'Aujourd\'hui 07:40',
                            type: 'delay',
                          ),
                          const Divider(),
                          _buildTransportNotification(
                            message: 'Nouvel arrêt ajouté sur la Ligne A',
                            time: 'Hier 16:20',
                            type: 'info',
                          ),
                          const Divider(),
                          _buildTransportNotification(
                            message: 'Maintenance prévue pour BUS-002',
                            time: 'Il y a 2 jours',
                            type: 'maintenance',
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Transport Actions
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Exporter planning',
                            onPressed: () {
                              // TODO: Exporter planning
                            },
                            icon: Icons.download,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Rapport mensuel',
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

  Widget _buildViewButton(String label, String view) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedView == view,
      onSelected: (selected) {
        setState(() {
          _selectedView = view;
        });
      },
      selectedColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: _selectedView == view ? Colors.white : AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildTransportStat({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
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
        ],
      ),
    );
  }

  Widget _buildBusItem({
    required String number,
    required String driver,
    required String capacity,
    required String status,
    required String currentRoute,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: _getStatusColor(status).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.directions_bus,
          color: _getStatusColor(status),
        ),
      ),
      title: Text(number),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chauffeur: $driver'),
          Text('Capacité: $capacity'),
          Text('Trajet: $currentRoute'),
        ],
      ),
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

  Widget _buildRouteItem({
    required String name,
    required String time,
    required String stops,
    required String students,
  }) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.route, color: AppTheme.primaryColor),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Horaires: $time'),
          Text('$stops • $students'),
        ],
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
    );
  }

  Widget _buildStudentTransportItem({
    required String name,
    required String classe,
    required String bus,
    required String stop,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.person, color: AppTheme.primaryColor),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Classe: $classe'),
          Text('Bus: $bus • Arrêt: $stop'),
        ],
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
    );
  }

  Widget _buildTransportNotification({
    required String message,
    required String time,
    required String type,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getNotificationColor(type).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getNotificationIcon(type),
          color: _getNotificationColor(type),
        ),
      ),
      title: Text(message),
      subtitle: Text(time),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return AppTheme.successColor;
      case 'maintenance':
        return AppTheme.warningColor;
      case 'inactive':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'active':
        return 'Actif';
      case 'maintenance':
        return 'Maintenance';
      case 'inactive':
        return 'Inactif';
      default:
        return status;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'delay':
        return AppTheme.warningColor;
      case 'maintenance':
        return AppTheme.errorColor;
      case 'info':
        return AppTheme.infoColor;
      default:
        return AppTheme.primaryColor;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'delay':
        return Icons.schedule;
      case 'maintenance':
        return Icons.engineering;
      case 'info':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }
}