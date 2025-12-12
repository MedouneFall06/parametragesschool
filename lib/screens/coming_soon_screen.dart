import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class ComingSoonScreen extends StatefulWidget {
  final String featureName;
  final String? featureDescription;
  
  const ComingSoonScreen({
    super.key,
    required this.featureName,
    this.featureDescription,
  });

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Bientôt disponible',
              subtitle: 'Fonctionnalité en développement',
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Feature Preview
                    _buildFeaturePreview(),
                    
                    const SizedBox(height: 32),
                    
                    // Description
                    Text(
                      widget.featureDescription ??
                          'Nous travaillons activement sur cette fonctionnalité '
                          'qui sera disponible prochainement.',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Subscribe Form
                    if (!_isSubscribed) ...[
                      _buildSubscribeForm(),
                      const SizedBox(height: 32),
                    ],
                    
                    // Notification Bell
                    _buildNotificationBell(),
                    
                    const SizedBox(height: 40),
                    
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SecondaryButton(
                            text: 'Retour',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icons.arrow_back,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Voir les avancements',
                            onPressed: () {
                              // Ouvrir blog/updates
                            },
                            icon: Icons.update,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Progress Indicator
                    _buildProgressIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturePreview() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.secondaryColor,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.rocket_launch,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.featureName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.accentColor.withOpacity(0.3)),
              ),
              child: const Text(
                'EN DÉVELOPPEMENT',
                style: TextStyle(
                  color: AppTheme.accentColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscribeForm() {
    return InfoCard(
      child: Column(
        children: [
          const Icon(
            Icons.notifications_active,
            size: 40,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 16),
          const Text(
            'Soyez notifié en premier',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Recevez une notification dès que cette fonctionnalité est disponible.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Votre adresse email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            text: 'S\'inscrire aux notifications',
            onPressed: () {
              if (_emailController.text.isNotEmpty) {
                setState(() {
                  _isSubscribed = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Vous serez notifié quand la fonctionnalité sera disponible'),
                  ),
                );
              }
            },
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationBell() {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: _isSubscribed
                ? AppTheme.successColor.withOpacity(0.1)
                : AppTheme.textSecondary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _isSubscribed ? Icons.notifications : Icons.notifications_none,
            size: 30,
            color: _isSubscribed ? AppTheme.successColor : AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _isSubscribed ? 'Notifications activées' : 'Activer les notifications',
          style: TextStyle(
            color: _isSubscribed ? AppTheme.successColor : AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        const Text(
          'Progression du développement',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 8,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Container(
                height: 8,
                width: 200 * 0.65, // 65% de progression
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.secondaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '65%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
      ],
    );
  }
}