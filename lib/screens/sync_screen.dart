import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/stat_card.dart';
// TODO: Importer les modèles nécessaires
// import 'package:parametragesschool/models/offline_sync_model.dart';

class SyncScreen extends StatefulWidget {
  const SyncScreen({super.key});

  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  bool _isSyncing = false;
  int _pendingOperations = 5;
  int _syncedOperations = 42;
  DateTime? _lastSync = DateTime.now().subtract(const Duration(minutes: 30));
  
  // TODO: Remplacer par un vrai ViewModel/Controller
  // TODO: Utiliser OfflineSyncModel et SyncStatusModel

  Future<void> _startSync() async {
    setState(() {
      _isSyncing = true;
    });
    
    // TODO: Implémenter la logique de synchronisation réelle
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isSyncing = false;
      _pendingOperations = 0;
      _syncedOperations += 5;
      _lastSync = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Synchronisation'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statut de synchronisation
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Statut de synchronisation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildSyncStatusIndicator(),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isSyncing ? 'Synchronisation en cours...' : 'À jour',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: _isSyncing 
                                            ? AppTheme.warningColor 
                                            : AppTheme.successColor,
                                      ),
                                    ),
                                    if (_lastSync != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        'Dernière synchro: ${_lastSync!.hour}:${_lastSync!.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Statistiques
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'En attente',
                            value: _pendingOperations.toString(),
                            icon: Icons.pending,
                            color: AppTheme.warningColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StatCard(
                            title: 'Synchronisés',
                            value: _syncedOperations.toString(),
                            icon: Icons.cloud_done,
                            color: AppTheme.successColor,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    StatCard(
                      title: 'Dernière synchro',
                      value: _lastSync != null 
                          ? '${_lastSync!.hour}h${_lastSync!.minute}'
                          : 'Jamais',
                      icon: Icons.access_time,
                      color: AppTheme.infoColor,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Opérations en attente
                    if (_pendingOperations > 0) ...[
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Opérations en attente',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Les opérations suivantes attendent d\'être synchronisées :',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // TODO: Remplacer par ListView.builder avec données réelles
                            _buildPendingOperation(
                              type: 'Nouvel étudiant',
                              details: 'Fall Medoune',
                              time: 'Il y a 15 min',
                            ),
                            const Divider(),
                            _buildPendingOperation(
                              type: 'Note ajoutée',
                              details: 'Mathématiques: 16.5',
                              time: 'Il y a 30 min',
                            ),
                            const Divider(),
                            _buildPendingOperation(
                              type: 'Absence',
                              details: 'Diop Awa - Non justifiée',
                              time: 'Il y a 1h',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                    
                    // Paramètres de synchronisation
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Paramètres',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SwitchListTile(
                            title: const Text('Synchronisation automatique'),
                            subtitle: const Text('Synchroniser automatiquement quand en ligne'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Synchro en arrière-plan'),
                            subtitle: const Text('Continuer la synchro quand l\'app est en arrière-plan'),
                            value: false,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                          const Divider(),
                          SwitchListTile(
                            title: const Text('Données mobiles'),
                            subtitle: const Text('Autoriser la synchro sur réseau mobile'),
                            value: true,
                            onChanged: (value) {
                              // TODO: Implémenter
                            },
                            activeColor: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Boutons d'action
                    if (_isSyncing) ...[
                      PrimaryButton(
                        text: 'Synchronisation en cours...',
                        onPressed: null,
                        fullWidth: true,
                        icon: Icons.sync,
                      ),
                    ] else if (_pendingOperations > 0) ...[
                      PrimaryButton(
                        text: 'Synchroniser maintenant',
                        onPressed: _startSync,
                        fullWidth: true,
                        icon: Icons.sync,
                      ),
                    ] else ...[
                      PrimaryButton(
                        text: 'Vérifier les mises à jour',
                        onPressed: _startSync,
                        fullWidth: true,
                        icon: Icons.cloud_sync,
                      ),
                    ],
                    
                    const SizedBox(height: 16),
                    
                    SecondaryButton(
                      text: 'Forcer la resynchronisation',
                      onPressed: () {
                        // TODO: Implémenter resynchronisation complète
                      },
                      fullWidth: true,
                      icon: Icons.restart_alt,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    SecondaryButton(
                      text: 'Effacer le cache local',
                      onPressed: () {
                        _showClearCacheDialog(context);
                      },
                      fullWidth: true,
                      icon: Icons.delete,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Logs de synchronisation
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Journal de synchronisation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SecondaryButton(
                            text: 'Voir les logs détaillés',
                            onPressed: () {
                              // TODO: Naviguer vers écran de logs
                            },
                            fullWidth: true,
                            icon: Icons.list,
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

  Widget _buildSyncStatusIndicator() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: _isSyncing 
            ? AppTheme.warningColor.withOpacity(0.1)
            : AppTheme.successColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _isSyncing ? Icons.sync : Icons.cloud_done,
        color: _isSyncing ? AppTheme.warningColor : AppTheme.successColor,
        size: 28,
      ),
    );
  }

  Widget _buildPendingOperation({
    required String type,
    required String details,
    required String time,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.warningColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.pending,
          color: AppTheme.warningColor,
          size: 20,
        ),
      ),
      title: Text(type),
      subtitle: Text(details),
      trailing: Text(
        time,
        style: const TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Effacer le cache'),
        content: const Text(
          'Cette action supprimera toutes les données en cache local. '
          'Les données non synchronisées seront perdues. Continuer ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          PrimaryButton(
            text: 'Effacer',
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implémenter effacement du cache
            },
            fullWidth: false,
          ),
        ],
      ),
    );
  }
}