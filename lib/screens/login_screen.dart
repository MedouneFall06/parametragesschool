import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/providers/auth_provider.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
// ignore: unused_import
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simuler une authentification
      await Future.delayed(const Duration(seconds: 2));

      // IMPORTANT: Mettre à jour l'état d'authentification
      ref.read(authStateProvider.notifier).state = true;

      setState(() {
        _isLoading = false;
      });

      // Naviguer vers l'écran d'accueil
      //context.go('/home');

    }
  }

  void _handleForgotPassword() {
    context.go('/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageHeader(
                title: 'Connexion',
                subtitle: 'Accédez à votre espace scolaire',
              ),
              
              Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      
                      // Logo de l'application
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Champ Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Adresse email',
                          hintText: 'exemple@ecole.com',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre email';
                          }
                          if (!value.contains('@')) {
                            return 'Email invalide';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Champ Mot de passe
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              // ref.read(authStateProvider.notifier).state=true;
                            },
                          ),
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          if (value.length < 6) {
                            return 'Le mot de passe doit contenir au moins 6 caractères';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Lien "Mot de passe oublié"
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _handleForgotPassword,
                          child: Text(
                            'Mot de passe oublié ?',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Bouton de connexion
                      PrimaryButton(
                        text: _isLoading ? 'Connexion en cours...' : 'Se connecter',
                        onPressed: _isLoading ? null : _handleLogin,
                        fullWidth: true,
                        icon: _isLoading ? null : Icons.login,
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Séparateur
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppTheme.textSecondary.withOpacity(0.3),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Ou',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppTheme.textSecondary.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Informations supplémentaires
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Application de gestion scolaire',
                              style: TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Version 1.0.0',
                              style: TextStyle(
                                color: AppTheme.textSecondary.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}