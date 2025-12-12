import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/scrollable_content.dart';
import 'package:parametragesschool/widgets/stateless_widgets/section_title.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/info_card.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  final bool showConsent;
  
  const PrivacyPolicyScreen({
    super.key,
    this.showConsent = false,
  });

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool _dataCollectionConsent = false;
  bool _marketingConsent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Politique de confidentialité'),
            Expanded(
              child: ScrollableContent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Dernière mise à jour : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: 'Collecte des données'),
                    const SizedBox(height: 16),
                    
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Données personnelles collectées',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nous collectons les informations suivantes :\n\n'
                            '• Informations de compte (nom, email)\n'
                            '• Données des élèves (nom, prénom, classe)\n'
                            '• Notes et évaluations\n'
                            '• Données d\'utilisation de l\'application',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: 'Utilisation des données'),
                    const SizedBox(height: 16),
                    
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Finalités du traitement',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Vos données sont utilisées pour :\n\n'
                            '• Fournir les services de gestion scolaire\n'
                            '• Communiquer les informations importantes\n'
                            '• Améliorer l\'application\n'
                            '• Respecter nos obligations légales',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: 'Protection des données'),
                    const SizedBox(height: 16),
                    
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mesures de sécurité',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nous mettons en œuvre :\n\n'
                            '• Chiffrement des données sensibles\n'
                            '• Contrôles d\'accès stricts\n'
                            '• Sauvegardes régulières\n'
                            '• Audit de sécurité annuel',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: 'Vos droits'),
                    const SizedBox(height: 16),
                    
                    InfoCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Droits RGPD',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Vous avez le droit de :\n\n'
                            '• Accéder à vos données\n'
                            '• Rectifier les informations inexactes\n'
                            '• Supprimer vos données\n'
                            '• Limiter le traitement\n'
                            '• Vous opposer au traitement',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    if (widget.showConsent) ...[
                      const SizedBox(height: 32),
                      
                      InfoCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Préférences de confidentialité',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            SwitchListTile(
                              title: const Text(
                                'Collecte de données d\'utilisation',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: const Text(
                                'Aidez-nous à améliorer l\'application',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: _dataCollectionConsent,
                              onChanged: (value) {
                                setState(() {
                                  _dataCollectionConsent = value;
                                });
                              },
                              activeColor: AppTheme.primaryColor,
                            ),
                            
                            const SizedBox(height: 8),
                            
                            SwitchListTile(
                              title: const Text(
                                'Communications marketing',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: const Text(
                                'Recevoir des nouvelles et offres',
                                style: TextStyle(fontSize: 13),
                              ),
                              value: _marketingConsent,
                              onChanged: (value) {
                                setState(() {
                                  _marketingConsent = value;
                                });
                              },
                              activeColor: AppTheme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      PrimaryButton(
                        text: 'Enregistrer les préférences',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        fullWidth: true,
                      ),
                    ],
                    
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
}