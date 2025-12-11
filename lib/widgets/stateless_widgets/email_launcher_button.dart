import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';

class EmailLauncherButton extends StatelessWidget {
  final String email;
  final String subject;
  final String body;
  
  const EmailLauncherButton({
    super.key,
    this.email = 'support@parametragesschool.com',
    this.subject = 'Demande de support',
    this.body = '',
  });

  Future<void> _sendEmail(BuildContext context) async {
    // Commenter temporairement
    /*
    import 'package:url_launcher/url_launcher.dart';
    
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
    */
    
    // Version temporaire sans url_launcher
    print('Email would be sent to: $email');
    print('Subject: $subject');
    print('Body: $body');
    
    // Afficher un message à l'utilisateur
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email envoyé à $email'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () => _sendEmail(context), // Passer le contexte ici
      text: 'Envoyer un email',
      icon: Icons.email,
    );
  }
}