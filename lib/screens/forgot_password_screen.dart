import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/form_text_field.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/back_to_login_link.dart';
import 'package:parametragesschool/widgets/stateless_widgets/success_message_card.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isSubmitted = false;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simuler un appel API
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PageHeader(title: 'Mot de passe oublié'),
                const SizedBox(height: 24),
                
                if (_isSubmitted)
                  const SuccessMessageCard(
                    title: 'Email envoyé !',
                    message: 'Nous avons envoyé un lien de réinitialisation à votre adresse email.',
                    icon: Icons.check_circle,
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Récupération de compte',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Entrez votre adresse email pour recevoir un lien de réinitialisation.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 32),
                      
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            FormTextField(
                              controller: _emailController,
                              label: 'Adresse Email',
                              hintText: 'exemple@ecole.com',
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer votre email';
                                }
                                if (!value.contains('@')) {
                                  return 'Email invalide';
                                }
                                return null;
                              },
                              prefixIcon: Icons.email,
                            ),
                            const SizedBox(height: 24),
                            
                            PrimaryButton(
                              onPressed: _isLoading ? null : _submitForm,
                              text: _isLoading ? 'Envoi en cours...' : 'Envoyer le lien',
                              //isLoading: _isLoading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                
                const SizedBox(height: 32),
                const BackToLoginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}