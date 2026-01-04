import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback? onRetry;
  final VoidCallback? onOfflineMode;
  final bool isConnected;
  
  const NoInternetScreen({
    super.key,
    this.onRetry,
    this.onOfflineMode,
    this.isConnected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Illustration
              _buildConnectionIllustration(),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                isConnected ? 'Connexion instable' : 'Pas de connexion internet',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: AppConstants.fixedHeightSmall),
              
              // Message
              Text(
                isConnected 
                  ? 'Votre connexion internet semble instable. Certaines fonctionnalités peuvent être limitées.'
                  : 'Vérifiez votre connexion Wi-Fi ou données mobiles et réessayez.',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Connection Status Indicator
              if (isConnected) ...[
                _buildStatusIndicator(),
                const SizedBox(height: 32),
              ],
              
              // Retry Button
              PrimaryButton(
                text: 'Réessayer la connexion',
                onPressed: onRetry,
                fullWidth: true,
                icon: Icons.refresh,
              ),
              
              const SizedBox(height: 16),
              
              // Offline Mode Button
              SecondaryButton(
                text: 'Continuer hors ligne',
                onPressed: onOfflineMode,
                fullWidth: true,
                icon: Icons.cloud_off,
              ),
              
              const SizedBox(height: 24),
              
              // Tips
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conseils de dépannage :',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildTipItem('Vérifiez le signal Wi-Fi ou données mobiles'),
                    _buildTipItem('Redémarrez votre routeur'),
                    _buildTipItem('Activez/désactivez le mode avion'),
                    _buildTipItem('Vérifiez les paramètres réseau'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionIllustration() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: isConnected 
            ? AppTheme.warningColor.withOpacity(0.1)
            : AppTheme.errorColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isConnected ? Icons.wifi : Icons.wifi_off,
        size: 70,
        color: isConnected ? AppTheme.warningColor : AppTheme.errorColor,
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return Column(
      children: [
        const Text(
          'État de la connexion :',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.warningColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.warningColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: AppTheme.warningColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Connexion instable',
                style: TextStyle(
                  color: AppTheme.warningColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
