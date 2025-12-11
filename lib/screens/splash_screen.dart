import 'package:flutter/material.dart';
import 'package:parametragesschool/core/theme/app_theme.dart';
import 'package:parametragesschool/widgets/stateless_widgets/logo_widget.dart';
import 'package:parametragesschool/widgets/stateless_widgets/app_name_widget.dart';
import 'package:parametragesschool/widgets/stateless_widgets/loading_indicator.dart';
import 'package:parametragesschool/widgets/stateless_widgets/version_badge.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const LogoWidget(size: 120),
            const SizedBox(height: 24),
            const AppNameWidget(),
            const Spacer(flex: 1),
            const LoadingIndicator(),
            const SizedBox(height: 32),
            const VersionBadge(),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}