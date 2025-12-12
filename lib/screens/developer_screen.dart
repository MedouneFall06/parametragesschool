import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
// TODO: Importer les services de développement

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({super.key});

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  bool _devModeEnabled = false;
  bool _showDebugInfo = false;
  bool _mockApiResponses = false;
  String _apiEndpoint = 'https://api.parametragesschool.com/v1';
  String _logLevel = 'debug';
  
  // TODO: Remplacer par ViewModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Options développeur'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avertissement
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.warningColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.warningColor),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.warning, color: AppTheme.warningColor),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Ces options sont destinées aux développeurs. '
                              'Les modifications peuvent affecter le comportement de l\'application.',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Mode développeur
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mode développeur',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Activer le mode développeur'),
                            subtitle: const Text('Afficher les outils de développement'),
                            value: _devModeEnabled,
                            onChanged: (value) {
                              setState(() {
                                _devModeEnabled = value;
                              });
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Afficher les infos de débogage'),
                            subtitle: const Text('Montrer les informations de débogage en surimpression'),
                            value: _showDebugInfo,
                            onChanged: _devModeEnabled ? (value) {
                              setState(() {
                                _showDebugInfo = value;
                              });
                            } : null,
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Simuler les réponses API'),
                            subtitle: const Text('Utiliser des données mockées pour les tests'),
                            value: _mockApiResponses,
                            onChanged: _devModeEnabled ? (value) {
                              setState(() {
                                _mockApiResponses = value;
                              });
                            } : null,
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Configuration API
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Configuration API',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: _apiEndpoint,
                            decoration: const InputDecoration(
                              labelText: 'Endpoint API',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: _devModeEnabled ? (value) {
                              setState(() {
                                _apiEndpoint = value;
                              });
                            } : null,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _logLevel,
                            decoration: const InputDecoration(
                              labelText: 'Niveau de log',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'debug',
                                child: Text('Debug'),
                              ),
                              DropdownMenuItem(
                                value: 'info',
                                child: Text('Info'),
                              ),
                              DropdownMenuItem(
                                value: 'warning',
                                child: Text('Warning'),
                              ),
                              DropdownMenuItem(
                                value: 'error',
                                child: Text('Error'),
                              ),
                            ],
                            onChanged: _devModeEnabled ? (value) {
                              setState(() {
                                _logLevel = value!;
                              });
                            } : null,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Outils de test
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Outils de test',
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
                                  text: 'Tester connexion API',
                                  onPressed: _devModeEnabled ? () {
                                    _testApiConnection();
                                  } : null,
                                  icon: Icons.wifi,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Vider le cache',
                                  onPressed: _devModeEnabled ? () {
                                    _clearCache();
                                  } : null,
                                  icon: Icons.delete,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Logs détaillés',
                                  onPressed: _devModeEnabled ? () {
                                    _showDetailedLogs();
                                  } : null,
                                  icon: Icons.list,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Tester erreurs',
                                  onPressed: _devModeEnabled ? () {
                                    _testErrors();
                                  } : null,
                                  icon: Icons.bug_report,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Performance
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Performance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SecondaryButton(
                            text: 'Lancer le profiler',
                            onPressed: _devModeEnabled ? () {
                              _startProfiler();
                            } : null,
                            fullWidth: true,
                            icon: Icons.speed,
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Tester la mémoire',
                            onPressed: _devModeEnabled ? () {
                              _testMemory();
                            } : null,
                            fullWidth: true,
                            icon: Icons.memory,
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Analyser les performances',
                            onPressed: _devModeEnabled ? () {
                              _analyzePerformance();
                            } : null,
                            fullWidth: true,
                            icon: Icons.analytics,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Base de données
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Base de données',
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
                                  text: 'Explorer BDD',
                                  onPressed: _devModeEnabled ? () {
                                    _exploreDatabase();
                                  } : null,
                                  icon: Icons.storage,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SecondaryButton(
                                  text: 'Réinitialiser BDD',
                                  onPressed: _devModeEnabled ? () {
                                    _showResetDbDialog(context);
                                  } : null,
                                  icon: Icons.restore,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Exporter schéma BDD',
                            onPressed: _devModeEnabled ? () {
                              _exportDbSchema();
                            } : null,
                            fullWidth: true,
                            icon: Icons.schema,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Informations système
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Informations système',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildSystemInfoItem('Version Flutter', '3.16.0'),
                          const Divider(),
                          _buildSystemInfoItem('Dart SDK', '3.2.0'),
                          const Divider(),
                          _buildSystemInfoItem('Platforme', 'Android/iOS'),
                          const Divider(),
                          _buildSystemInfoItem('Build ID', '2024.01.001'),
                          const Divider(),
                          _buildSystemInfoItem('Package', 'parametragesschool'),
                          const Divider(),
                          _buildSystemInfoItem('UID', 'a1b2c3d4-e5f6-7890'),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Actions dangereuses
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.errorColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.errorColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Zone dangereuse',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.errorColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Ces actions peuvent causer la perte de données ou rendre l\'application instable.',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          PrimaryButton(
                            text: 'Réinitialiser toutes les données',
                            onPressed: _devModeEnabled ? () {
                              _showFactoryResetDialog(context);
                            } : null,
                            fullWidth: true,
                            icon: Icons.warning,
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

  Widget _buildSystemInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _testApiConnection() {
    // TODO: Tester connexion API
  }

  void _clearCache() {
    // TODO: Vider le cache
  }

  void _showDetailedLogs() {
    // TODO: Afficher logs détaillés
  }

  void _testErrors() {
    // TODO: Tester erreurs
  }

  void _startProfiler() {
    // TODO: Démarrer profiler
  }

  void _testMemory() {
    // TODO: Tester mémoire
  }

  void _analyzePerformance() {
    // TODO: Analyser performances
  }

  void _exploreDatabase() {
    // TODO: Explorer BDD
  }

  void _exportDbSchema() {
    // TODO: Exporter schéma
  }

  void _showResetDbDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialiser la base de données'),
        content: const Text(
          'Cette action supprimera toutes les données locales et réinstallera le schéma. '
          'Cette opération est irréversible. Continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Réinitialiser',
            onPressed: () {
              Navigator.pop(context);
              // TODO: Réinitialiser BDD
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }

  void _showFactoryResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Réinitialisation d\'usine'),
        content: const Text(
          'Cette action supprimera TOUTES les données, y compris les comptes utilisateurs, '
          'les étudiants, les notes, etc. L\'application sera remise à l\'état d\'origine. '
          'Êtes-vous ABSOLUMENT sûr ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Réinitialiser complètement',
            onPressed: () {
              Navigator.pop(context);
              // TODO: Réinitialisation complète
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }
}