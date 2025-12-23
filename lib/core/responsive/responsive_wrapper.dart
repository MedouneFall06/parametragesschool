import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // Détecter si c'est mobile ou ordi
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 && 
                    MediaQuery.of(context).size.width < 1200;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          // Padding adaptatif
          padding: padding ?? EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : isTablet ? 24 : 32,
            vertical: isMobile ? 16 : 20,
          ),
          child: ConstrainedBox(
            // ÉVITE LE DÉBORDEMENT
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
      },
    );
  }
}