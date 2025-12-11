import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/faq_item.dart';
import 'package:parametragesschool/widgets/stateless_widgets/contact_card.dart';
import 'package:parametragesschool/widgets/stateless_widgets/support_option_tile.dart';
import 'package:parametragesschool/widgets/stateless_widgets/email_launcher_button.dart';

class HelpSupportScreen extends StatelessWidget { 
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(title: 'Aide & Support'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ContactCard(),
                    const SizedBox(height: 24),
                    
                    Text(
                      'Options de support',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    const SupportOptionTile(
                      icon: Icons.phone,
                      title: 'Support téléphonique',
                      subtitle: 'Appelez notre équipe support',
                      value: '+33 1 23 45 67 89',
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 12),
                    
                    const SupportOptionTile(
                      icon: Icons.chat,
                      title: 'Chat en direct',
                      subtitle: 'Discutez avec un agent',
                      value: 'Disponible 9h-18h',
                      color: AppTheme.accentColor,
                    ),
                    const SizedBox(height: 12),
                    
                    SupportOptionTile(
                      icon: Icons.email,
                      title: 'Email de support',
                      subtitle: 'Envoyez-nous un email',
                      value: 'support@parametragesschool.com',
                      color: AppTheme.secondaryColor,
                      /*onTap: () {
                        launchUrl(Uri.parse('mailto:support@parametragesschool.com'));
                      },*/
                    ),
                    const SizedBox(height: 24),
                    
                    Text(
                      'FAQ - Questions fréquentes',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    
                    const FAQItem(
                      question: 'Comment réinitialiser mon mot de passe ?',
                      answer: 'Allez dans la page de connexion, cliquez sur "Mot de passe oublié" et suivez les instructions envoyées par email.',
                    ),
                    const SizedBox(height: 12),
                    
                    const FAQItem(
                      question: 'Comment ajouter un nouvel élève ?',
                      answer: 'Accédez à la section "Élèves", cliquez sur le bouton "+" et remplissez le formulaire avec les informations de l\'élève.',
                    ),
                    const SizedBox(height: 12),
                    
                    const FAQItem(
                      question: 'L\'application fonctionne-t-elle hors ligne ?',
                      answer: 'Oui, vous pouvez utiliser la plupart des fonctionnalités hors ligne. Les données seront synchronisées automatiquement lors de la reconnexion.',
                    ),
                    const SizedBox(height: 12),
                    
                    const FAQItem(
                      question: 'Comment exporter les données ?',
                      answer: 'Allez dans les paramètres, section "Export des données", choisissez le format (PDF ou Excel) et sélectionnez les données à exporter.',
                    ),
                    const SizedBox(height: 24),
                    
                    const EmailLauncherButton(),
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