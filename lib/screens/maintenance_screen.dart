import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';
import 'package:parametragesschool/core/constant/constants.dart';

class MaintenanceScreen extends StatefulWidget {
  final DateTime? estimatedEndTime;
  
  const MaintenanceScreen({
    super.key,
    this.estimatedEndTime,
  });

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  late Duration _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.estimatedEndTime?.difference(DateTime.now()) ?? const Duration(hours: 2);
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
          if (_remainingTime.isNegative) {
            _remainingTime = Duration.zero;
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
              _buildMaintenanceIllustration(),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Maintenance en cours',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: AppConstants.fixedHeightSmall),
              
              // Message
              Text(
                'L\'application est temporairement indisponible pour maintenance programmée. '
                'Nous travaillons pour améliorer votre expérience.',
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Countdown Timer
              if (_remainingTime > Duration.zero) ...[
                _buildCountdownTimer(),
                const SizedBox(height: 32),
              ],
              
              // Contact Admin Card
              _buildContactAdminCard(),
              
              const SizedBox(height: 32),
              
              // Buttons
              PrimaryButton(
                text: 'Rafraîchir',
                onPressed: () {
                  // Vérifier si la maintenance est terminée
                },
                fullWidth: true,
                icon: Icons.refresh,
              ),
              
              const SizedBox(height: 16),
              
              SecondaryButton(
                text: 'Vérifier le statut',
                onPressed: () {
                  // Ouvrir page de statut
                },
                fullWidth: true,
                icon: Icons.info_outline,
              ),
              
              const SizedBox(height: 24),
              
              // Additional Info
              Text(
                'Nous nous excusons pour la gêne occasionnée. '
                'Merci de votre patience.',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMaintenanceIllustration() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: AppTheme.infoColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.engineering,
        size: 70,
        color: AppTheme.infoColor,
      ),
    );
  }

  Widget _buildCountdownTimer() {
    final hours = _remainingTime.inHours;
    final minutes = _remainingTime.inMinutes.remainder(60);
    final seconds = _remainingTime.inSeconds.remainder(60);

    return Column(
      children: [
        const Text(
          'Temps estimé avant retour :',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimeUnit('${hours.toString().padLeft(2, '0')}', 'Heures'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ':',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            _buildTimeUnit('${minutes.toString().padLeft(2, '0')}', 'Minutes'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ':',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            _buildTimeUnit('${seconds.toString().padLeft(2, '0')}', 'Secondes'),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildContactAdminCard() {
    return InfoCard(
      child: Column(
        children: [
          const Icon(
            Icons.help_outline,
            size: 40,
            color: AppTheme.infoColor,
          ),
          const SizedBox(height: 12),
          const Text(
            'Besoin d\'aide ?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Contactez l\'administrateur pour plus d\'informations.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'Envoyer un email',
            onPressed: () {
              // Ouvrir email
            },
            fullWidth: true,
            icon: Icons.email,
          ),
        ],
      ),
    );
  }
}
