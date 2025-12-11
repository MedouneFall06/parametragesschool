import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/scrollable_content.dart';
import 'package:parametragesschool/widgets/stateless_widgets/section_title.dart';
import 'package:parametragesschool/widgets/stateless_widgets/accept_checkbox.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';

class TermsScreen extends StatefulWidget {
  final bool showAcceptButton;
  
  const TermsScreen({
    super.key,
    this.showAcceptButton = true,
  });

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Conditions d\'utilisation'),
            Expanded(
              child: ScrollableContent(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionTitle(title: 'Acceptation des conditions'),
                    const SizedBox(height: 16),
                    
                    Text(
                      'En utilisant l\'application "Paramétrages School", vous acceptez les conditions d\'utilisation suivantes. Veuillez les lire attentivement.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: '1. Utilisation autorisée'),
                    const SizedBox(height: 12),
                    
                    Text(
                      'L\'application est destinée à la gestion scolaire des établissements éducatifs. '
                      'Vous vous engagez à utiliser l\'application uniquement à des fins légales et conformément '
                      'à sa finalité éducative.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: '2. Protection des données'),
                    const SizedBox(height: 12),
                    
                    Text(
                      'Nous nous engageons à protéger la confidentialité des données des élèves et du personnel. '
                      'Les données sont stockées de manière sécurisée et ne sont pas partagées avec des tiers '
                      'sans consentement explicite.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: '3. Responsabilités de l\'utilisateur'),
                    const SizedBox(height: 12),
                    
                    Text(
                      'Vous êtes responsable de :\n\n'
                      '• La confidentialité de votre compte\n'
                      '• L\'exactitude des informations saisies\n'
                      '• L\'utilisation appropriée des données des élèves\n'
                      '• Le respect des lois sur la protection des données',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: '4. Limitation de responsabilité'),
                    const SizedBox(height: 12),
                    
                    Text(
                      'Nous ne pouvons être tenus responsables des pertes de données dues à une utilisation '
                      'inappropriée ou à des problèmes techniques indépendants de notre volonté. '
                      'Il est recommandé de réaliser des sauvegardes régulières.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: '5. Modifications des conditions'),
                    const SizedBox(height: 12),
                    
                    Text(
                      'Nous nous réservons le droit de modifier ces conditions à tout moment. '
                      'Les utilisateurs seront notifiés des changements importants par email ou '
                      'via une notification dans l\'application.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: '6. Contact'),
                    const SizedBox(height: 12),
                    
                    Text(
                      'Pour toute question concernant ces conditions, veuillez nous contacter à :\n'
                      'contact@parametragesschool.com',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    
                    if (widget.showAcceptButton) ...[
                      const SizedBox(height: 32),
                      AcceptCheckbox(
                        value: _isAccepted,
                        onChanged: (value) {
                          setState(() {
                            _isAccepted = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        onPressed: _isAccepted
                            ? () {
                                Navigator.pop(context);
                              }
                            : null,
                        text: 'Accepter et continuer',
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