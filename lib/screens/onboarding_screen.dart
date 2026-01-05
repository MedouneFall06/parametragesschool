import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/page_header.dart';
import 'package:parametragesschool/widgets/stateless_widgets/onboarding_slide.dart';
import 'package:parametragesschool/widgets/stateless_widgets/dot_indicator.dart';
import 'package:parametragesschool/widgets/stateless_widgets/primary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/secondary_button.dart';
import 'package:parametragesschool/widgets/stateless_widgets/skip_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<Map<String, dynamic>> slides = [
    {
      'title': 'Gestion Scolaire Simplifiée',
      'description': 'Gérez facilement les élèves, les notes et les emplois du temps en un seul endroit.',
      'icon': Icons.school,
      'color': AppTheme.primaryColor,
    },
    {
      'title': 'Suivi en Temps Réel',
      'description': 'Accédez aux informations en temps réel et recevez des notifications importantes.',
      'icon': Icons.timeline,
      'color': AppTheme.accentColor,
    },
    {
      'title': 'Synchronisation Hors Ligne',
      'description': 'Travaillez même sans connexion internet, vos données seront synchronisées automatiquement.',
      'icon': Icons.cloud_off,
      'color': AppTheme.secondaryColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const PageHeader(
              title: 'Bienvenue',
              subtitle: 'Découvrez Paramétrages School',
              trailing: SkipButton(), // Utilisez trailing pour le bouton
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingSlide(
                    title: slides[index]['title'],
                    description: slides[index]['description'],
                    icon: slides[index]['icon'],
                    color: slides[index]['color'],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  DotIndicator(
                    currentIndex: _currentPage,
                    itemCount: slides.length,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (_currentPage > 0)
                        Expanded(
                          child: SecondaryButton(
                            text: 'Précédent',
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            fullWidth: false,
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: 12),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            if (_currentPage < slides.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              context.goNamed('login');
                            }
                          },
                          text: _currentPage < slides.length - 1 ? 'Suivant' : 'Commencer',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
